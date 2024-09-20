variable "sg_configs" {
  description = "List of security group configurations"
  type = map(object({
    name        = string
    description = string
  }))
}

variable "sg_rules" {
  description = "List of security group rules"
  type = map(object({
    sg_name                  = string
    type                     = string
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string))
    source_security_group_id = optional(string)
    description              = optional(string)
  }))
}
