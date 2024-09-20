output "rds_endpoint" {
  description = "The RDS instance endpoint"
  value       = module.rds.rds_endpoint
}

output "rds_instance_class" {
  description = "The class of the RDS instance"
  value       = module.rds.rds_instance_class
}

output "rds_subnet_group_name" {
  description = "The name of the RDS subnet group"
  value       = module.rds.rds_subnet_group_name
}
