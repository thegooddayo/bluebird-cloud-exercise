#!/bin/bash
set -e

echo "Starting WordPress infrastructure deployment..."

cd infrastructure

# Initialize Terraform
terraform init

# Create plan
terraform plan -out=tfplan

# Apply changes
terraform apply tfplan

echo "Deployment completed!"
echo ""
echo "WordPress will be available at:"
echo "http://$(terraform output -raw alb_dns_name)"
echo ""
echo "Database endpoint: $(terraform output -raw db_instance_endpoint)"