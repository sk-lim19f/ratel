# ALB 생성
resource "aws_lb" "this" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = var.alb_type
  security_groups    = var.alb_security_groups
  subnets            = var.alb_subnets
  idle_timeout       = var.alb_idle_timeout
  tags = {
    Name        = var.alb_name
    Environment = var.environment
  }
}

# ALB 타겟 그룹 생성
resource "aws_lb_target_group" "tg" {
  for_each = var.target_groups

  name        = each.value.name
  port        = each.value.port
  protocol    = each.value.protocol
  target_type = each.value.target_type
  vpc_id      = var.vpc_id

  health_check {
    interval            = var.health_check_interval
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    timeout             = var.health_check_timeout
    matcher             = each.value.health_check_matcher
    path                = each.value.health_check_path
  }

  tags = {
    Name = "${var.environment}-${each.value.name}"
  }
}


# Target Group Attachment 생성
resource "aws_lb_target_group_attachment" "tg_attachment" {
  for_each         = aws_lb_target_group.tg
  target_group_arn = each.value.arn
  target_id        = var.tg_target_id
  port             = var.tg_port
}



# ALB 리스너 HTTP 생성
resource "aws_lb_listener" "listener_http" {
  for_each          = aws_lb_target_group.tg
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_http_port
  protocol          = var.listener_http_protocol

  default_action {
    type             = var.default_http_action_type
    target_group_arn = each.value.arn

    redirect {
      port        = var.redirect_http_port
      protocol    = var.redirect_http_protocol
      status_code = var.redirect_http_status_code
    }
  }
}

# ALB 리스너 HTTPS 생성
resource "aws_lb_listener" "listener_https" {
  for_each          = aws_lb_target_group.tg
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_https_port
  protocol          = var.listener_https_protocol
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.ssl_certificate_arn

  default_action {
    type             = var.default_https_action_type
    target_group_arn = each.value.arn
  }
}
