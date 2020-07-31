#
locals {
  resource-name = "${var.is-public ? "Public" : "Private"}${var.project-name}"
}

data aws_availability_zones all {}

resource aws_subnet public-subnet {
  count = min(2, length(data.aws_availability_zones.all))

  vpc_id = var.vpc-id
  cidr_block = var.cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.all.names[count.index]

  tags = merge({
    Name = "sn${local.resource-name}-${data.aws_availability_zones.all.names[count.index]}" },
    var.tags
  )
}

resource aws_route_table_association public-subnet-association {
  count = length(aws_subnet.public-subnet)

  subnet_id = aws_subnet.public-subnet.*.id[count.index]
  route_table_id = var.route-table.id

  depends_on = [var.route-table, aws_subnet.public-subnet]
}

resource aws_network_acl nacl-main {
  vpc_id = var.vpc-id
  subnet_ids = aws_subnet.public-subnet[*].id

  tags = merge({
    Name = "nacl${local.resource-name}"},
    var.tags
  )
}

resource aws_network_acl_rule naclr-inbound-http {
  network_acl_id = aws_network_acl.nacl-main.id
  rule_number = 100
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = 80
  to_port = 80
  rule_action = "allow"
  egress = false
}

resource aws_network_acl_rule naclr-inbound-https {
  network_acl_id = aws_network_acl.nacl-main.id
  rule_number = 110
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = 443
  to_port = 443
  rule_action = "allow"
  egress = false
}

resource aws_network_acl_rule naclr-inbound-response {
  network_acl_id = aws_network_acl.nacl-main.id
  rule_number = 120
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = 1024
  to_port = 65535
  rule_action = "allow"
}

resource aws_network_acl_rule naclr-outbound-http {
  network_acl_id = aws_network_acl.nacl-main.id
  rule_number = 100
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = 80
  to_port = 80
  rule_action = "allow"
  egress = true
}

resource aws_network_acl_rule naclr-outbound-https {
  network_acl_id = aws_network_acl.nacl-main.id
  rule_number = 110
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  rule_action = "allow"
  from_port = 443
  to_port = 443
  egress = true
}

resource aws_network_acl_rule naclr-outbound-response {
  network_acl_id = aws_network_acl.nacl-main.id
  rule_number = 120
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = 1024
  to_port = 65535
  rule_action = "allow"
  egress = true
}
