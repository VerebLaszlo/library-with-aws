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

data aws_ami linux {
  most_recent = true
  filter {
    name = "name"
    values = var.ami_name_filter
  }
  owners = var.ami_owner_ids
}

resource aws_instance library {
  ami = data.aws_ami.linux.id
  instance_type = var.instance_type

  tags = merge({
    Name = "${var.project_name}_ec2" }, {
    Image = data.aws_ami.linux.description },
    var.tags
  )
}

data aws_availability_zones all {
  state = "available"
}

resource aws_ebs_volume library {
  availability_zone = data.aws_availability_zones.all.names[0]
  encrypted = false
  multi_attach_enabled = false
  iops = 100
  type = "gp2"
  size = 1

  tags = merge({
    Name = "${var.project_name}_volume" },
    var.tags
  )
}

resource aws_lb public_library {
  name = "${var.project_name}-public-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [module.vpc.public_sg_id]
  subnets = module.vpc.public_subnet_ids

  enable_deletion_protection = false

  tags = var.tags
}

resource aws_lb private_library {
  name = "${var.project_name}-private-lb"
  internal = true
  load_balancer_type = "application"
  security_groups = [module.vpc.private_sg_id]
  subnets = module.vpc.private_subnet_ids

  enable_deletion_protection = false

  tags = var.tags
}
