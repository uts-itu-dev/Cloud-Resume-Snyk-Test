

resource "aws_cloudfront_distribution" "m" {
  provider = aws.virginia

  origin {
    domain_name = aws_s3_bucket.b.bucket_regional_domain_name
    origin_id   = "MW-CloudResume-CloudFront-Origin"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.m.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    # CachingDisabled managed policy.
    cache_policy_id        = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "MW-CloudResume-CloudFront-Origin"
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["AU", "US"]
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.m.arn
    ssl_support_method  = "sni-only"
  }
}

resource "aws_cloudfront_origin_access_identity" "m" {
  comment = "Used for MW CloudFront Origin Access Identity."
}

resource "aws_route53_record" "m-cf-www" {
  zone_id = data.aws_route53_zone.m.zone_id
  name    = "www.${var.R53DomainName}"

  type = "A"

  alias {
    name                   = var.R53DomainName
    zone_id                = aws_cloudfront_distribution.m.hosted_zone_id
    evaluate_target_health = false
  }
}