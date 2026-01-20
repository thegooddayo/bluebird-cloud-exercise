# Networking Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS name"
  value       = module.compute.alb_dns_name
}

output "alb_zone_id" {
  description = "Application Load Balancer zone ID"
  value       = module.compute.alb_zone_id
}

output "alb_https_listener_arn" {
  description = "HTTPS listener ARN for use with CloudFront"
  value       = module.compute.alb_https_listener_arn
}

# Database Outputs
output "db_instance_endpoint" {
  description = "RDS instance endpoint"
  value       = module.database.db_instance_endpoint
  sensitive   = true
}

output "db_instance_username" {
  description = "RDS instance username"
  value       = module.database.db_instance_username
  sensitive   = true
}

# Storage Outputs
output "s3_bucket_id" {
  description = "S3 bucket ID for WordPress uploads"
  value       = module.storage.s3_bucket_id
}

output "s3_bucket_arn" {
  description = "S3 bucket ARN"
  value       = module.storage.s3_bucket_arn
}

# Compute Outputs
output "asg_name" {
  description = "Auto Scaling Group name"
  value       = module.compute.asg_name
}

output "launch_template_id" {
  description = "Launch Template ID"
  value       = module.compute.launch_template_id
}

# Security Outputs
output "bastion_instance_id" {
  description = "Bastion host instance ID"
  value       = module.security.bastion_instance_id
}

output "bastion_public_ip" {
  description = "Bastion host public IP"
  value       = module.security.bastion_public_ip
}

# Application URL
output "application_url" {
  description = "WordPress application URL"
  value       = "https://${module.compute.alb_dns_name}"
}

output "wordpress_admin_url" {
  description = "WordPress admin URL"
  value       = "https://${module.compute.alb_dns_name}/wp-admin"
}

# Sensitive outputs (marked as sensitive)
output "db_password" {
  description = "RDS database password"
  value       = random_password.db_password.result
  sensitive   = true
}

output "wordpress_salt" {
  description = "WordPress security salts"
  value       = random_password.wordpress_salt.result
  sensitive   = true
}