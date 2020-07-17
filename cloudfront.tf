

resource "aws_cloudfront_distribution" "webdistributionn" {
  origin {
    domain_name = "${aws_s3_bucket.poojaabucket.bucket_regional_domain_name}"
    origin_id   = "${aws_s3_bucket.poojaabucket.id}"
  }


  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Web Distributionn"


  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${aws_s3_bucket.poojaabucket.id}"


    forwarded_values {
      query_string = false


      cookies {
        forward = "none"
      }
    }


    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }


  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["IN"]
    }
  }


  tags = {
    Name        = "Webdistribution"
    Environment = "Production"
  }


  viewer_certificate {
    cloudfront_default_certificate = true
  }


  depends_on = [
    aws_s3_bucket.poojaabucket
  ]
}