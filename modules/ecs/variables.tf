variable "ecs_cloudwatch_logs_group_name" {
  description = "Name of the Log Group where ECS logs should be written"
  type        = string
  default     = "/ecs/wordpress"
}

variable "ecs_cluster_name" {
  description = "Name for the ECS cluster"
  type        = string
  default     = "wordpress_cluster"
}

variable "ecs_service_container_name" {
  description = "Container name for the container definition and Target Group association"
  type        = string
  default     = "wordpress"
}

variable "ecs_service_name" {
  description = "Name for the ECS Service"
  type        = string
  default     = "wordpress"
}

variable "ecs_service_desired_count" {
  description = "Number of tasks to have running"
  type        = number
  default     = 2
}

variable "ecs_service_security_group_ids" {
  description = "Security groups assigned to the task ENIs"
  type        = list(string)
  default     = []
}

variable "efs_service_security_group_ids" {
  description = "Security groups to assign to the EFS mount target"
  type        = list(string)
  default     = []
}

variable "ecs_service_assign_public_ip" {
  description = "Whether to assign a public IP to the task ENIs"
  type        = bool
  default     = false
}

variable "container_definitions" {
  description = "ECS Task container definitions."
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the Load Balancer target group to associate with the service."
  type        = string
}

variable "ecs_task_definition_family" {
  description = "Specify a family for a task definition, which allows you to track multiple versions of the same task definition"
  type        = string
  default     = "wordpress-family"
}

variable "ecs_service_subnet_ids" {
  description = "Subnet ids where ENIs are created for tasks"
  type        = list(string)
}

variable "kms_key_arn" {
  description = "KMS Key ARN."
  type        = string
  default     = null
}

variable "secret_arn" {
  description = "Secret Manager Secret arn"
  type        = string
  default     = null
}


variable "ecs_task_definition_cpu" {
  description = "Number of CPU units reserved for the container in powers of 2"
  type        = string
  default     = "1024"
}

variable "ecs_task_definition_memory" {
  description = "Specify a family for a task definition, which allows you to track multiple versions of the same task definition"
  type        = string
  default     = "2048"
}

variable "tags" {
  description = "Map of tags to provide to the resources created"
  type        = map(string)
  default     = {}
}
