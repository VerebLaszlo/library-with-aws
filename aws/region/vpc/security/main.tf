#
resource aws_route_table_association private-subnet-association {
  count = length(aws_subnet.private-subnet)

  subnet_id = aws_subnet.private-subnet.*.id[count.index]
  route_table_id = var.route-table.id

  depends_on = [var.route-table, aws_subnet.private-subnet]
}

data aws_availability_zones all {}

# Depends on autoscaled instances
resource aws_subnet private-subnet {
  count = min(2, length(data.aws_availability_zones.all))

  vpc_id = var.vpc-id
  cidr_block = var.cidrs[count.index]
  availability_zone = data.aws_availability_zones.all.names[count.index]
  map_public_ip_on_launch = false

  tags = merge({
    Name = "snPrivate${var.project-name}-${data.aws_availability_zones.all.names[count.index]}" },
    var.tags
  )
}

resource aws_network_acl nacl-private-main {
  vpc_id = var.vpc-id
  tags = merge({
    Name = "nacl${var.project-name}"},
    var.tags
  )
  subnet_ids = aws_subnet.private-subnet.*.id
}

resource aws_network_acl_rule naclr-inbound-http {
  network_acl_id = aws_network_acl.nacl-private-main.id
  rule_number = 100
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = 8080
  to_port = 8080
  rule_action = "allow"
  egress = false
}

resource aws_network_acl_rule naclr-inbound-https {
  network_acl_id = aws_network_acl.nacl-private-main.id
  rule_number = 110
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = 443
  to_port = 443
  rule_action = "allow"
  egress = false
}

resource aws_network_acl_rule naclr-inbound-ssh {
  network_acl_id = aws_network_acl.nacl-private-main.id
  rule_number = 120
  cidr_block = var.vpc-cidr
  protocol = "tcp"
  from_port = 22
  to_port = 22
  rule_action = "allow"
  egress = false
}

resource aws_network_acl_rule naclr-inbound-response {
  network_acl_id = aws_network_acl.nacl-private-main.id
  rule_number = 140
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = 32768
  to_port = 65535
  rule_action = "allow"
  egress = false
}

resource aws_network_acl_rule naclr-outbound-http {
  network_acl_id = aws_network_acl.nacl-private-main.id
  rule_number = 100
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = 80
  to_port = 80
  rule_action = "allow"
  egress = true
}

resource aws_network_acl_rule naclr-outbound-https {
  network_acl_id = aws_network_acl.nacl-private-main.id
  rule_number = 110
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = 443
  to_port = 443
  rule_action = "allow"
  egress = true
}

resource aws_network_acl_rule naclr-outbound-response {
  network_acl_id = aws_network_acl.nacl-private-main.id
  rule_number = 140
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = 32768
  to_port = 65535
  rule_action = "allow"
  egress = true
}
