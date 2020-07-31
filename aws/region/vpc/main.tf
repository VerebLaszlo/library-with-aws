// Virtual Private Cloud configuration
resource aws_vpc vpc-main {
  cidr_block = var.vpc-cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = merge({
    Name = "vpc${var.project-name}_${var.region}" },
    var.tags
  )
}

resource aws_internet_gateway igw {
  vpc_id = aws_vpc.vpc-main.id

  tags = merge({
    Name = "igw${var.project-name}" },
    var.tags
  )
}

#public resources
resource aws_route_table public-route-table {
  vpc_id = aws_vpc.vpc-main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge({
    Name = "rtPublic${var.project-name}" },
    var.tags
  )
}

module public {
  source = "./public"
  project-name = var.project-name
  tags = var.tags

  is-public = true
  vpc-id = aws_vpc.vpc-main.id
  cidrs = var.public-cidrs
  route-table = aws_route_table.public-route-table
}

resource aws_ec2_transit_gateway tgw-main {
  description = "The main transit gateway."
  amazon_side_asn = 64512
  auto_accept_shared_attachments = "disable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  dns_support = "enable"
  vpn_ecmp_support = "enable"

  tags = merge({
    Name = "tgw${var.project-name}"},
    var.tags
  )
}

resource aws_ec2_transit_gateway_vpc_attachment tgwa-main {
  transit_gateway_id = aws_ec2_transit_gateway.tgw-main.id
  vpc_id = aws_vpc.vpc-main.id
  dns_support = "enable"

  subnet_ids = module.public.subnet-ids

  tags = merge({
    Name = "tgwa${var.project-name}"},
    var.tags
  )
}

/*
# causes conflict
resource aws_route main-route {
  route_table_id = aws_route_table.public-route-table.id
  transit_gateway_id = aws_ec2_transit_gateway.tgw-main.id
  destination_cidr_block = "0.0.0.0/0"
}
*/
#endregion

#region private resources
resource aws_eip eip {
  vpc = true

  tags = merge({
    Name = "eip${var.project-name}"},
    var.tags
  )
}

resource aws_nat_gateway nat-gateway {
  allocation_id = aws_eip.eip.id
  # TODO investigate which subnet to choose
  subnet_id = module.public.subnet-ids[0]

  depends_on = [aws_internet_gateway.igw]

  tags = merge({
    Name = "natgw${var.project-name}"},
    var.tags
  )
}

resource aws_default_route_table private-route-table {
  default_route_table_id = aws_vpc.vpc-main.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = merge({
    Name = "rtPrivate${var.project-name}" },
    var.tags
  )
}

module private {
  source = "./security"
  project-name = var.project-name
  tags = var.tags

  is-public = false
  vpc-id = aws_vpc.vpc-main.id
  vpc-cidr = aws_vpc.vpc-main.cidr_block
  cidrs = var.private-cidrs
  route-table = aws_default_route_table.private-route-table
  http-inbound-port = 8080
  http-outbound-port = 80
}
#endregion

resource aws_security_group main {
  name = "sg${var.project-name}"
  description = "The main security group."
  vpc_id = aws_vpc.vpc-main.id

  tags = var.tags
}

resource aws_security_group_rule ssh-inbound-access {
  description = "SSH inbound traffic."

  type = "ingress"
  protocol = "tcp"
  from_port = 22
  to_port = 22
  security_group_id = aws_security_group.main.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource aws_security_group_rule http_inbound_access {
  description = "Http inbound traffic."

  type = "ingress"
  protocol = "tcp"
  from_port = 80
  to_port = 80
  security_group_id = aws_security_group.main.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource aws_security_group_rule all_outbound_access {
  description = "All outbound traffic."

  type = "egress"
  protocol = "-1"
  from_port = 0
  to_port = 0
  security_group_id = aws_security_group.main.id
  cidr_blocks = ["0.0.0.0/0"]
}
