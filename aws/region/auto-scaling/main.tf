# Autoscaling configuration
locals {
  lc-name = "lc${var.project-name}-"
  key-name = "key${var.project-name}"
}

resource aws_key_pair library {
  key_name = local.key-name
  public_key = file("${path.module}/${local.key-name}.pub")

  tags = var.tags
}

data template_file provision {
  vars = {
    S3_BUCKET_NAME = var.s3-bucket-name
    CLOUDFRONT_DOMAIN_NAME = var.cloudfront-domain-name
  }
  template = file("${path.module}/provision.sh")
}

//region Security Group
resource aws_security_group sg-launch-configuration {
  name   = "sgAutoScaling${var.project-name}"
  description = "Security group for the ${local.lc-name}*** launch configuration."
  vpc_id = var.vpc-id

  tags = var.tags
}

resource aws_security_group_rule inbound_ssh {
  description = "SSH inbound traffic."

  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  security_group_id = aws_security_group.sg-launch-configuration.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource aws_security_group_rule inbound_http {
  description = "Http inbound traffic."

  type              = "ingress"
  protocol          = "tcp"
  from_port         = 8080
  to_port           = 8080
  security_group_id = aws_security_group.sg-launch-configuration.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource aws_security_group_rule outbound_all {
  description = "All outbound traffic."

  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  security_group_id = aws_security_group.sg-launch-configuration.id
  cidr_blocks       = ["0.0.0.0/0"]
}
//endregion

data aws_ami ami {
  owners           = var.image-owners
  most_recent      = true

  filter {
    name   = "name"
    values = var.image-name-prefixes
  }
}

resource aws_launch_configuration lc-main {
  name_prefix = local.lc-name
  image_id = data.aws_ami.ami.image_id
  instance_type = var.instance-type
  key_name = aws_key_pair.library.id
  iam_instance_profile = var.ec2-instance-profile
  associate_public_ip_address = false
  user_data = data.template_file.provision.rendered

  security_groups = [aws_security_group.sg-launch-configuration.id]

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [var.accessArtifactInS3-policy]
}

resource aws_autoscaling_group asg-main {
  name = "asg${var.project-name}"
  launch_configuration = aws_launch_configuration.lc-main.name
  desired_capacity = 2
  min_size = 1
  max_size = 3
  health_check_type = "ELB"
  vpc_zone_identifier = var.subnet-ids
  target_group_arns = [var.dep-target-group.arn]
  timeouts {
    delete = "1m"
  }
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [var.dep-target-group]

  tags = [
    map("key", "access-project", "value", var.tags["access-project"], "propagate_at_launch", true),
    map("key", "access-team", "value", var.tags["access-team"], "propagate_at_launch", true),
    map("key", "Name", "value", "${var.project-name}_ec2", "propagate_at_launch", true)
  ]
}

resource aws_autoscaling_policy asp-main {
  name = "asp${var.project-name}"
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    disable_scale_in = false
    target_value = 50
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
  cooldown = 0
  autoscaling_group_name = aws_autoscaling_group.asg-main.name
}

resource aws_autoscaling_attachment library {
  alb_target_group_arn = var.dep-target-group.arn
  autoscaling_group_name = aws_autoscaling_group.asg-main.id
}
