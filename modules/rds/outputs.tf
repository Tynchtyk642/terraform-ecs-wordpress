output "rds_cluster_endpoint" {
  description = "Endpoint of RDS Aurora Cluster."
  value       = aws_rds_cluster.wordpress.endpoint
}
