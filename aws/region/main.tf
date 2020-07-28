/* Container module for all of the network resources within a region. This is instantiated once per region. */
module iam {
  source = "./iam"
  tags = var.tags
}

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
  image-id = var.image-id
  instance-type = var.instance-type
  s3-bucket-name = var.s3-bucket-name
  subnet-ids = module.vpc.public-subnet-ids
  target-group-arn = module.load-balancer.target-group-arn
  ec2-instance-profile = module.iam.ec2-instance-profile-name
  accessArtifactInS3-policy = module.iam.accessArtifactInS3-policy
}
