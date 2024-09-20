# Security Group 생성
resource "aws_security_group" "sg" {
  for_each = var.sg_configs

  name        = each.value.name
  description = each.value.description
  vpc_id      = var.vpc_id

  tags = {
    Name = each.value.name
  }
}

# Ingress 규칙 중 cidr_blocks을 사용하는 규칙 생성
resource "aws_security_group_rule" "ingress_cidr" {
  for_each = {
    for sg_name, sg_config in var.sg_rules :
    "${sg_name}_cidr" => sg_config
    if sg_config.type == "ingress" && length(try(lookup(sg_config, "cidr_blocks", []), [])) > 0
  }

  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.sg[each.value.sg_name].id
  description       = each.value.description
  cidr_blocks       = try(each.value.cidr_blocks, [])
}

# Ingress 규칙 중 source_security_group_id를 사용하는 규칙 생성
resource "aws_security_group_rule" "ingress_sg" {
  for_each = {
    for sg_name, sg_config in var.sg_rules :
    "${sg_name}_sg" => sg_config
    if sg_config.type == "ingress" && lookup(sg_config, "source_security_group_id", null) != null
  }

  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  security_group_id        = aws_security_group.sg[each.value.sg_name].id
  description              = each.value.description
  source_security_group_id = aws_security_group.sg[each.value.source_security_group_id].id
}

# Ingress 규칙 중 self를 사용하는 규칙 생성
resource "aws_security_group_rule" "ingress_self" {
  for_each = {
    for sg_name, sg_config in var.sg_rules :
    "${sg_name}_self" => sg_config
    if sg_config.type == "ingress" &&
    length(try(lookup(sg_config, "cidr_blocks", []), [])) == 0 &&
    lookup(sg_config, "source_security_group_id", null) == null
  }

  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.sg[each.value.sg_name].id
  description       = each.value.description
  self              = true
}

# Egress 규칙 생성 (변경 없음)
resource "aws_security_group_rule" "egress" {
  for_each = {
    for sg_name, sg_config in var.sg_rules :
    sg_name => sg_config
    if sg_config.type == "egress"
  }

  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = try(each.value.cidr_blocks, [])
  security_group_id = aws_security_group.sg[each.value.sg_name].id
  description       = each.value.description
}
