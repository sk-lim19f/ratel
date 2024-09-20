# RDS 모듈 호출
module "rds" {
  source = "../../modules/rds"

  rds_environment         = var.rds_environment
  db_name                 = var.db_name
  db_engine               = var.db_engine
  db_engine_version       = var.db_engine_version
  db_instance_class       = var.db_instance_class
  allocated_storage       = var.allocated_storage
  db_username             = var.db_username
  db_password             = var.db_password
  db_parameter_group_name = var.db_parameter_group_name

  db_security_group_ids = [module.sg.sg_ids["rds_sg"]]
  db_subnet_ids         = module.vpc.db_subnet_ids

  db_subnet_group_name     = var.db_subnet_group_name
  db_subnet_group_tag_name = var.db_subnet_group_tag_name
  multi_az                 = var.multi_az
  publicly_accessible      = var.publicly_accessible
  storage_type             = var.storage_type
  skip_final_snapshot      = var.skip_final_snapshot
}