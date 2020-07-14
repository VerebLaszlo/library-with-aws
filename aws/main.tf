//
provider  aws  {
  version = "~>2.69"
  region = var.region
}

module us-east-1  {
  source = "./region"
  project_name = var.project_name
  tags = var.tags

  region = "us-east-1"
  instance_type = var.instance_type
  ami_owner_ids = var.ami_owner_ids
  ami_name_filter = var.ami_name_filter
  vpc_cidr = var.vpc_cidr
  public_cidrs = var.public_cidrs
  private_cidrs = var.private_cidrs
  access_ip = var.access_ip
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
}
*/

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
