module "sg" {
  source = "../../modules/sg"

  vpc_id     = module.vpc.vpc_id
  sg_configs = var.sg_configs
  sg_rules   = var.sg_rules
}
