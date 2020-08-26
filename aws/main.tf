# Library AWS resources
resource aws_s3_bucket library-learning {
  bucket = "library-learning"
  region = var.region
  force_destroy = false
  versioning {
    enabled = true
    mfa_delete = false
  }

  tags = var.tags
}

locals {
  origin-path = "/static"
  origin-id = "S3-library-learning${local.origin-path}"
}

resource aws_cloudfront_distribution cfd-images {
  enabled = true
  price_class = "PriceClass_100"
  is_ipv6_enabled = true
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  origin {
    domain_name = aws_s3_bucket.library-learning.bucket_domain_name
    origin_id = local.origin-id
    origin_path = local.origin-path
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    default_ttl = 300
    max_ttl = 600
    target_origin_id = local.origin-id
    viewer_protocol_policy = "allow-all"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  tags = var.tags
}

module us-east-1 {
  source = "./region"
  project-name = var.project-name
  tags = var.tags

  region = "us-east-1"
  instance-type = var.instance-type
  image-id = var.image-id
  vpc-cidr = var.vpc-cidr
  public-cidrs = var.public-cidrs
  private-cidrs = var.private-cidrs
  access-ip = var.access-ip
  s3-bucket-name = aws_s3_bucket.library-learning.bucket
  cloudfront-domain-name = aws_cloudfront_distribution.cfd-images.domain_name

  providers = {
    aws = aws.us-east-1
  }
}

/*
module us-west-2 {
  source = "./region"
  project_name = var.project_name
  tags = var.tags

  region = "us-west-2"
  instance_type = var.instance_type
  ami_owner_ids = var.ami_owner_ids
  ami_name_filter = var.ami_name_filter
  vpc_cidr = var.vpc_cidr
  public_cidrs = var.public_cidrs
  private_cidrs = var.private_cidrs
  access_ip = var.access_ip

  providers = {
    aws = aws.us-west-2
  }
}
*/

/*resource aws_cloudfront_distribution library {
  enabled = true
  is_ipv6_enabled = false
  comment = "Testing comment"
  price_class = "PriceClass_100"
  retain_on_delete = false*/
  /*
    origin_group {
      failover_criteria {
        status_codes = [
          403,
          404,
          500,
          502,
          503,
          504
        ]
      }
      member {
        origin_id = module.us-east-1.lb_id
      }
      member {
        origin_id = module.us-west-2.lb_id
      }
      origin_id = local.origin_group_id
    }
  */
/*  origin {
    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy = "http-only"
      origin_read_timeout = 30
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2"
      ]
    }
    domain_name = "library-public-lb-1302643233.us-east-1.elb.amazonaws.com"
//    origin_id = module.us-east-1.lb_id
  }*/
  /*
    origin {
      custom_origin_config {
        http_port = 80
        https_port = 443
        origin_keepalive_timeout = 5
        origin_protocol_policy = "http-only"
        origin_read_timeout = 30
        origin_ssl_protocols = [
          "TLSv1",
          "TLSv1.1",
          "TLSv1.2"
        ]
      }
      domain_name = "library-public-lb-607108992.us-west-2.elb.amazonaws.com"
      origin_id = module.us-west-2.lb_id
    }
  */
/*
  restrictions {
    geo_restriction {
      locations = []
      restriction_type = "none"
    }
  }
  viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version = "TLSv1"
  }
  default_cache_behavior {
    allowed_methods = [
      "GET",
      "HEAD"
    ]
    cached_methods = [
      "GET",
      "HEAD"
    ]
    compress = false
    default_ttl = 86400
    forwarded_values {
      cookies {
        forward = "none"
        whitelisted_names = []
      }
      headers = []
      query_string = false
    }
    //    target_origin_id = local.origin_group_id
//    target_origin_id = module.us-east-1.lb_id
    viewer_protocol_policy = "allow-all"
  }

  tags = var.tags
}
*/
