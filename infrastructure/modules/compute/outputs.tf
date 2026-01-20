output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.wordpress.dns_name
}

output "alb_zone_id" {
  description = "ALB zone ID"
  value       = aws_lb.wordpress.zone_id
}

output "alb_https_listener_arn" {
  description = "HTTPS listener ARN"
  value       = aws_lb_listener.https.arn
}

output "asg_name" {
  description = "Auto Scaling Group name"
  value       = aws_autoscaling_group.wordpress.name
}

output "launch_template_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.wordpress.id
}

output "alb_sg_id" {
  description = "ALB security group ID"
  value       = aws_security_group.alb.id
}

output "app_sg_id" {
  description = "App security group ID"
  value       = aws_security_group.app.id
}

output "target_group_arn" {
  description = "Target group ARN"
  value       = aws_lb_target_group.wordpress.arn
}