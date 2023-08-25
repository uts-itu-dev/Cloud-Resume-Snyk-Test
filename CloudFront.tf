

resource "aws_cloudfront_distribution" "m" {
  origin {
    domain_name = aws_s3_bucket.b.bucket_regional_domain_name
    origin_id   = "MW-CloudResume-CloudFront-Origin"
    s3_origin_config = {
      origin_access_identity = aws_cloudfront_origin_access_identity.m.cloudfront_access_identity_path
    }
  }

  enabled = true
  is_ipv6_enabled = true
  default_root_object = "index.html"

  default_cache_behaviour {
    # CachingDisabled managed policy.
    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    path_pattern = "*"
    target_origin_id = "MW-CloudResume-CloudFront-Origin"
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

resource "aws_cloudfront_origin_access_identity" "m" {
  comment = "Used for MW CloudFront Origin Access Identity."
}