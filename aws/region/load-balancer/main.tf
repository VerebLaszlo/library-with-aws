# Load Balancer configuration
locals {
  lb-name = "lb${var.project-name}"
}

//region Security Group
resource aws_security_group sg-lb {
  name = "sgLoadBalancer${var.project-name}"
  description = "Security group for the ${local.lb-name} load balancer"
  vpc_id = var.vpc-id

  tags = var.tags
}

resource aws_security_group_rule inbound_ssh {
  description = "SSH inbound traffic."

  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  security_group_id = aws_security_group.sg-lb.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource aws_security_group_rule inbound_http {
  description = "Http inbound traffic."

  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  security_group_id = aws_security_group.sg-lb.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource aws_security_group_rule outbound_all {
  description = "All outbound traffic."

  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  security_group_id = aws_security_group.sg-lb.id
  cidr_blocks       = ["0.0.0.0/0"]
}
//endregion

resource aws_lb lb-main {
  name = local.lb-name
  load_balancer_type = "application"

  internal = false
  ip_address_type = "ipv4"
  security_groups = [aws_security_group.sg-lb.id]
  subnets = var.subnet-ids

  enable_deletion_protection = false

  tags = var.tags
}

resource aws_lb_listener lbl-main {
  load_balancer_arn = aws_lb.lb-main.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.lb-library.arn
  }
}

resource aws_lb_target_group lb-library {
  name = "lbtg${var.project-name}"
  port = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id = var.vpc-id

  health_check {
    enabled = true
    healthy_threshold = 5
    unhealthy_threshold = 2
    interval = 30
    timeout = 5
    port = 8080
    path = "/actuator/health"
    protocol = "HTTP"
  }

  tags = var.tags
}
