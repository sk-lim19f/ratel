# modules/ecs/main.tf

resource "aws_ecs_cluster" "this" {
  for_each = var.ecs_clusters
  name     = each.value.name
}

resource "aws_ecs_task_definition" "this" {
  for_each                 = var.ecs_task_definitions
  family                   = each.value.family
  network_mode             = each.value.network_mode
  requires_compatibilities = each.value.requires_compatibilities
  cpu                      = each.value.cpu
  memory                   = each.value.memory
  execution_role_arn       = var.ecs_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn

  container_definitions = jsonencode([
    for container in each.value.container_definitions : {
      name             = container.name
      image            = container.image
      cpu              = container.cpu
      memory           = container.memory
      essential        = true
      portMappings     = container.port_mappings
      environment      = container.environment
      logConfiguration = container.log_configuration
    }
  ])
}

resource "aws_ecs_service" "this" {
  for_each        = var.ecs_services
  name            = each.value.name
  cluster         = aws_ecs_cluster.this[each.value.cluster_name].id
  task_definition = aws_ecs_task_definition.this[each.value.task_definition_family].arn
  desired_count   = each.value.desired_count
  launch_type     = each.value.launch_type
  iam_role        = var.ecs_service_role_arn

  load_balancer {
    target_group_arn = contains(keys(var.target_group_arns), each.key) ? var.target_group_arns[each.key] : ""
    container_name   = each.value.container_name
    container_port   = each.value.container_port
  }

  network_configuration {
    security_groups = var.security_group_ids
    subnets         = var.private_subnet_ids
  }

  # depends_on = [aws_lb_listener.listener_http, aws_lb_listener.listener_https]
}

resource "aws_launch_template" "ecs" {
  name_prefix   = "ecs-launch-template-"
  image_id      = var.ecs_service_ami_name
  instance_type = var.ecs_service_instance_type

  vpc_security_group_ids = var.security_group_ids

  iam_instance_profile {
    name = var.ecs_instance_profile_name
  }

  user_data = base64encode(<<EOF
  #!/bin/bash
  echo ECS_CLUSTER=${aws_ecs_cluster.this["main"].name} >> /etc/ecs/ecs.config
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.ecs_instance_name_prefix}"
    }
  }
}

resource "aws_autoscaling_group" "ecs" {
  desired_capacity    = var.autoscaling_desired_capacity
  max_size            = var.autoscaling_max_size
  min_size            = var.autoscaling_min_size
  vpc_zone_identifier = var.private_subnet_ids
  launch_template {
    id      = aws_launch_template.ecs.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.ecs_instance_name_prefix
    propagate_at_launch = true
  }
}