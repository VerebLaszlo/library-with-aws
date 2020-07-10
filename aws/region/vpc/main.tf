// Virtual Private Cloud configuration
resource aws_vpc library {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = merge({
    Name = "${var.project_name}_${var.region}_vpc" },
    var.tags
  )
}

resource aws_default_network_acl library {
  default_network_acl_id = aws_vpc.library.default_network_acl_id
  subnet_ids = concat(tolist(aws_subnet.library_private.*.id), tolist(aws_subnet.library_public.*.id))
  ingress {
    protocol = "-1"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
  egress {
    protocol = "-1"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  tags = merge({
    Name = "${var.project_name}_acl" },
    var.tags
  )
}

resource aws_internet_gateway library {
  vpc_id = aws_vpc.library.id

  tags = merge({
    Name = "${var.project_name}_igw" },
    var.tags
  )
}

data aws_availability_zones all {
  state = "available"
}

#region public resources
resource aws_route_table library_public {
  vpc_id = aws_vpc.library.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.library.id
  }

  tags = merge({
    Name = "${var.project_name}_public_rt" },
    var.tags
  )
}

resource aws_subnet library_public {
  count = min(2, length(data.aws_availability_zones.all))

  vpc_id = aws_vpc.library.id
  cidr_block = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.all.names[count.index]

  tags = merge({
    Name = "${var.project_name}_public_sn_${count.index + 1}" },
    var.tags
  )
}

resource aws_route_table_association library_public {
  count = length(aws_subnet.library_public)

  subnet_id = aws_subnet.library_public.*.id[count.index]
  route_table_id = aws_route_table.library_public.id
}

resource aws_security_group library_public {
  name = "${var.project_name}_public_sg"
  description = "Used for access to the public instances"
  vpc_id = aws_vpc.library.id

  #region SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.access_ip]
  }
  #endregion
  #region HTTP
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [var.access_ip]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #endregion

  tags = var.tags
}
#endregion

#region private resources
resource aws_default_route_table library_private {
  default_route_table_id = aws_vpc.library.default_route_table_id

  tags = merge({
    Name = "${var.project_name}_private_rt" },
    var.tags
  )
}

resource aws_subnet library_private {
  count = min(2 , length(data.aws_availability_zones.all))

  vpc_id = aws_vpc.library.id
  cidr_block = var.private_cidrs[count.index]
  availability_zone = data.aws_availability_zones.all.names[count.index]

  tags = merge({
    Name = "${var.project_name}_private_sn_${count.index + 1}" },
    var.tags
  )
}

resource aws_route_table_association library_private {
  count = length(aws_subnet.library_private)

  subnet_id = aws_subnet.library_private.*.id[count.index]
  route_table_id = aws_default_route_table.library_private.id
}

resource aws_security_group library_private {
  name = "${var.project_name}_private_sg"
  description = "Used for access to the private instances"
  vpc_id = aws_vpc.library.id

  #region SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [aws_security_group.library_public.id]
  }
  #endregion
  #region HTTP
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.library_public.id]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #endregion

  tags = var.tags
}
#endregion
