# AWS Configuration
aws_region = "us-east-1"
environment = "prod"
project_name = "mnclouds"

# Network Configuration
vpc_cidr = "10.0.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.20.0/24"]
database_subnet_cidrs = ["10.0.100.0/24", "10.0.101.0/24"]

# Compute Configuration
instance_type = "t3.micro"
min_instance_count = 2
max_instance_count = 4
desired_instance_count = 2

# Database Configuration
db_instance_class = "db.t3.micro"
db_allocated_storage = 20
db_name = "wordpressdb"
db_username = "admin"

# WordPress Configuration
wordpress_admin_user = "admin"
wordpress_admin_email = "admin@bluebird-group.com"
wordpress_site_title = "Bluebird Group"

# Security Configuration
allowed_ssh_ips = ["0.0.0.0/0"]
allowed_http_ips = ["0.0.0.0/0"]