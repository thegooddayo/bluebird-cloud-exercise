variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "alb_sg_id" {
  description = "ALB security group ID"
  type        = string
}

variable "app_sg_id" {
  description = "App security group ID"
  type        = string
}

variable "db_sg_id" {
  description = "Database security group ID"
  type        = string
}

variable "allowed_ssh_ips" {
  description = "Allowed SSH IP ranges"
  type        = list(string)
}

variable "allowed_http_ips" {
  description = "Allowed HTTP IP ranges"
  type        = list(string)
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
  default     = []
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
  default     = []
}

variable "bastion_ami_id" {
  description = "Bastion AMI ID"
  type        = string
  default     = ""
}

variable "bastion_key_name" {
  description = "Bastion key pair name"
  type        = string
  default     = null
}

variable "bastion_iam_instance_profile" {
  description = "Bastion IAM instance profile"
  type        = string
  default     = null
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = ""
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  default     = ""
}

variable "db_endpoint" {
  description = "Database endpoint"
  type        = string
  default     = ""
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}

# Add this variable
variable "db_host" {
  description = "Database host endpoint"
  type        = string
  default     = ""
}