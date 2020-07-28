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

data aws_availability_zones all {}

#region public resources
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

resource aws_subnet public-subnet {
  count = min(2, length(data.aws_availability_zones.all))

  vpc_id = aws_vpc.vpc-main.id
  cidr_block = var.public-cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.all.names[count.index]

  tags = merge({
    Name = "snPublic${var.project-name}-${data.aws_availability_zones.all.names[count.index]}" },
    var.tags
  )
}

resource aws_route_table_association public-subnet-association {
  count = length(aws_subnet.public-subnet)

  subnet_id = aws_subnet.public-subnet.*.id[count.index]
  route_table_id = aws_route_table.public-route-table.id

  depends_on = [aws_route_table.public-route-table, aws_subnet.public-subnet]
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

  subnet_ids = aws_subnet.public-subnet[*].id

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
  subnet_id = aws_subnet.public-subnet[0].id

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

resource aws_route_table_association private-subnet-association {
  count = length(aws_subnet.private-subnet)

  subnet_id = aws_subnet.private-subnet.*.id[count.index]
  route_table_id = aws_default_route_table.private-route-table.id

  depends_on = [aws_default_route_table.private-route-table, aws_subnet.private-subnet]
}

resource aws_subnet private-subnet {
  count = min(2, length(data.aws_availability_zones.all))

  vpc_id = aws_vpc.vpc-main.id
  cidr_block = var.private-cidrs[count.index]
  availability_zone = data.aws_availability_zones.all.names[count.index]

  tags = merge({
    Name = "snPrivate${var.project-name}-${data.aws_availability_zones.all.names[count.index]}" },
    var.tags
  )
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
