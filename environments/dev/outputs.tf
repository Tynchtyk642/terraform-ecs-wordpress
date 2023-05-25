output "lb_dns" {
  description = "Wordpress Load Balancer DNS"
  value       = module.alb.lb_dns_name
}
