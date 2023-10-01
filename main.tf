
## s3 bucket 
resource "aws_s3_bucket" "website_bucket" {
  bucket = "mrtonero-${var.bucket_name}" 

  tags = {
    UserUuid = var.user_uuid
  }
}

