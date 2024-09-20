# VPC 생성
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.environment}-vpc"
  }
}

# Public 서브넷 생성
resource "aws_subnet" "public" {
  for_each = { for idx, cidr in var.public_subnets_cidr : idx => cidr }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[each.key]
  tags = {
    Name = "${var.environment}-Public-Subnet-${each.key}"
  }
}


# Private 서브넷 생성
resource "aws_subnet" "private" {
  for_each = { for idx, cidr in var.private_subnets_cidr : idx => cidr }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = var.availability_zones[each.key]
  tags = {
    Name = "${var.environment}-Private-Subnet-${each.key}"
  }
}

# DB 서브넷 생성
resource "aws_subnet" "db" {
  for_each = { for idx, cidr in var.db_subnets_cidr : idx => cidr }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = var.availability_zones[each.key]
  tags = {
    Name = "${var.environment}-DB-Subnet-${each.key}"
  }
}

# 인터넷 게이트웨이
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.environment}-IGW"
  }
}

# Public 라우트 테이블 생성 및 인터넷 게이트웨이 라우트 추가
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.environment}-Public-RT"
  }
}

# Public 서브넷과 라우트 테이블 연결
resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# NAT Gateway를 위한 EIP 생성
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "${var.environment}-NAT-EIP"
  }
}

# NAT Gateway 생성
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public["0"].id # 첫 번째 Public 서브넷에 NAT Gateway 배치

  tags = {
    Name = "${var.environment}-NAT-Gateway"
  }
}

# Private 라우트 테이블 생성 및 NAT Gateway 라우트 추가
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.environment}-Private-RT"
  }
}

# Private 서브넷과 라우트 테이블 연결
resource "aws_route_table_association" "private_assoc" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}


# resource "aws_vpn_gateway" "ratel_vgw" {
#   vpc_id = aws_vpc.dev_vpc.id

#   tags = {
#     Name = var.vpn_gateway_tag_name
#   }
# }

# resource "aws_customer_gateway" "ratel_cgw" {
#   bgp_asn    = var.bgp_asn
#   ip_address = var.customer_gateway_ip
#   type       = "ipsec.1"

#   tags = {
#     Name = var.customer_gateway_tag_name
#   }
# }

# resource "aws_vpn_connection" "ratel_s2s_vpn" {
#   customer_gateway_id = aws_customer_gateway.ratel_cgw.id
#   vpn_gateway_id      = aws_vpn_gateway.ratel_vgw.id
#   type                = "ipsec.1"

#   tunnel1_preshared_key = var.tunnel1_preshared_key
#   tunnel1_inside_cidr   = var.tunnel1_inside_cidr

#   tunnel2_preshared_key = var.tunnel2_preshared_key
#   tunnel2_inside_cidr   = var.tunnel2_inside_cidr

#   static_routes_only = true

#   tags = {
#     Name = var.vpn_connection_tag_name
#   }
# }

# resource "aws_route" "route_table_association_vpn_ratel" {
#   route_table_id         = aws_route_table.route_table_private.id
#   destination_cidr_block = var.vpn_ratel_destination_cidr
#   gateway_id             = aws_vpn_connection.ratel_s2s_vpn.id
# }
