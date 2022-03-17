output "website" {
  value = "http://${aws_s3_bucket.cdf-exchange.com.website_endpoint}"
}
