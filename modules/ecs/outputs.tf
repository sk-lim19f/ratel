output "ecs_cluster_ids" {
  description = "ECS Cluster IDs"
  value       = [for cluster in aws_ecs_cluster.this : cluster.id]
}

output "task_definition_arns" {
  description = "Task Definition ARNs"
  value       = [for task in aws_ecs_task_definition.this : task.arn]
}

output "ecs_service_arns" {
  description = "ECS Service ARNs"
  value       = [for key, service in aws_ecs_service.this : lookup(service, "arn", null)]
}

output "asg_name" {
  description = "Auto Scaling Group Name"
  value       = aws_autoscaling_group.ecs.name
}
