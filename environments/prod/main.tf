module "vpc" {
  source = "../../modules/vpc"

  project_name = local.name_prefix
  vpc_cidr     = var.vpc_cidr
  az_count     = var.az_count
}

module "security_groups" {
  source = "../../modules/security-groups"

  project_name = local.name_prefix
  vpc_id       = module.vpc.vpc_id
}

module "iam" {
  source = "../../modules/iam"

  project_name = local.name_prefix
}

module "alb" {
  source = "../../modules/alb"

  project_name          = local.name_prefix
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.security_groups.alb_security_group_id
}

module "compute" {
  source = "../../modules/compute"

  project_name            = local.name_prefix
  instance_type           = var.instance_type
  app_subnet_ids          = module.vpc.app_subnet_ids
  app_security_group_id   = module.security_groups.app_security_group_id
  instance_profile_name   = module.iam.instance_profile_name
  target_group_arn        = module.alb.target_group_arn
  min_size                = var.min_size
  max_size                = var.max_size
  desired_capacity        = var.desired_capacity
}

module "rds" {
  source = "../../modules/rds"

  project_name          = local.name_prefix
  db_subnet_ids         = module.vpc.db_subnet_ids
  db_security_group_id  = module.security_groups.db_security_group_id

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}