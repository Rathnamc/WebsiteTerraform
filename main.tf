provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "cdf-exchange.com-tf-state"
    region = "us-east-1"
  }
}

variable "env_prefix" {}
variable "is_temp_env" {
  default = false
}
variable "bucket" {
  default = "rathnam-acd-bucket"
}

resource "aws_s3_bucket" "b" {
  bucket = "${var.env_prefix}-${var.bucket}"
  acl    = "public-read"
  force_destroy = var.is_temp_env

  website {
    index_document = "index.html"
  }
  tags = {
    ManagedBy = "terraform"
  }

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::rathnam-acd-bucket/*"
    }
  ]
}
  POLICY
}

output "website" {
  value = "http://${aws_s3_bucket.b.website_endpoint}"
}
