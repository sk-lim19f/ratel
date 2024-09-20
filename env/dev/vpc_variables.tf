variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets_cidr" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "db_subnets_cidr" {
  description = "List of CIDR blocks for database subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Map of availability zones for subnets"
  type        = map(string)
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}
