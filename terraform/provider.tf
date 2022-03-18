provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "cdf-exchange.com-tf-state"
    region = "us-east-1"
  }
}