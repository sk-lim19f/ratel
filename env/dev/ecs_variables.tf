variable "ecs_clusters" {
  description = "List of ECS Clusters to create"
  type = map(object({
    name = string
  }))
}

variable "ecs_task_definitions" {
  description = "List of ECS Task Definitions"
  type = map(object({
    family                   = string
    network_mode             = string
    requires_compatibilities = list(string)
    cpu                      = string
    memory                   = string
    execution_role_arn       = string
    task_role_arn            = string
    container_definitions = list(object({
      name   = string
      image  = string
      cpu    = number
      memory = number
      port_mappings = list(object({
        container_port = number
        host_port      = number
      }))
      environment = list(object({
        name  = string
        value = string
      }))
      log_configuration = object({
        logDriver = string
        options   = map(string)
      })
    }))
  }))
}

variable "ecs_services" {
  description = "List of ECS Services"
  type = map(object({
    name                   = string
    cluster_name           = string
    task_definition_family = string
    desired_count          = number
    launch_type            = string
    iam_role               = string
    target_group_arn       = string
    container_name         = string
    container_port         = number
    security_groups        = list(string)
    subnets                = list(string)
  }))
}

variable "ecs_service_ami_name" {
  description = "AMI name for ECS instances"
  type        = string
}

variable "ecs_service_instance_type" {
  description = "Instance type for ECS service"
  type        = string
}

variable "ecs_instance_profile_name" {
  description = "IAM instance profile name for ECS instances"
  type        = string
}

variable "ecs_instance_name_prefix" {
  description = "Prefix for ECS instance names"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
  default     = []
}

variable "autoscaling_desired_capacity" {
  description = "Desired capacity for ASG"
  type        = number
}

variable "autoscaling_max_size" {
  description = "Maximum size for ASG"
  type        = number
}

variable "autoscaling_min_size" {
  description = "Minimum size for ASG"
  type        = number
}

variable "target_group_arns" {
  description = "Map of Target Group ARNs for ECS Services"
  type        = map(string)
  default     = {}
}

