module "vpc" {
  source = "../../modules/vpc"

  vpc_name                            = "shopsphere-vpc"
  vpc_cidr_block                      = "10.0.0.0/16"
  public_subnet_cidrs                 = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidr_blocks_backend  = ["10.0.11.0/24", "10.0.12.0/24"]
  private_subnet_cidr_blocks_database = ["10.0.21.0/24", "10.0.22.0/24"]
  availability_zones                  = ["us-east-1a", "us-east-1b"]
  tags                                = var.common_tags
}
module "security_groups" {
  source = "../../modules/security-groups"

  vpc_id       = module.vpc.vpc_id
  project_name = "shopsphere"
  tags         = var.common_tags
}
module "iam" {
  source = "../../modules/iam"

  project_name = "kwikit-prod"

  github_org = "manojkumartumpiri"

  github_repositories = [
    "3-tier-app-terraform"
  ]

  frontend_ecr_arn = module.ecr.frontend_repository_arn
  backend_ecr_arn  = module.ecr.backend_repository_arn

  db_secret_arn = module.rds.master_user_secret_arn

  tags = var.common_tags
}
module "s3" {
  source = "../../modules/s3"

  project_name = "shopsphere-terraform-s3-ecommerce"
  tags         = var.common_tags
}
module "acm" {
  source = "../../modules/acm"

  domain_name               = "kwikit.in"
  subject_alternative_names = ["www.kwikit.in", "app.kwikit.in"]
  validation_method         = "DNS"
  tags                      = var.common_tags
}
module "rds" {
  source             = "../../modules/rds"
  project_name       = "shopsphere-prod"
  db_name            = "shopsphere"
  db_username        = "admin"
  private_subnet_ids = module.vpc.private_database_subnet_ids
  security_group_id  = module.security_groups.rds_security_group_id

  tags = var.common_tags
}
module "alb" {
  source = "../../modules/alb"

  project_name      = "shopsphere-prod"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  security_group_id = module.security_groups.alb_security_group_id
  certificate_arn   = module.acm.certificate_arn
  logs_bucket       = module.s3.logs_bucket_name

  tags       = var.common_tags
  depends_on = [module.s3]
}
module "ecs" {
  source = "../../modules/ecs-cluster"

  project_name = "kwikit-prod"
  aws_region   = var.aws_region

  private_app_subnet_ids = module.vpc.private_database_subnet_ids

  frontend_security_group_id = module.security_groups.frontend_security_group_id
  backend_security_group_id  = module.security_groups.backend_security_group_id

  frontend_target_group_arn = module.alb.frontend_target_group_arn
  backend_target_group_arn  = module.alb.backend_target_group_arn

  frontend_image = var.frontend_image
  backend_image  = var.backend_image

  ecs_execution_role_arn = module.iam.ecs_execution_role_arn
  ecs_task_role_arn      = module.iam.ecs_task_role_arn

  db_endpoint   = module.rds.endpoint
  db_secret_arn = module.rds.master_user_secret_arn

  tags = var.common_tags
  depends_on = [
    module.alb
  ]
}

module "route53" {
  source = "../../modules/route53"

  domain_name               = "kwikit.in"
  alb_dns_name              = module.alb.alb_dns_name
  alb_zone_id               = module.alb.alb_zone_id
  domain_validation_options = module.acm.domain_validation_options
  certificate_arn           = module.acm.certificate_arn
}
module "ecr" {
  source = "../../modules/ecr"

  project_name = "kwikit-prod"
  tags         = var.common_tags
}
module "cloudwatch" {
  source = "../../modules/cloudwatch"

  project_name          = "kwikit-prod"
  cluster_name          = module.ecs.cluster_name
  frontend_service_name = module.ecs.frontend_service_name
  backend_service_name  = module.ecs.backend_service_name

  alb_arn_suffix                  = module.alb.alb_arn_suffix
  backend_target_group_arn_suffix = module.alb.backend_target_group_arn_suffix
  db_instance_id                  = module.rds.db_instance_id


  alerts_email = "tumpirimanojkumar@gmail.com"
  tags         = var.common_tags
}