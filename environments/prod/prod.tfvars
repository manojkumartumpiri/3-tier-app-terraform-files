aws_region = "us-east-1"

common_tags = {
  Project     = "ShopSphere-terraform-s3-ecommerce"
  Environment = "prod"
  ManagedBy   = "Terraform"
}
frontend_image = "865950114072.dkr.ecr.us-east-1.amazonaws.com/kwikit-prod-frontend:ef25e938e32339bc9136b3bdb5ec8d68532c0388"
backend_image  = "865950114072.dkr.ecr.us-east-1.amazonaws.com/kwikit-prod-backend:ef25e938e32339bc9136b3bdb5ec8d68532c0388"