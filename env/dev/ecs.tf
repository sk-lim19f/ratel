# env/dev/ecs.tf

module "ecs" {
  source = "../../modules/ecs"

  ecs_clusters                 = var.ecs_clusters
  ecs_task_definitions         = var.ecs_task_definitions
  ecs_services                 = var.ecs_services
  ecs_service_ami_name         = var.ecs_service_ami_name
  ecs_service_instance_type    = var.ecs_service_instance_type
  ecs_instance_profile_name    = aws_iam_instance_profile.ecs_instance_profile.name
  ecs_instance_name_prefix     = var.ecs_instance_name_prefix
  private_subnet_ids           = module.vpc.private_subnet_ids
  autoscaling_desired_capacity = var.autoscaling_desired_capacity
  autoscaling_max_size         = var.autoscaling_max_size
  autoscaling_min_size         = var.autoscaling_min_size

  # 기존 변수들
  ecs_execution_role_arn        = aws_iam_role.ecs_execution_role.arn
  ecs_task_role_arn             = aws_iam_role.ecs_task_role.arn
  ecs_task_execution_policy_arn = aws_iam_policy.ecs_task_execution_policy.arn
  ecs_task_role_policy_arn      = aws_iam_policy.ecs_task_role_policy.arn
  security_group_ids            = [module.sg.sg_ids["ecs_instance_sg"]]

  # 새로 추가된 변수들
  ecs_service_role_arn   = aws_iam_role.ecs_service_role.arn
  lb_listener_http_arns  = flatten([for alb in module.alb : alb.listener_http_arn])
  lb_listener_https_arns = flatten([for alb in module.alb : alb.listener_https_arn])

  # target_group_arns = values(module.alb.target_group_arns)
  target_group_arns = var.target_group_arns != null ? var.target_group_arns : { for k, v in var.ecs_services : k => "" }
}
