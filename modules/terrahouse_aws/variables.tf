variable "b-name" {
  default = "mrtonero007"
}


variable "user_uuid" {
  type        = string
  description = "User UUID in the desired format"
  
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "User UUID must be in the format 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' where x is a hexadecimal digit."
  }
}

variable "bucket_name" {
  description = "AWS S3 Bucket Name"
  type        = string

  validation {
    condition     = can(regex("^([a-z0-9.-]+)$", var.bucket_name)) && length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
    error_message = "Invalid bucket_name. Bucket names must be between 3 and 63 characters, start and end with a lowercase letter or number, and can contain only lowercase letters, numbers, hyphens, and periods."
  }
}


variable "index_html_filepath" {
  description = "Path to the index.html file"
  type        = string

  validation {
    condition     = (fileexists(var.index_html_filepath))
    error_message = "The specified index.html file does not exist at the given path."
  }
}

variable "error_html_filepath" {
  description = "Path to the error.html file"
  type        = string

  validation {
    condition     = (fileexists(var.error_html_filepath))
    error_message = "The specified error.html file does not exist at the given path."
  }
}

variable "content_version" {
  description = "Content Version (Positive Integer)"
  type        = number

  validation {
    condition     = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "Content version must be a positive integer."
  }
}

variable "assets_path" {
  description = "Path to asset folder"
  type = string
  
}