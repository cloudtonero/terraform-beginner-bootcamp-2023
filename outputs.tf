output "bucket_name" {
  description = "Bucket name for our static website "
  value = module.terrahouse_aws.bucket-name
}

output "s3_website_endpoint" {
  value = module.terrahouse_aws.website_endpoint
}

output "cdn_domain_name" {
  value = module.terrahouse_aws.cdn_domain_name
}