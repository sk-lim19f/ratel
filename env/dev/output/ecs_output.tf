output "ecs_cluster_ids" {
  description = "ECS Cluster IDs"
  value       = module.ecs.ecs_cluster_ids
}

output "task_definition_arns" {
  description = "Task Definition ARNs"
  value       = module.ecs.task_definition_arns
}

output "ecs_service_arns" {
  description = "ECS Service ARNs"
  value       = module.ecs.ecs_service_arns
}

output "asg_name" {
  description = "Auto Scaling Group Name"
  value       = module.ecs.asg_name
}