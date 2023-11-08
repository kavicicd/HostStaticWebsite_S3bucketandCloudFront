
resource "aws_cloudfront_distribution" "swftest_cdn" {
  origin {
    domain_name = "terraformtest.kavicid.in.s3-website.us-east-2.amazonaws.com"
    origin_id   = "terraformtest.kavicid.in.s3.us-east-2.amazonaws.com"
    origin_path = "" # Path if your S3 bucket has one
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_All"

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "terraformtest.kavicid.in.s3.us-east-2.amazonaws.com"
    compress               = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    default_ttl = 3600
    min_ttl     = 3600
    max_ttl     = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  aliases = ["terraformtest.kavicid.in"]

  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:us-east-1:1234567890:certificate/4d297929-53a8-40d0-baca-fe79d43345435d"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  http_version = "http2"

  default_root_object = "index.html"

  comment = "terraformtest.kavicid.in"
}
data "aws_cloudfront_distribution" "swftest_cdn_data" {
  id = aws_cloudfront_distribution.swftest_cdn.id
}

output "cloudfront_domain_name" {
  value = data.aws_cloudfront_distribution.swftest_cdn_data.domain_name
}
