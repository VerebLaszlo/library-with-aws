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


## Free domain
1. Go to [FreeNom](freenom.com) and register for an account.
2. AWS
    1. Log into your AWS account, go to Route53 and create a hosted zone for your domain and set the type to Public
  Hosted Zone
    2. Once created, you’ll be presented with 2 default record sets for your domain. In here, take note all of the 4
  Nameservers.
    3. Create another record sets for your domain, one with www name and one without it.
3. FreeNom
    1. Go to **Services**/**My Domains**
    2. Click **Manage Domain ![](https://findicons.com/files/icons/1620/crystal_project/16/gear.png)**
    3. Go to **Management Tools**/**Nameservers**
    4. Select custom nameservers and copy the nameservers from the new hosted zone in AWS Route53

source: https://medium.com/@kcabading/getting-a-free-domain-for-your-ec2-instance-3ac2955b0a2f
