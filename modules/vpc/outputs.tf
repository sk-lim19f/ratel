output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id # 리소스 이름을 실제 선언된 이름으로 변경
}

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = [for s in aws_subnet.private : s.id]
}

output "db_subnet_ids" {
  description = "DB Subnet IDs"
  value       = [for s in aws_subnet.db : s.id]
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.nat.id
}

output "internet_gateway_id" {
  description = "The Internet Gateway ID"
  value       = aws_internet_gateway.igw.id
}