output "sg_ids" {
  description = "Map of security group IDs"
  value = {
    alb_sg          = aws_security_group.sg["alb_sg"].id
    ecs_sg          = aws_security_group.sg["ecs_sg"].id
    ecs_instance_sg = aws_security_group.sg["ecs_instance_sg"].id
    rds_sg          = aws_security_group.sg["rds_sg"].id
  }
}
