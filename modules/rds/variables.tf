variable "db_subnet_group_name" {
  description = "If an existing DB subnet group exists, provide the name"
  type        = string
  default     = "wordpress-subnet-group"
}

variable "db_subnet_group_subnet_ids" {
  description = "Subnets to be used in the db subnet group"
  type        = list(string)
  default     = []
}

variable "rds_cluster_identifier" {
  description = "Name of the RDS cluster"
  type        = string
  default     = "wordpress"
}

variable "rds_cluster_backup_retention_period" {
  description = "Number of days to retain backups"
  type        = number
  default     = 1
}

variable "rds_cluster_database_name" {
  description = "Name of the database to create"
  type        = string
  default     = "wordpress"
}

variable "rds_cluster_deletion_protection" {
  description = "If the cluster should have deletion protection enabled"
  type        = bool
  default     = false
}

variable "rds_cluster_enable_cloudwatch_logs_export" {
  description = "Set of log types to export to cloudwatch, valid values are audit, error, general, slowquery, postgresql"
  type        = list(string)
  default     = ["audit"]
}

variable "rds_cluster_engine_version" {
  description = "Engine version to use for the cluster"
  type        = string
  default     = ""
}

variable "rds_cluster_master_username" {
  description = "Master username for the RDS cluster"
  type        = string
  default     = "admin"
}

variable "rds_cluster_preferred_backup_window" {
  description = "The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.  Time in UTC."
  type        = string
  default     = "08:00-09:00"
}

variable "rds_cluster_preferred_maintenance_window" {
  description = "The weekly time range during which system maintenance can occur, in (UTC)."
  type        = string
  default     = "sun:06:00-sun:07:00"
}

variable "rds_cluster_skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted"
  type        = bool
  default     = true
}

variable "rds_cluster_instance_count" {
  description = "Number of RDS instances to provision"
  type        = number
  default     = 2
}

variable "rds_cluster_instance_instance_class" {
  description = "Database instance type"
  type        = string
  default     = "db.t3.small"
}

variable "rds_security_group_ids" {
  description = "RDS Security Group ID."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Map of tags to provide to the resources created"
  type        = map(string)
  default     = {}
}

variable "kms_key_id" {
  description = "KMS Key ID."
  type        = string
  default     = null
}

variable "rds_master_password" {
  description = "Password for the master DB user."
  type        = string
  default     = "password"
}
