provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "website-acd-1"
    region = "us-east-1"
  }
}

variable "env_prefix" {}
variable "is_temp_env" {
    default = false
}

resource "aws_s3_bucket" "b" {
  bucket = "${var.env_prefix}website-acd-1"
  acl    = "public-read"
  force_destroy = var.is_temp_env

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.env_prefix}website-acd-1/*"
    }
  ]
}
  POLICY

  website {
    index_document = "index.html"
  }

  tags = {
    ManagedBy = "terraform"
  }
}

output "website" {
  value = "http://${aws_s3_bucket.b.website_endpoint}"
}
