output "random_bucket_name" {
  value = random_string.bucket_name.result
}

output "bucket-name" {
  value = aws_s3_bucket.my_bucket.tags
}