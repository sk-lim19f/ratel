variable "alb_configs" {
  description = "Configuration for multiple ALBs"
  type = map(object({
    alb_name                         = string
    alb_internal                     = bool
    alb_type                         = string
    alb_security_groups              = list(string)
    alb_idle_timeout                 = number
    tg_name                          = string
    tg_port                          = number
    tg_protocol                      = string
    tg_target_type                   = string
    tg_target_id                     = string
    health_check_interval            = number
    health_check_healthy_threshold   = number
    health_check_unhealthy_threshold = number
    health_check_timeout             = number
    health_check_matcher             = string
    health_check_path                = string
    listener_http_port               = number
    listener_http_protocol           = string
    default_http_action_type         = string
    redirect_http_port               = string
    redirect_http_protocol           = string
    redirect_http_status_code        = string
    listener_https_port              = number
    listener_https_protocol          = string
    ssl_policy                       = string
    ssl_certificate_arn              = string
    default_https_action_type        = string
  }))
}

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
    tg_target_id          = string
  }))
  default = {
    "example_tg" = {
      name                  = ""
      port                  = 80
      protocol              = "HTTP"
      target_type           = "instance"
      health_check_interval = 30
      healthy_threshold     = 3
      unhealthy_threshold   = 3
      health_check_timeout  = 5
      health_check_matcher  = "200"
      health_check_path     = "/"
      tg_target_id          = ""
    }
  }
}
