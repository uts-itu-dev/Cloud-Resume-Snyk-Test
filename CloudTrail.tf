

resource "aws_cloudtrail" "m" {
  name                          = "CloudTrail-Snyk"
  s3_bucket_name                = aws_s3_bucket.b.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false

  enable_logging = false
}