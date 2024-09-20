module "alb" {
  source = "../../modules/alb"

  for_each = var.alb_configs

  alb_name                         = each.value.alb_name
  alb_internal                     = each.value.alb_internal
  alb_type                         = each.value.alb_type
  alb_security_groups              = each.value.alb_security_groups
  alb_subnets                      = module.vpc.public_subnet_ids
  alb_idle_timeout                 = each.value.alb_idle_timeout
  tg_name                          = each.value.tg_name
  tg_port                          = each.value.tg_port
  tg_protocol                      = each.value.tg_protocol
  tg_target_type                   = each.value.tg_target_type
  tg_target_id                     = each.value.tg_target_id
  vpc_id                           = module.vpc.vpc_id
  health_check_interval            = each.value.health_check_interval
  health_check_healthy_threshold   = each.value.health_check_healthy_threshold
  health_check_unhealthy_threshold = each.value.health_check_unhealthy_threshold
  health_check_timeout             = each.value.health_check_timeout
  health_check_matcher             = each.value.health_check_matcher
  health_check_path                = each.value.health_check_path
  listener_http_port               = each.value.listener_http_port
  listener_http_protocol           = each.value.listener_http_protocol
  default_http_action_type         = each.value.default_http_action_type
  redirect_http_port               = each.value.redirect_http_port
  redirect_http_protocol           = each.value.redirect_http_protocol
  redirect_http_status_code        = each.value.redirect_http_status_code
  listener_https_port              = each.value.listener_https_port
  listener_https_protocol          = each.value.listener_https_protocol
  ssl_policy                       = each.value.ssl_policy
  ssl_certificate_arn              = each.value.ssl_certificate_arn
  default_https_action_type        = each.value.default_https_action_type
  environment                      = var.environment
  target_groups                    = var.target_groups
}
