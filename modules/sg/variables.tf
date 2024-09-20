variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "sg_configs" {
  description = "Map of security group configurations"
  type = map(object({
    name        = string
    description = string
  }))
}

variable "sg_rules" {
  description = "Map of security group rules"
  type = map(object({
    sg_name        = string
    type           = string
    from_port      = number
    to_port        = number
    protocol       = string
    cidr_blocks    = optional(list(string))
    source_sg_name = optional(string)
    description    = optional(string)
  }))
}
