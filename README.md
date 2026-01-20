# Bluebird Group - Cloud Infrastructure Exercise

## Overview
This repository contains Infrastructure-as-Code (IaC) for deploying a highly available, secure, and scalable WordPress application on AWS. The infrastructure is designed following AWS best practices and implements a multi-tier architecture.

## Architecture
The infrastructure consists of the following components:

### Network Layer
- VPC with public and private subnets across 2 availability zones
- Internet Gateway for public internet access
- NAT Gateways for outbound internet access from private subnets
- Route tables with proper routing configurations
- Network ACLs for additional security

### Compute Layer
- Auto Scaling Group with 2-4 t3.micro instances
- Application Load Balancer distributing traffic across AZs
- Launch Template with WordPress installation bootstrap
- Health checks and automatic instance replacement

### Database Layer
- Amazon RDS MySQL with Multi-AZ deployment
- Automated backups with 7-day retention
- Encryption at rest using AWS KMS
- Deployed in private subnets (not publicly accessible)

### Storage Layer
- S3 bucket for WordPress media uploads
- CloudFront CDN for static content delivery
- Lifecycle policies for cost optimization
- Server-side encryption enabled

### Security
- IAM roles with least-privilege permissions
- Security Groups with minimal allowed traffic
- Secrets Manager for database credentials
- Network ACLs for additional layer of security
- Bastion host for secure administrative access

## Prerequisites

### 1. AWS Account Requirements
- AWS Account with appropriate permissions
- IAM User with AdministratorAccess or equivalent permissions
- AWS CLI v2 installed and configured

### 2. Local Development Requirements
- Terraform v1.5.0 or higher
- AWS CLI v2
- Git
- jq (for script processing)
- Bash shell

### 3. AWS Service Quotas
Ensure you have the following service quotas:
- EC2: At least 4 running instances
- RDS: At least 1 db.t3.micro instance
- VPC: At least 1 VPC
- Elastic IP: At least 2 addresses

# Note 
- Must have the key pair for the EE2 with project_name