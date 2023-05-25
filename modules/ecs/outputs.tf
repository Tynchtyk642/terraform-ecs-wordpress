output "ecs_cluster_arn" {
  value = aws_ecs_cluster.wordpress.arn
}

output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.wordpress.arn
}

output "ecs_task_definition_family" {
  value = aws_ecs_task_definition.wordpress.family
}

output "ecs_task_definition_revision" {
  value = aws_ecs_task_definition.wordpress.revision
}

output "ecs_service_id" {
  value = aws_ecs_service.wordpress.id
}
