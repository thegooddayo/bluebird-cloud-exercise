# Global Variables
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "mnclouds"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# Network Variables
variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private app subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "database_subnet_cidrs" {
  description = "CIDR blocks for database subnets"
  type        = list(string)
  default     = ["10.0.100.0/24", "10.0.101.0/24"]
}

# Compute Variables
variable "instance_type" {
  description = "EC2 instance type for WordPress"
  type        = string
  default     = "t3.micro"
}

variable "min_instance_count" {
  description = "Minimum number of instances in ASG"
  type        = number
  default     = 2
}

variable "max_instance_count" {
  description = "Maximum number of instances in ASG"
  type        = number
  default     = 4
}

variable "desired_instance_count" {
  description = "Desired number of instances in ASG"
  type        = number
  default     = 2
}

# Database Variables
variable "db_instance_class" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
  default     = 20
}

variable "db_storage_type" {
  description = "RDS storage type"
  type        = string
  default     = "gp2"
}

variable "db_engine_version" {
  description = "MySQL engine version"
  type        = string
  default     = "8.0"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "wordpressdb"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "admin"
}

# WordPress Variables
variable "wordpress_admin_user" {
  description = "WordPress admin username"
  type        = string
  default     = "admin"
}

variable "wordpress_admin_email" {
  description = "WordPress admin email"
  type        = string
  default     = "admin@bluebird-group.com"
}

variable "wordpress_site_title" {
  description = "WordPress site title"
  type        = string
  default     = "Bluebird Group"
}

# Security Variables
variable "allowed_ssh_ips" {
  description = "List of IPs allowed to SSH (for bastion)"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Restrict this in production
}

variable "allowed_http_ips" {
  description = "List of IPs allowed to access HTTP/HTTPS"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}