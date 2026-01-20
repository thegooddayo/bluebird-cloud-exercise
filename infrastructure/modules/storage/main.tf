# S3 Bucket for WordPress uploads
resource "aws_s3_bucket" "wordpress_uploads" {
  bucket = "${var.project_name}-${var.environment}-uploads-${var.random_suffix}"
  
  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-uploads"
  })
}

# Enable versioning
resource "aws_s3_bucket_versioning" "wordpress_uploads" {
  bucket = aws_s3_bucket.wordpress_uploads.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "wordpress_uploads" {
  bucket = aws_s3_bucket.wordpress_uploads.id
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "wordpress_uploads" {
  bucket = aws_s3_bucket.wordpress_uploads.id
  
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lifecycle rules for cost optimization
resource "aws_s3_bucket_lifecycle_configuration" "wordpress_uploads" {
  bucket = aws_s3_bucket.wordpress_uploads.id
  
  rule {
    id     = "transition-to-ia"
    status = "Enabled"
    
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    
    expiration {
      days = 365
    }
    
    filter {
      prefix = "uploads/"
    }
  }
  
  rule {
    id     = "abort-incomplete-multipart"
    status = "Enabled"
    
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

# CloudFront Distribution for S3 (CDN)
resource "aws_cloudfront_distribution" "wordpress_uploads" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  
  origin {
    domain_name = aws_s3_bucket.wordpress_uploads.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.wordpress_uploads.id}"
    
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.wordpress_uploads.cloudfront_access_identity_path
    }
  }
  
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.wordpress_uploads.id}"
    
    forwarded_values {
      query_string = false
      
      cookies {
        forward = "none"
      }
    }
    
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  
  tags = var.tags
}

resource "aws_cloudfront_origin_access_identity" "wordpress_uploads" {
  comment = "OAI for WordPress uploads bucket"
}

# Bucket policy for CloudFront
resource "aws_s3_bucket_policy" "wordpress_uploads" {
  bucket = aws_s3_bucket.wordpress_uploads.id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.wordpress_uploads.iam_arn
        }
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.wordpress_uploads.arn}/*"
      }
    ]
  })
}