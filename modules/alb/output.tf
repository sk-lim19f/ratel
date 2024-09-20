output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "alb_zone_id" {
  value = aws_lb.this.zone_id
}

output "listener_http_arn" {
  description = "List of HTTP listener ARNs for all ALBs"
  value       = [for listener in aws_lb_listener.listener_http : listener.arn]
}

output "listener_https_arn" {
  description = "List of HTTPS listener ARNs for all ALBs"
  value       = [for listener in aws_lb_listener.listener_https : listener.arn]
}

output "target_group_arns" {
  description = "Map of Target Group ARNs"
  value       = { for key, tg in aws_lb_target_group.tg : key => tg.arn }
}