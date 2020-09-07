# Security configuration
locals {
  resource-name = "${var.is-public ? "Public" : "Private"}${var.project-name}"
}

resource aws_route_table route-table {
  vpc_id = var.vpc-id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw-id
  }

  tags = merge({
    Name = "rt${local.resource-name}" },
  var.tags
  )
}

data aws_availability_zones all {
  state = "available"
}

# Depends on autoscaled instances
resource aws_subnet subnet {
  count = min(2, length(data.aws_availability_zones.all))

  vpc_id = var.vpc-id
  cidr_block = var.cidrs[count.index]
  map_public_ip_on_launch = var.is-public
  availability_zone = data.aws_availability_zones.all.names[count.index]

  tags = merge({
    Name = "sn${local.resource-name}-${data.aws_availability_zones.all.names[count.index]}" },
    var.tags
  )
}

resource aws_route_table_association subnet-association {
  count = length(aws_subnet.subnet)

  subnet_id = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.route-table.id

  depends_on = [aws_route_table.route-table, aws_subnet.subnet]
}

resource aws_network_acl acl {
  vpc_id = var.vpc-id
  subnet_ids = aws_subnet.subnet[*].id

  tags = merge({
    Name = "nacl${local.resource-name}"},
    var.tags
  )
}

resource aws_network_acl_rule acl-inbound-http-rule {
  network_acl_id = aws_network_acl.acl.id
  rule_number = 100
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = var.http-inbound-port
  to_port = var.http-inbound-port
  rule_action = "allow"
  egress = false
}

resource aws_network_acl_rule acl-inbound-https-rule {
  network_acl_id = aws_network_acl.acl.id
  rule_number = 110
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = 443
  to_port = 443
  rule_action = "allow"
  egress = false
}

resource aws_network_acl_rule acl-inbound-ssh-rule {
  count = var.is-public == true ? 0 : 1
  network_acl_id = aws_network_acl.acl.id
  rule_number = 120
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = 22
  to_port = 22
  rule_action = "allow"
  egress = false
}

resource aws_network_acl_rule aclr-inbound-response-rule {
  network_acl_id = aws_network_acl.acl.id
  rule_number = 140
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = var.response-port.from
  to_port = var.response-port.to
  rule_action = "allow"
  egress = false
}

resource aws_network_acl_rule aclr-outbound-http-rule {
  network_acl_id = aws_network_acl.acl.id
  rule_number = 100
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = var.http-outbound-port
  to_port = var.http-outbound-port
  rule_action = "allow"
  egress = true
}

resource aws_network_acl_rule acl-outbound-https-rule {
  network_acl_id = aws_network_acl.acl.id
  rule_number = 110
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = 443
  to_port = 443
  rule_action = "allow"
  egress = true
}

resource aws_network_acl_rule acl-outbound-response-rule {
  network_acl_id = aws_network_acl.acl.id
  rule_number = 140
  cidr_block = "0.0.0.0/0"
  protocol = "tcp"
  from_port = var.response-port.from
  to_port = var.response-port.to
  rule_action = "allow"
  egress = true
}
