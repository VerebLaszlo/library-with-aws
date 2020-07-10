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
