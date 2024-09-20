variable "rds_environment" {
  description = "Environment name"
  type        = string
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_engine" {
  description = "Engine type of the RDS instance"
  type        = string
}

variable "db_engine_version" {
  description = "Engine version of the RDS instance"
  type        = string
}

variable "db_instance_class" {
  description = "Instance class of the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "Storage size in GB"
  type        = number
}

variable "db_username" {
  description = "Username for the database"
  type        = string
}

variable "db_password" {
  description = "Password for the database"
  type        = string
  sensitive   = true
}

variable "db_parameter_group_name" {
  description = "Name of the DB parameter group"
  type        = string
}

variable "db_security_group_ids" {
  description = "Security group IDs for the RDS instance"
  type        = list(string)
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
}

variable "db_subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "db_subnet_group_tag_name" {
  description = "Tag name for the DB subnet group"
  type        = string
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Whether the DB instance is publicly accessible"
  type        = bool
  default     = false
}

variable "storage_type" {
  description = "Storage type of the DB instance"
  type        = string
  default     = "gp2"
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot before deletion"
  type        = bool
  default     = true
}
