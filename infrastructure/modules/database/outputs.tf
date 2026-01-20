output "db_instance_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.mysql.endpoint
}

output "db_instance_address" {
  description = "RDS instance address"
  value       = aws_db_instance.mysql.address
}

output "db_instance_username" {
  description = "RDS instance username"
  value       = aws_db_instance.mysql.username
  sensitive   = true
}

output "db_instance_name" {
  description = "RDS instance name"
  value       = aws_db_instance.mysql.identifier
}

output "db_sg_id" {
  description = "RDS security group ID"
  value       = aws_security_group.rds.id
}