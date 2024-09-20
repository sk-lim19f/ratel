output "alb_arn" {
  description = "ARN of the ALB"
  value       = module.alb.alb_arn
}

output "tg_arn" {
  description = "ARN of the Target Group"
  value       = module.alb.tg_arn
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "alb_listener_http_arns" {
  description = "List of HTTP listener ARNs for all ALBs"
  value       = [for alb in module.alb : alb.listener_http_arn]
}

output "alb_listener_https_arns" {
  description = "List of HTTPS listener ARNs for all ALBs"
  value       = [for alb in module.alb : alb.listener_https_arn]
}

output "target_group_arns" {
  description = "List of ALB Target Group ARNs"
  value       = { for key, tg_arn in module.alb.target_group_arns : key => tg_arn }
}
