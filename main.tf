#Random provider to generate a random string
resource "random_string" "bucket_name" {
  length           = 16
  special          = false
  numeric = false
  upper = false
}


## s3 bucket 
resource "aws_s3_bucket" "my_bucket" {
  bucket = "mrtonero-${random_string.bucket_name.result}"

  tags = {
    UserUuid = var.user_uuid
  }
}

