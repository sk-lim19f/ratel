variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_engine" {
  description = "Database engine"
  type        = string
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
}

variable "db_instance_class" {
  description = "Database instance class"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage for the DB instance"
  type        = number
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_parameter_group_name" {
  description = "Parameter group name for the DB instance"
  type        = string
}

variable "db_security_group_ids" {
  description = "Security group IDs for the RDS instance"
  type        = list(string)
}

variable "db_subnet_group_name" {
  description = "DB Subnet Group Name"
  type        = string
}

variable "db_subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "db_subnet_group_tag_name" {
  description = "DB Subnet Group Tag Name"
  type        = string
}

variable "multi_az" {
  description = "Enable Multi-AZ for the DB instance"
  type        = bool
}

variable "publicly_accessible" {
  description = "Is the DB publicly accessible?"
  type        = bool
}

variable "storage_type" {
  description = "Storage type for the DB instance"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on deletion"
  type        = bool
}

variable "rds_environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}