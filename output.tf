output "website" {
  value = "http://${aws_s3_bucket.b.website_endpoint}"
}
