terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }

#   backend "s3" {
#     # This will be configured during runtime
#     # bucket = "bluebird-tf-state-<region>-<account-id>"
#     # key    = "terraform.tfstate"
#     # region = "us-east-1"
#   }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = "Bluebird-WebApp"
      Environment = var.environment
      ManagedBy   = "Terraform"
      CostCenter  = "Engineering"
    }
  }
}