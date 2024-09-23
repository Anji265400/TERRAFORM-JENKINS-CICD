# Declare the bucketname variable
variable "bucketname" {
  description = "The name of the S3 bucket"
  type        = string
}

# Create S3 bucket
resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucketname
}

# Set S3 bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.mybucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Configure public access settings
resource "aws_s3_bucket_public_access_block" "example" {
  bucket                   = aws_s3_bucket.mybucket.id
  block_public_acls        = false
  block_public_policy      = false
  ignore_public_acls       = false
  restrict_public_buckets  = false
}

# Set the ACL to public-read
resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]
  bucket = aws_s3_bucket.mybucket.id
  acl    = "public-read"
}

# Upload index.html to S3 bucket
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "index.html"
  source       = "${path.module}/index.html" # Adjusted the path
  acl          = "public-read"
  content_type = "text/html"
}

# Upload error.html to S3 bucket
resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "error.html"
  source       = "${path.module}/error.html" # Adjusted the path
  acl          = "public-read"
  content_type = "text/html"
}

# Upload style.css to S3 bucket
resource "aws_s3_object" "style" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "style.css"
  source       = "${path.module}/style.css" # Adjusted the path
  acl          = "public-read"
  content_type = "text/css"
}

# Upload script.js to S3 bucket
resource "aws_s3_object" "script" {
  bucket       = aws_s3_bucket.mybucket.id
  key          = "script.js"
  source       = "${path.module}/script.js" # Adjusted the path
  acl          = "public-read"
  content_type = "text/javascript"
}

# Configure S3 bucket as a website
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.mybucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
  depends_on = [ aws_s3_bucket_acl.example ]
}
