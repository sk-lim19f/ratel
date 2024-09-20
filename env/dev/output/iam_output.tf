output "ecs_task_execution_policy_arn" {
  description = "ARN of the ECS task execution policy"
  value       = aws_iam_policy.ecs_task_execution_policy.arn
}

output "ecs_task_role_policy_arn" {
  description = "ARN of the ECS task role policy"
  value       = aws_iam_policy.ecs_task_role_policy.arn
}

output "alb_logging_policy_arn" {
  description = "ARN of the ALB logging policy"
  value       = aws_iam_policy.alb_logging_policy.arn
}

output "rds_access_policy_arn" {
  description = "ARN of the RDS access policy"
  value       = aws_iam_policy.rds_access_policy.arn
}

output "vpc_flow_logs_policy_arn" {
  description = "ARN of the VPC flow logs policy"
  value       = aws_iam_policy.vpc_flow_logs_policy.arn
}
