variable "teacherseat_user_uuid" {
  type        = string
  description = "User UUID in the desired format"
}

variable "terratowns_access_token" {
  type = string
}

variable "terratowns_endpoint" {
  type = string
}

variable "bucket_name" {
  description = "AWS S3 Bucket Name"
  type        = string
}

variable "arcanum" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "akara" {
  type = object({
    public_path = string
    content_version = number
  })
}


