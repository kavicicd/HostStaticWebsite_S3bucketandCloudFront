provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "terraform" {
  bucket = "terraformtest.kavicid.in"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  versioning {
    enabled = false
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE"]
    allowed_origins = ["https://${data.aws_cloudfront_distribution.terraform_cdn_data.domain_name}"]
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE"]
    allowed_origins = ["https://terraformtest.kavicid.in"]
  }

  cors_rule {
    allowed_methods = ["GET", "PUT", "POST", "DELETE"]
    allowed_origins = ["*"]
  }

  tags = {
    name = "terraform_angular"
  }

  acl           = "private"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "terraform" {
  bucket = aws_s3_bucket.terraform.id
  policy = file("s3_bucket_policy.json")
}

resource "aws_s3_bucket_public_access_block" "terraform" {
  bucket              = aws_s3_bucket.terraform.id
  block_public_acls   = false
  block_public_policy = false
}



resource "null_resource" "upload_angular_build" {
  depends_on = [aws_s3_bucket.terraform, aws_cloudfront_distribution.terraform_cdn]
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "aws s3 cp D:\\Terraform\\code_deploy_terraform\\angular\\ s3://terraformtest.kavicid.in/ --recursive"
  }
}
