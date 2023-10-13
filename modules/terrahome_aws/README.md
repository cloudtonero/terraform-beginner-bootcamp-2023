## Terrahome AWS

The following directory 

```tf
module "home_arcanum" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.arcanum_public_path
  bucket_name = var.bucket_name
  content_version = var.content_version
 
}
```
The public directory expect the following 
- index.html
- error.html
- assets

All top level files in assets will be copied. but not any sub-directories.