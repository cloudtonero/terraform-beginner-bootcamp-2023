variable "user_uuid" {
  type        = string
  description = "User UUID in the desired format"
}

variable "bucket_name" {
  description = "AWS S3 Bucket Name"
  type        = string
}

variable "index_html_filepath" {
  description = "Path to the index.html file"
  type        = string
}

variable "error_html_filepath" {
  description = "Path to the error.html file"
  type        = string
}