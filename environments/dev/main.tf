locals {
  rds_cluster_security_group_ids = [aws_security_group.rds_cluster.id]
  lb_security_group_ids          = [aws_security_group.lb_service.id]
  ecs_service_security_group_ids = [aws_security_group.ecs_service.id]
  efs_service_security_group_ids = [aws_security_group.efs_service.id]
  rds_cluster_engine_version     = data.aws_rds_engine_version.rds_engine_version.version
  name                           = "wordpress"
}

resource "random_password" "db_password" {
  length  = 16
  special = false
}


#========================== VPC Root Module ===================================
module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  name                 = "wordpress"
  cidr                 = "10.0.0.0/16"
  azs                  = ["us-east-1a", "us-east-1b"]
  public_subnets       = ["10.0.0.0/24", "10.0.1.0/24"]
  private_subnets      = ["10.0.2.0/24", "10.0.3.0/24"]
  intra_subnets        = ["10.0.4.0/24", "10.0.5.0/24"]
  database_subnets     = ["10.0.6.0/24", "10.0.7.0/24"]
  enable_nat_gateway   = true
  enable_dns_hostnames = true
}


#========================== RDS Root Module ===================================
module "rds" {
  source = "../../modules/rds"

  db_subnet_group_subnet_ids = module.vpc.database_subnets
  rds_master_password        = random_password.db_password.result
  rds_cluster_engine_version = local.rds_cluster_engine_version
  kms_key_id                 = aws_kms_key.wordpress.arn
  rds_security_group_ids     = local.rds_cluster_security_group_ids
}



#========================== ALB Root Module ===================================
module "alb" {
  source = "../../modules/alb"

  vpc_id                = module.vpc.vpc_id
  lb_security_group_ids = local.lb_security_group_ids
  lb_subnet_ids         = module.vpc.public_subnets
}



#========================== ECS Root Module ===================================
module "ecs" {
  source = "../../modules/ecs"

  container_definitions = templatefile(
    "${path.module}/container_definitions/wordpress.tpl",
    {
      ecs_service_container_name = "wordpress"
      wordpress_db_host          = module.rds.rds_cluster_endpoint
      wordpress_db_user          = "admin"
      wordpress_db_name          = "wordpress"
      aws_region                 = data.aws_region.current.name
      aws_logs_group             = aws_cloudwatch_log_group.wordpress.name
      aws_account_id             = data.aws_caller_identity.current.account_id
      secret_name                = aws_secretsmanager_secret.wordpress.name
      cloudwatch_log_group       = "${local.name}-log-group"
    }
  )
  target_group_arn               = module.alb.target_group_arn
  secret_arn                     = aws_secretsmanager_secret.wordpress.arn
  ecs_service_subnet_ids         = module.vpc.private_subnets
  ecs_service_security_group_ids = local.ecs_service_security_group_ids
  efs_service_security_group_ids = local.efs_service_security_group_ids
  kms_key_arn                    = aws_kms_key.wordpress.arn
}


#========================== Additional Resources ===================================
resource "aws_cloudwatch_log_group" "wordpress" {
  name              = "${local.name}-log-group"
  retention_in_days = 14
  
  kms_key_id        = aws_kms_key.wordpress.arn
  tags = {
    Name = "${local.name}-log-group"
  }
}

resource "aws_secretsmanager_secret" "wordpress" {
  name_prefix = local.name
  description = "Secrets for ECS Wordpress"
  kms_key_id  = aws_kms_key.wordpress.id
  tags = {
    Name = "${local.name}-secret-manager"
  }
}

resource "aws_secretsmanager_secret_version" "wordpress" {
  secret_id = aws_secretsmanager_secret.wordpress.id
  secret_string = jsonencode({
    WORDPRESS_DB_HOST     = module.rds.rds_cluster_endpoint
    WORDPRESS_DB_USER     = "admin"
    WORDPRESS_DB_PASSWORD = random_password.db_password.result
    WORDPRESS_DB_NAME     = "wordpress"
  })
}


resource "aws_kms_key" "wordpress" {
  description             = "KMS Key used to encrypt Wordpress related resources"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms.json
  tags = {
    Name = "${local.name}-kms"
  }
}

resource "aws_kms_alias" "wordpress" {
  name          = "alias/wordpress"
  target_key_id = aws_kms_key.wordpress.id
}
