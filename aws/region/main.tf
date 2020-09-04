/* Container module for all of the network resources within a region. This is instantiated once per region. */
module vpc {
  source = "./vpc"
  project-name = var.project-name
  tags = var.tags

  region = var.region
  vpc-cidr = var.vpc-cidr
  public-cidrs = var.public-cidrs
  private-cidrs = var.private-cidrs
  access-ip = var.access-ip
}

module load-balancer {
  source = "./load-balancer"
  project-name = var.project-name
  tags = var.tags

  vpc-id = module.vpc.id
  subnet-ids = module.vpc.public-subnet-ids
}

module auto-scaling {
  source = "./auto-scaling"
  project-name = var.project-name
  tags = var.tags

  vpc-id = module.vpc.id
  image-owners = var.image-owners
  image-name-prefixes = var.image-name-prefixes
  instance-type = var.instance-type
  s3-bucket-name = var.s3-bucket-name
  cloudfront-domain-name = var.cloudfront-domain-name
  subnet-ids = module.vpc.private-subnet-ids
  dep-target-group = module.load-balancer.dep-target-group
  ec2-instance-profile = var.ec2-instance-profile-name
  accessArtifactInS3-policy = var.accessArtifactInS3-policy
}

resource aws_route53_record r53r-library {
  zone_id = var.zone-id
  name = "www.${var.domain-name}"
  type = "A"

  weighted_routing_policy {
    weight = var.route-policy-weight
  }

  set_identifier = var.region
  alias {
    evaluate_target_health = true
    name = module.load-balancer.url
    zone_id = module.load-balancer.zone-id
  }
}
