resource "aws_s3_bucket" "b" {
  bucket = "${var.env_prefix}-acd-cdf-exchange.com"
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
      "Resource": "arn:aws:s3:::${var.env_prefix}-acd-cdf-exchange.com/*"
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