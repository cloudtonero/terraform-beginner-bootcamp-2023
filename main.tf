#Random provider to generate a random string
resource "random_string" "bucket_name" {
  length           = 16
  special          = false
  numeric = false
  upper = false
}

output "random_bucket_name" {
  value = random_string.bucket_name.result
}

variable "b-name" {
  default = "mrtonero"
}
## s3 bucket 
resource "aws_s3_bucket" "my_bucket" {
  bucket = "mrtonero-${random_string.bucket_name.result}"

  tags = {
    Name = "Bootcamp_Bucket"
  }
}

output "bucket-name" {
  value = aws_s3_bucket.my_bucket.tags
}