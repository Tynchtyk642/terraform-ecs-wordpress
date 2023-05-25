variable "vpc_id" {
  description = "VPC ID to create resource in."
  type        = string
  default     = ""
}

variable "lb_name" {
  description = "Name for the load balancer"
  type        = string
  default     = "wordpress"
}

variable "lb_internal" {
  description = "If the load balancer should be an internal load balancer"
  type        = bool
  default     = false
}

variable "lb_listener_enable_ssl" {
  description = "Enable the SSL listener, if this is set the lb_listener_certificate_arn must also be provided"
  type        = bool
  default     = false
}

variable "lb_listener_certificate_arn" {
  description = "The ACM certificate ARN to use on the HTTPS listener"
  type        = string
  default     = ""
}

variable "lb_listener_ssl_policy" {
  description = "The SSL policy to apply to the HTTPS listener"
  type        = string
  default     = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
}

variable "lb_security_group_ids" {
  description = "Security groups to assign to the load balancer"
  type        = list(string)
  default     = []
}

variable "lb_target_group_http" {
  description = "Name of the HTTP target group"
  type        = string
  default     = "wordpress-http"
}

variable "lb_target_group_https" {
  description = "Name of the HTTPS target group"
  type        = string
  default     = "wordpress-https"
}

variable "lb_subnet_ids" {
  description = "Subnets where load balancer should be created"
  type        = list(string)
}

variable "tags" {
  description = "Map of tags to provide to the resources created"
  type        = map(string)
  default     = {}
}
