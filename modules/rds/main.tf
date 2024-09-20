# DB Subnet Group 생성
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.db_subnet_ids

  tags = {
    Name        = var.db_subnet_group_tag_name
    Environment = var.rds_environment
  }
}

# RDS 인스턴스 생성
resource "aws_db_instance" "rds" {
  identifier             = "rds-${var.rds_environment}-${var.db_name}"
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  allocated_storage      = var.allocated_storage
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = var.db_security_group_ids
  multi_az               = var.multi_az
  publicly_accessible    = var.publicly_accessible
  storage_type           = var.storage_type
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = var.skip_final_snapshot
  parameter_group_name   = var.db_parameter_group_name

  tags = {
    Name        = var.db_name
    Environment = var.rds_environment
  }
}
