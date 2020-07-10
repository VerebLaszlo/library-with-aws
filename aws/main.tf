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
  vpc_cidr = var.vpc_cidr
  public_cidrs = var.public_cidrs
  private_cidrs = var.private_cidrs
  access_ip = var.access_ip
}

module us-west-2  {
  source = "./region"
  project_name = var.project_name
  tags = var.tags

  region = "us-west-2"
  vpc_cidr = var.vpc_cidr
  public_cidrs = var.public_cidrs
  private_cidrs = var.private_cidrs
  access_ip = var.access_ip
}
