resource "aws_db_subnet_group" "db" {
  name       = var.db_subnet_group_name
  subnet_ids = var.db_subnet_group_subnet_ids
  tags       = var.tags
}

resource "aws_rds_cluster" "wordpress" {
  cluster_identifier              = var.rds_cluster_identifier
  backup_retention_period         = var.rds_cluster_backup_retention_period
  copy_tags_to_snapshot           = true
  database_name                   = var.rds_cluster_database_name
  db_subnet_group_name            = aws_db_subnet_group.db.name
  deletion_protection             = var.rds_cluster_deletion_protection
  enabled_cloudwatch_logs_exports = var.rds_cluster_enable_cloudwatch_logs_export
  engine_version                  = var.rds_cluster_engine_version
  engine                          = "aurora-mysql"
  final_snapshot_identifier       = var.rds_cluster_identifier
  kms_key_id                      = var.kms_key_id
  master_password                 = var.rds_master_password
  master_username                 = var.rds_cluster_master_username
  preferred_backup_window         = var.rds_cluster_preferred_backup_window
  preferred_maintenance_window    = var.rds_cluster_preferred_maintenance_window
  storage_encrypted               = true
  skip_final_snapshot             = var.rds_cluster_skip_final_snapshot
  vpc_security_group_ids          = var.rds_security_group_ids
  tags                            = var.tags
}

resource "aws_rds_cluster_instance" "wordpress" {
  count                = var.rds_cluster_instance_count
  identifier           = join("-", [var.rds_cluster_identifier, count.index])
  cluster_identifier   = aws_rds_cluster.wordpress.id
  engine               = aws_rds_cluster.wordpress.engine
  engine_version       = aws_rds_cluster.wordpress.engine_version
  instance_class       = var.rds_cluster_instance_instance_class
  db_subnet_group_name = aws_db_subnet_group.db.name

  tags = var.tags
}

