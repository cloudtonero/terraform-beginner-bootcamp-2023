output "bucket_name" {
  description = "Bucket name for our static website "
  value       = module.home_arcanum.bucket-name
}

output "s3_website_endpoint" {
  value = module.home_arcanum.website_endpoint
}

output "arcanum_cdn_domain_name" {
  value = module.home_arcanum.cdn_domain_name
}

output "akara_cdn_domain_name" {
  value = module.home_akara.cdn_domain_name
}
