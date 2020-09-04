# Outputs
output cloutfront {
  value = aws_cloudfront_distribution.cfd-images.domain_name
}

output lb-url {
  value = [ module.us-east-1.lb-url, module.us-west-2.lb-url]
}

output s3-bucket {
  value = aws_s3_bucket.library-learning.id
}

output nameservers {
  value = aws_route53_zone.primary.name_servers
}
