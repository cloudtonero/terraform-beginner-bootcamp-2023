
# s3 bucket 
resource "aws_s3_bucket" "website_bucket" {
 

  tags = {
    UserUuid = var.user_uuid
  }
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object
resource "aws_s3_object" "index-object" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  content_type = "text/html"
  source = "${var.public_path}/index.html"
  etag = filemd5("${var.public_path}/index.html")

  lifecycle {
    replace_triggered_by = [ terraform_data.content_version.output]
    ignore_changes = [ etag ]
  }
}

resource "aws_s3_object" "error-object" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key = "error.html"
  content_type = "text/html"
  source = "${var.public_path}/error.html"
  etag = filemd5("${var.public_path}/error.html")

   lifecycle {
    #replace_triggered_by = [ terraform_data.content_version.output]
    ignore_changes = [ etag ]
  }
}


resource "aws_s3_object" "upload_assets" {
  for_each = fileset("${var.public_path}/assets" ,"*.{jpeg,png,gif}")
  bucket = aws_s3_bucket.website_bucket.bucket
  key = "assets/${each.key}"
  source = "${var.public_path}/assets/${each.key}"
  #content_type = "text/html"
  etag = filemd5("${var.public_path}/assets/${each.key}")

  lifecycle {
    replace_triggered_by = [ terraform_data.content_version.output]
    ignore_changes = [ etag ]
  }

}


#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}


resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.bucket
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = {
      "Sid" = "AllowCloudFrontServicePrincipalReadOnly",
      "Effect" = "Allow",
      "Principal" = {
        "Service" = "cloudfront.amazonaws.com"
      },
      "Action" = "s3:GetObject",
      "Resource" = "arn:aws:s3:::${aws_s3_bucket.website_bucket.id}/*",
      "Condition" = {
        "StringEquals" = {
          #"AWS:SourceArn" = data.aws_caller_identity.current.arn
          "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"

        }
      }
    }, 
  })
}

resource "terraform_data" "content_version" {
  input = var.content_version
}