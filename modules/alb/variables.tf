variable "target_groups" {
  description = "Map of Target Groups configurations"
  type = map(object({
    name                  = string
    port                  = number
    protocol              = string
    target_type           = string
    health_check_interval = number
    healthy_threshold     = number
    unhealthy_threshold   = number
    health_check_timeout  = number
    health_check_matcher  = string
    health_check_path     = string
  }))
}

variable "alb_name" {
  description = "Name of the ALB"
  type        = string
}

variable "alb_internal" {
  description = "Whether the ALB is internal"
  type        = bool
}

variable "alb_type" {
  description = "Type of the ALB"
  type        = string
  default     = "application"
}

variable "alb_security_groups" {
  description = "Security groups associated with the ALB"
  type        = list(string)
}

variable "alb_subnets" {
  description = "Subnets for the ALB"
  type        = list(string)
}

variable "alb_idle_timeout" {
  description = "Idle timeout for the ALB"
  type        = number
  default     = 60
}

variable "tg_name" {
  description = "Name of the target group"
  type        = string
}

variable "tg_port" {
  description = "Port of the target group"
  type        = number
}

variable "tg_protocol" {
  description = "Protocol of the target group"
  type        = string
}

variable "tg_target_type" {
  description = "Target type of the target group"
  type        = string
  default     = "instance"
}

variable "vpc_id" {
  description = "VPC ID where the ALB and target group are deployed"
  type        = string
}

variable "tg_target_id" {
  description = "ID of the target to attach to the Target Group"
  type        = string
}

variable "health_check_interval" {
  description = "Interval for health checks"
  type        = number
}

variable "health_check_healthy_threshold" {
  description = "Number of healthy checks before considering target healthy"
  type        = number
}

variable "health_check_unhealthy_threshold" {
  description = "Number of unhealthy checks before considering target unhealthy"
  type        = number
}

variable "health_check_timeout" {
  description = "Timeout for health checks"
  type        = number
}

variable "health_check_matcher" {
  description = "HTTP status codes to use when checking for a healthy response"
  type        = string
}

variable "health_check_path" {
  description = "Path to check for health status"
  type        = string
}

variable "listener_http_port" {
  description = "Port for HTTP listener"
  type        = number
  default     = 80
}

variable "listener_http_protocol" {
  description = "Protocol for HTTP listener"
  type        = string
  default     = "HTTP"
}

variable "default_http_action_type" {
  description = "Default action type for HTTP listener"
  type        = string
}

variable "redirect_http_port" {
  description = "Port to redirect HTTP traffic to"
  type        = string
}

variable "redirect_http_protocol" {
  description = "Protocol to redirect HTTP traffic to"
  type        = string
}

variable "redirect_http_status_code" {
  description = "Status code for HTTP redirect"
  type        = string
}

variable "listener_https_port" {
  description = "Port for HTTPS listener"
  type        = number
  default     = 443
}

variable "listener_https_protocol" {
  description = "Protocol for HTTPS listener"
  type        = string
  default     = "HTTPS"
}

variable "ssl_policy" {
  description = "SSL policy for HTTPS listener"
  type        = string
}

variable "ssl_certificate_arn" {
  description = "ARN of the SSL certificate for HTTPS listener"
  type        = string
}

variable "default_https_action_type" {
  description = "Default action type for HTTPS listener"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}