
output "bucket-name" {
  value = aws_s3_bucket.website_bucket.bucket
  sensitive = true
}

output "website_endpoint" {
  description = "Website bucket url"
  value = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}

# output "cdn_domain_name" {
#   value = aws_cloudfront_distribution.s3_distribution.domain_name
# }