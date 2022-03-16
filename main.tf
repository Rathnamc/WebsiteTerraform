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
    bucket = "${var.env_prefix}-website-acd-1"
    acl    = "public-read"
  
}