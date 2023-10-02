terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.17.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}



## s3 bucket 
resource "aws_s3_bucket" "website_bucket" {
  bucket = "mrtonero-${var.bucket_name}" 

  tags = {
    UserUuid = var.user_uuid
  }
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object
resource "aws_s3_object" "index-object" {
  bucket = aws_s3_bucket.website_bucket.id
  key    = "index.html"
  source = var.index_html_filepath
  etag = filemd5(var.index_html_filepath)
}
resource "aws_s3_object" "error-object" {
  bucket = aws_s3_bucket.website_bucket.id
  key = "error.html"
  source = var.error_html_filepath
  etag = filemd5(var.error_html_filepath)
}
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}


