# Library AWS resources
module iam {
  source = "./iam"
  tags = var.tags
}

resource aws_s3_bucket library-learning {
  bucket = "library-learning"
  region = var.region
  force_destroy = true
  versioning {
    enabled = true
    mfa_delete = false
  }

  tags = var.tags
}

resource aws_s3_bucket_object library-log-file {
  bucket = aws_s3_bucket.library-learning.bucket
  key = "release/log4j2.yaml"
  content = "./log4j2.yaml"
  acl = "public-read"

  tags = var.tags
}

locals {
  local-image-path = "${path.cwd}/../src/main/webapp/WEB-INF/static/"
  origin-path = "/static"
  origin-id = "S3-library-learning${local.origin-path}"
  bucket = ""
  key = ""
}

resource aws_s3_bucket_object static-resources {
  for_each = fileset(local.local-image-path, "**/*.*")
  bucket = aws_s3_bucket.library-learning.bucket
  key = "static/${each.value}"
  source = "${local.local-image-path}${each.value}"
  acl = "public-read"
  tags = var.tags
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

data template_file run-library {
  vars = {
    S3_BUCKET_NAME = aws_s3_bucket.library-learning.bucket
  }
  template = replace(file("run-library.sh"), "\r\n", "\n")
}

resource aws_s3_bucket_object run-library {
  bucket = aws_s3_bucket.library-learning.bucket
  key = "release/run-library.sh"
  content = data.template_file.run-library.rendered
  acl = "public-read"
  depends_on = [data.template_file.run-library]

  tags = var.tags
}

resource aws_route53_zone primary {
  name = var.domain-name
  comment = "Access all library endpoints."
  force_destroy = true

  tags = var.tags
}

module us-east-1 {
  source = "./region"
  project-name = var.project-name
  tags = var.tags

  region = "us-east-1"
  instance-type = var.instance-type
  image-owners = var.image-owners
  image-name-prefixes = var.image-name-prefixes
  vpc-cidr = var.vpc-cidr
  public-cidrs = var.public-cidrs
  private-cidrs = var.private-cidrs
  access-ip = var.access-ip
  s3-bucket-name = aws_s3_bucket.library-learning.bucket
  cloudfront-domain-name = aws_cloudfront_distribution.cfd-images.domain_name
  accessArtifactInS3-policy = module.iam.accessArtifactInS3-policy
  ec2-instance-profile-name = module.iam.ec2-instance-profile-name
  zone-id = aws_route53_zone.primary.zone_id
  domain-name = var.domain-name
  route-policy-weight = 100

  providers = {
    aws = aws.us-east-1
  }
}

module us-west-2 {
  source = "./region"
  project-name = var.project-name
  tags = var.tags

  region = "us-west-2"
  instance-type = var.instance-type
  image-owners = var.image-owners
  image-name-prefixes = var.image-name-prefixes
  vpc-cidr = var.vpc-cidr
  public-cidrs = var.public-cidrs
  private-cidrs = var.private-cidrs
  access-ip = var.access-ip
  s3-bucket-name = aws_s3_bucket.library-learning.bucket
  cloudfront-domain-name = aws_cloudfront_distribution.cfd-images.domain_name
  accessArtifactInS3-policy = module.iam.accessArtifactInS3-policy
  ec2-instance-profile-name = module.iam.ec2-instance-profile-name
  zone-id = aws_route53_zone.primary.zone_id
  domain-name = var.domain-name
  route-policy-weight = 100

  providers = {
    aws = aws.us-west-2
  }
}
