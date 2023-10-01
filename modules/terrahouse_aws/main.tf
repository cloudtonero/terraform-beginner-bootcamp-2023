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

