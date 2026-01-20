# Random resources for unique naming
resource "random_id" "suffix" {
  byte_length = 4
}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_password" "wordpress_salt" {
  length = 64
}

# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Local values for naming
locals {
  name_prefix = "${var.project_name}-${var.environment}"
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
  
  # WordPress user data template
  wordpress_user_data = templatefile("${path.module}/templates/wordpress.sh", {
    db_host           = module.database.db_instance_endpoint
    db_name           = var.db_name
    db_user           = var.db_username
    db_password       = random_password.db_password.result
    s3_bucket         = module.storage.s3_bucket_id
    aws_region        = var.aws_region
    admin_user        = var.wordpress_admin_user
    admin_email       = var.wordpress_admin_email
    site_title        = var.wordpress_site_title
    wp_salt           = random_password.wordpress_salt.result
    alb_dns_name      = module.compute.alb_dns_name
    project_name      = var.project_name
    environment       = var.environment
  })
}

# Module calls
module "networking" {
  source = "./modules/networking"
  
  vpc_cidr            = var.vpc_cidr
  availability_zones  = var.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  environment         = var.environment
  project_name        = var.project_name
  
  tags = local.common_tags
}

module "security" {
  source = "./modules/security"
  
  vpc_id              = module.networking.vpc_id
  vpc_cidr            = var.vpc_cidr
  alb_sg_id           = module.compute.alb_sg_id
  app_sg_id           = module.compute.app_sg_id
  db_sg_id            = module.database.db_sg_id
  allowed_ssh_ips     = var.allowed_ssh_ips
  allowed_http_ips    = var.allowed_http_ips
  environment         = var.environment
  project_name        = var.project_name
  db_username         = var.db_username
  db_password         = random_password.db_password.result
  db_host             = module.database.db_instance_endpoint
  db_name             = var.db_name
  public_subnet_ids = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
  bastion_key_name = var.project_name
  bastion_ami_id                  = data.aws_ami.amazon_linux_2.id
  tags = local.common_tags
}

module "storage" {
  source = "./modules/storage"
  
  environment  = var.environment
  project_name = var.project_name
  random_suffix = random_id.suffix.hex
  
  tags = local.common_tags
}

module "database" {
  source = "./modules/database"
  
  vpc_id                 = module.networking.vpc_id
  db_subnet_ids          = module.networking.database_subnet_ids
  db_instance_class      = var.db_instance_class
  db_allocated_storage   = var.db_allocated_storage
  db_storage_type        = var.db_storage_type
  db_engine_version      = var.db_engine_version
  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = random_password.db_password.result
  environment            = var.environment
  project_name           = var.project_name
  
  tags = local.common_tags
}

module "compute" {
  source = "./modules/compute"
  
  vpc_id                  = module.networking.vpc_id
  public_subnet_ids       = module.networking.public_subnet_ids
  private_subnet_ids      = module.networking.private_subnet_ids
  ami_id                  = data.aws_ami.amazon_linux_2.id
  instance_type           = var.instance_type
  min_size                = var.min_instance_count
  max_size                = var.max_instance_count
  desired_capacity        = var.desired_instance_count
  user_data               = base64encode(local.wordpress_user_data)
  db_security_group_id    = module.database.db_sg_id
  environment             = var.environment
  project_name            = var.project_name
  s3_bucket_arn           = module.storage.s3_bucket_arn
  key_name = var.project_name
  
  tags = local.common_tags
}