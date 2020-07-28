/* Container module for all of the network resources within a region. This is instantiated once per region. */
module iam {
  source = "./iam"
  tags = var.tags
}

module vpc {
  source = "./vpc"
  project-name = var.project_name
  tags = var.tags

  region = var.region
  vpc-cidr = var.vpc_cidr
  public-cidrs = var.public_cidrs
  private-cidrs = var.private_cidrs
  access-ip = var.access_ip
}

module load-balancer {
  source = "./load-balancer"
  project-name = var.project_name
  tags = var.tags

  vpc-id = module.vpc.id
  subnet-ids = module.vpc.public-subnet-ids
}

module auto-scaling {
  source = "./auto-scaling"
  project-name = var.project_name
  tags = var.tags

  vpc-id = module.vpc.id
  image-id = var.image_id
  instance-type = var.instance_type
  s3-bucket-name = var.s3_bucket_name
  subnet-ids = module.vpc.public-subnet-ids
  target-group-arn = module.load-balancer.target-group-arn
  ec2-instance-profile = module.iam.ec2-instance-profile-name
  accessArtifactInS3-policy = module.iam.accessArtifactInS3-policy
}
