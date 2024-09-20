output "db_instance_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = aws_db_instance.rds.endpoint
}

output "db_instance_id" {
  description = "ID of the RDS instance"
  value       = aws_db_instance.rds.id
}
