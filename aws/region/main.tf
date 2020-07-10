/* Container module for all of the network resources within a region. This is instantiated once per region. */
provider aws {
  version = "~> 2.69"
  region = var.region
}

module vpc {
  source = "./vpc"
  project_name = var.project_name
  tags = var.tags

  region = var.region
  vpc_cidr = var.vpc_cidr
  public_cidrs = var.public_cidrs
  private_cidrs = var.private_cidrs
  access_ip = var.access_ip
}
