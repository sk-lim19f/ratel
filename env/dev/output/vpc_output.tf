output "vpc_id" {
  description = "The VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "private_db_subnet_ids" {
  description = "IDs of the private DB subnets"
  value       = module.vpc.private_db_subnet_ids
}

output "nat_gateway_id" {
  description = "The NAT Gateway ID"
  value       = module.vpc.nat_gateway_id
}

output "internet_gateway_id" {
  description = "The Internet Gateway ID"
  value       = module.vpc.internet_gateway_id
}
