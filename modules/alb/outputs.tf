output "lb_dns_name" {
  value = aws_lb.wordpress.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.wordpress_http.arn
}
