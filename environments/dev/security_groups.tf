resource "aws_security_group" "efs_service" {
  name        = "wordpress-efs-service"
  description = "wordpress-efs-service"
  vpc_id      = data.aws_subnet.ecs_service_subnet_ids.vpc_id
}

resource "aws_security_group_rule" "efs_service_ingress_nfs_tcp" {
  type                     = "ingress"
  description              = "nfs from efs"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs_service.id
  security_group_id        = aws_security_group.efs_service.id
}


resource "aws_security_group" "ecs_service" {
  name        = "wordpress-ecs-service"
  description = "wordpress ecs service"
  vpc_id      = data.aws_subnet.ecs_service_subnet_ids.vpc_id
}

resource "aws_security_group_rule" "ecs_service_ingress_http" {
  type                     = "ingress"
  description              = "http from load balancer"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb_service.id
  security_group_id        = aws_security_group.ecs_service.id
}

resource "aws_security_group_rule" "ecs_service_ingress_https" {

  type                     = "ingress"
  description              = "https from load balancer"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lb_service.id
  security_group_id        = aws_security_group.ecs_service.id
}

resource "aws_security_group_rule" "ecs_service_egress_http" {
  type              = "egress"
  description       = "http to internet"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_service.id
}

resource "aws_security_group_rule" "ecs_service_egress_https" {
  type              = "egress"
  description       = "https to internet"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_service.id
}

resource "aws_security_group_rule" "ecs_service_egress_mysql" {
  type                     = "egress"
  description              = "mysql"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.rds_cluster.id
  security_group_id        = aws_security_group.ecs_service.id
}

resource "aws_security_group_rule" "ecs_service_egress_efs_tcp" {
  type                     = "egress"
  description              = "efs"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.efs_service.id
  security_group_id        = aws_security_group.ecs_service.id
}

resource "aws_security_group" "lb_service" {
  name        = "wordpress-lb-service"
  description = "wordpress lb service"
  vpc_id      = data.aws_subnet.ecs_service_subnet_ids.vpc_id
}

resource "aws_security_group_rule" "lb_service_ingress_http" {
  type              = "ingress"
  description       = "http"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_service.id
}

resource "aws_security_group_rule" "lb_service_ingress_https" {
  type              = "ingress"
  description       = "http"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_service.id
}

resource "aws_security_group_rule" "lb_service_egress_http" {
  type                     = "egress"
  description              = "http"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs_service.id
  security_group_id        = aws_security_group.lb_service.id
}

resource "aws_security_group_rule" "lb_service_egress_https" {
  type                     = "egress"
  description              = "https"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs_service.id
  security_group_id        = aws_security_group.lb_service.id
}

resource "aws_security_group" "rds_cluster" {
  name        = "wordpress-rds-service"
  description = "wordpress rds service"
  vpc_id      = data.aws_subnet.ecs_service_subnet_ids.vpc_id
}

resource "aws_security_group_rule" "rds_cluster_ingress_mysql" {
  type                     = "ingress"
  description              = "mysql"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs_service.id
  security_group_id        = aws_security_group.rds_cluster.id
}
