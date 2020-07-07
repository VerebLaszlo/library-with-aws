/* Container module for all of the network resources within a region. This is instantiated once per region. */

resource "aws_vpc" "library" {
  cidr_block = cidrsubnet(var.base_cidr_block, 4, lookup(var.region_numbers, var.region))

  tags = var.tags
}

data "aws_availability_zones" "all" {}

resource "aws_internet_gateway" "library_igw" {
  vpc_id = aws_vpc.library.id

  tags = var.tags
}

resource "aws_network_acl" "library_acl" {
  vpc_id = aws_vpc.library.id

  ingress {
    from_port = 0
    to_port = 0
    rule_no = 100
    action = "allow"
    protocol = "-1"
    cidr_block = "0.0.0.0/0"
  }
  egress {
    from_port = 0
    to_port = 0
    rule_no = 100
    action = "allow"
    protocol = "-1"
    cidr_block = "0.0.0.0/0"
  }

  tags = var.tags
}

resource "aws_security_group" "library-sg-open" {
  name        = "library-sg-open"
  description = "Open access within this region"
  vpc_id      = aws_vpc.library.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [aws_vpc.library.cidr_block]
  }

  tags = var.tags
}

resource "aws_security_group" "library-sg-internal" {
  name        = "library-sg-internal"
  description = "Open access within the full internal network"
  vpc_id      = aws_vpc.library.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.base_cidr_block]
  }

  tags = var.tags
}

module "primary_subnet" {
  source = "./zone"
  vpc_id = aws_vpc.library.id
  availability_zone = data.aws_availability_zones.all.names[0]
}

module "secondary_subnet" {
  source = "./zone"
  vpc_id = aws_vpc.library.id
  availability_zone = data.aws_availability_zones.all.names[1]
}
