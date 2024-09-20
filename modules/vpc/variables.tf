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


# variable "vpn_gateway_tag_name" {
#   description = "Tag name for the VPN Gateway"
#   type        = string
# }

# variable "customer_gateway_tag_name" {
#   description = "Tag name for the Customer Gateway"
#   type        = string
# }

# variable "bgp_asn" {
#   description = "BGP ASN for the Customer Gateway"
#   type        = number
# }

# variable "customer_gateway_ip" {
#   description = "IP Address for the Customer Gateway"
#   type        = string
# }

# variable "tunnel1_preshared_key" {
#   description = "Preshared key for Tunnel 1"
#   type        = string
# }

# variable "tunnel1_inside_cidr" {
#   description = "Inside CIDR block for Tunnel 1"
#   type        = string
# }

# variable "tunnel2_preshared_key" {
#   description = "Preshared key for Tunnel 2"
#   type        = string
# }

# variable "tunnel2_inside_cidr" {
#   description = "Inside CIDR block for Tunnel 2"
#   type        = string
# }

# variable "vpn_connection_tag_name" {
#   description = "Tag name for the VPN Connection"
#   type        = string
# }

# variable "vpn_ratel_destination_cidr" {
#   description = "Destination CIDR block for the VPN Route"
#   type        = string
# }
