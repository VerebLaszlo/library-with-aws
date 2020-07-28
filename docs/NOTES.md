Where it is used? `aws_security_group main`

Extract tag value:
```hcl-terraform
output output-name {
  value = lookup(resource-type.resource-id.tags, "key", "default value")
}
```

```hcl-terraform
resource aws_launch_template library-launch-template {
  name_prefix = "${var.project_name}LaunchTemplate-"
  description = "Launching private EC2 instances."
  ebs_optimized = false
  image_id = var.image_id
  instance_type = var.instance_type
  key_name = aws_key_pair.library.key_name
  iam_instance_profile {
    arn = aws_iam_instance_profile.library-instance-profile.arn
  }
  user_data = data.template_file.provision.rendered
  disable_api_termination = false
  vpc_security_group_ids = [module.vpc.sg]
  monitoring {
    enabled = true
  }
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      iops = 0
      delete_on_termination = true
      encrypted = false
      volume_size = 8
      volume_type = "gp2"
    }
  }
  network_interfaces {
    description = "Test description on EC2 network interfaces"
    associate_public_ip_address = false
    subnet_id = module.vpc.public_subnet_ids[0]
    security_groups = [module.vpc.sg]
  }
  depends_on = [aws_iam_role_policy_attachment.copyS3ToEC2]

  tag_specifications {
    resource_type = "instance"
    tags = var.tags
  }
  tags = var.tags
}
```
