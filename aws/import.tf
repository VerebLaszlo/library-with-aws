/**/
//region Load Balancer resources
resource "aws_vpc" "vpc-060135c5d2eac2308" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
  tags = var.tags
}

resource "aws_internet_gateway" "igw-00bf18b3c727d9a8e" {
  vpc_id = aws_vpc.vpc-060135c5d2eac2308.id
  tags = var.tags
}

resource "aws_route_table" "rtb-0ac678ea656acc91f" {
  vpc_id = aws_vpc.vpc-060135c5d2eac2308.id
  tags = var.tags
}

/*
// was not imported
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}*/

data "aws_availability_zones" "available" {}

// TODO create subnets per availability zone
//region subnet-0a7af08040d4919dd-subnet-0a7af08040d4919dd
resource "aws_subnet" "subnet-0a7af08040d4919dd-subnet-0a7af08040d4919dd" {
  count = length(var.cidr_blocks)
  vpc_id = aws_vpc.vpc-060135c5d2eac2308.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = var.cidr_blocks[count.index]
  map_public_ip_on_launch = true
  tags = var.tags
}

//region sg-090ba253f12089c4f          !!! Unknown Security Group !!!
resource "aws_network_interface" "eni-07b4d5c5b7438a19f" {
  subnet_id = aws_subnet.subnet-0a7af08040d4919dd-subnet-0a7af08040d4919dd.id
  private_ips = ["10.0.0.134"]
  security_groups = ["sg-090ba253f12089c4f"]
  source_dest_check = true
  attachment {
    instance = "i-0203c704b17f36a84"
    device_index = 0
  }
  tags = var.tags
}

resource "aws_iam_role" "ecsInstanceRole" {
  name = "ecsInstanceRole"
  path = "/"
  assume_role_policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_policy_attachment" "AmazonEC2ContainerServiceforEC2Role-policy-attachment" {
  name = "AmazonEC2ContainerServiceforEC2Role-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  groups = []
  users = []
  roles = [
    aws_iam_role.ecsInstanceRole.id
  ]
}

resource "aws_iam_instance_profile" "ecsInstanceRole" {
  name = aws_iam_role.ecsInstanceRole.name
  path = "/"
  role = aws_iam_role.ecsInstanceRole.id
}

resource "aws_launch_configuration" "EC2ContainerService-myapp-cluster-EcsInstanceLc-C65P627E4JGV" {
  name = "EC2ContainerService-myapp-cluster-EcsInstanceLc-C65P627E4JGV"
  image_id = var.ami
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ecsInstanceRole.name
  security_groups = [
    "sg-090ba253f12089c4f"
  ]
  /*  user_data = "IyEvYmluL2Jhc2gKZWNobyBFQ1NfQ0xVU1RFUj1teWFwcC1jbHVzdGVyID4
  +IC9ldGMvZWNzL2Vjcy5jb25maWc7ZWNobyBFQ1NfQkFDS0VORF9IT1NUPSA+PiAvZXRjL2Vjcy9lY3MuY29uZmlnOw=="*/
  enable_monitoring = true
  ebs_optimized = false
  root_block_device {
    volume_type = "gp2"
    volume_size = 30
    delete_on_termination = "!!! WAS EMPTY !!!"
  }
  tags = var.tags
}

resource "aws_instance" "ECS-Instance---EC2ContainerService-myapp-cluster" {
  ami = var.ami
  availability_zone = data.aws_availability_zones.available.names[0]
  ebs_optimized = false
  instance_type = var.instance_type
  monitoring = true
  key_name = ""
  subnet_id = aws_subnet.subnet-0a7af08040d4919dd-subnet-0a7af08040d4919dd.id
  vpc_security_group_ids = ["sg-090ba253f12089c4f"]
  associate_public_ip_address = true
  private_ip = "10.0.0.134"
  source_dest_check = true
  root_block_device {
    volume_type = "gp2"
    volume_size = 30
    delete_on_termination = true
  }
  tags = var.tags
}
//endregion

resource "aws_route_table_association" "rtb-0eae91b8eb8a4755b-rtbassoc-0046816ae16dd0092" {
  route_table_id = aws_route_table.rtb-0eae91b8eb8a4755b.id
  subnet_id = aws_subnet.subnet-0a7af08040d4919dd-subnet-0a7af08040d4919dd.id
  tags = var.tags
}
//endregion

//region subnet-0e1a172ba4e8cd117-subnet-0e1a172ba4e8cd117
resource "aws_subnet" "subnet-0e1a172ba4e8cd117-subnet-0e1a172ba4e8cd117" {
  vpc_id = aws_vpc.vpc-060135c5d2eac2308.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = var.tags
}

resource "aws_network_interface" "eni-04b9f87210d2b82d4" {
  subnet_id = aws_subnet.subnet-0e1a172ba4e8cd117-subnet-0e1a172ba4e8cd117.id
  private_ips = ["10.0.1.102"]
  security_groups = ["sg-0e517ee701ab28870"]
  source_dest_check = true
  tags = var.tags
}

//region sg-090ba253f12089c4f          !!! Unknown Security Group !!!
resource "aws_network_interface" "eni-054f8940e221b5ac2" {
  subnet_id = aws_subnet.subnet-0e1a172ba4e8cd117-subnet-0e1a172ba4e8cd117.id
  private_ips = ["10.0.1.180"]
  security_groups = ["sg-090ba253f12089c4f"]
  source_dest_check = true
  attachment {
    instance = "i-08776e73661a04ed1"
    device_index = 0
  }
  tags = var.tags
}

resource "aws_instance" "ECS-Instance---EC2ContainerService-myapp-cluster" {
  ami = var.ami
  availability_zone = data.aws_availability_zones.available.names[1]

  ebs_optimized = false
  instance_type = var.instance_type
  monitoring = true
  key_name = ""
  subnet_id = aws_subnet.subnet-0e1a172ba4e8cd117-subnet-0e1a172ba4e8cd117.id
  vpc_security_group_ids = ["sg-090ba253f12089c4f"]
  associate_public_ip_address = true
  private_ip = "10.0.1.180"
  source_dest_check = true
  root_block_device {
    volume_type = "gp2"
    volume_size = 30
    delete_on_termination = true
  }
  tags = var.tags
}
//endregion

resource "aws_route_table_association" "rtb-0eae91b8eb8a4755b-rtbassoc-0390ae378c4271068" {
  route_table_id = aws_route_table.rtb-0eae91b8eb8a4755b.id
  subnet_id = aws_subnet.subnet-0e1a172ba4e8cd117-subnet-0e1a172ba4e8cd117.id
  tags = var.tags
}
//endregion

resource "aws_autoscaling_group" "EC2ContainerService-myapp-cluster-EcsInstanceAsg-1MME543ZZRH7V" {
  desired_capacity = 2
  health_check_grace_period = 0
  health_check_type = "EC2"
  launch_configuration = aws_launch_configuration.EC2ContainerService-myapp-cluster-EcsInstanceLc-C65P627E4JGV.id
  max_size = 2
  min_size = 0
  name = "EC2ContainerService-myapp-cluster-EcsInstanceAsg-1MME543ZZRH7V"
  vpc_zone_identifier = [
    aws_subnet.subnet-0a7af08040d4919dd-subnet-0a7af08040d4919dd.id,
    aws_subnet.subnet-0e1a172ba4e8cd117-subnet-0e1a172ba4e8cd117.id
  ]
  tag {
    key = "Description"
    value = "This instance is the part of the Auto Scaling group which was created through ECS Console"
    propagate_at_launch = true
  }
  tag {
    key = "Name"
    value = "ECS Instance - EC2ContainerService-myapp-cluster"
    propagate_at_launch = true
  }
  tag {
    key = "aws:cloudformation:logical-id"
    value = "EcsInstanceAsg"
    propagate_at_launch = true
  }
  tag {
    key = "aws:cloudformation:stack-id"
    /*    value = "arn:aws:cloudformation:eu-central-1:686177639067:stack/EC2ContainerService-myapp-cluster/ccc74550
    -b6ec-11ea-bc86-02433c861a1c"*/
    propagate_at_launch = true
  }
  tag {
    key = "aws:cloudformation:stack-name"
    value = "EC2ContainerService-myapp-cluster"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "vpc-060135c5d2eac2308-sc-alb1" {
  name = "sc-alb1"
  description = "load-balancer-wizard-1 created on 2020-06-25T16:43:28.700+02:00"
  vpc_id = aws_vpc.vpc-060135c5d2eac2308.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}

resource "aws_security_group" "vpc-060135c5d2eac2308-default" {
  name = "default"
  description = "default VPC security group"
  vpc_id = aws_vpc.vpc-060135c5d2eac2308.id
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = []
    self = true
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}

resource "aws_security_group" "vpc-060135c5d2eac2308-EC2ContainerService-myapp-cluster-EcsSecurityGroup-1JJI2HGDOUKYT" {
  name = "EC2ContainerService-myapp-cluster-EcsSecurityGroup-1JJI2HGDOUKYT"
  description = "ECS Allowed Ports"
  vpc_id = aws_vpc.vpc-060135c5d2eac2308.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = ["sg-0e517ee701ab28870"]
    self = false
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}

resource "aws_network_acl" "acl-09e5da9bf33913d40" {
  vpc_id = aws_vpc.vpc-060135c5d2eac2308.id
  subnet_ids = [
    aws_subnet.subnet-0e1a172ba4e8cd117-subnet-0e1a172ba4e8cd117.id,
    aws_subnet.subnet-0a7af08040d4919dd-subnet-0a7af08040d4919dd.id
  ]
  ingress {
    from_port = 0
    to_port = 0
    rule_no = 100
    action = "allow"
    protocol = "-1"
    cidr_block = "0.0.0.0/0"
  }
  egress {
    from_port = 0
    to_port = 0
    rule_no = 100
    action = "allow"
    protocol = "-1"
    cidr_block = "0.0.0.0/0"
  }
  tags = var.tags
}

resource "aws_route_table" "rtb-0eae91b8eb8a4755b" {
  vpc_id = aws_vpc.vpc-060135c5d2eac2308.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-00bf18b3c727d9a8e.id
  }
  tags = var.tags
}

resource "aws_network_interface" "eni-097d03c96a9dbb5ef" {
  subnet_id = aws_subnet.subnet-0a7af08040d4919dd-subnet-0a7af08040d4919dd.id
  private_ips = ["10.0.0.161"]
  security_groups = ["sg-0e517ee701ab28870"]
  source_dest_check = true
  tags = var.tags
}

resource "aws_alb" "alb1" {
  idle_timeout = 60
  internal = false
  name = "alb1"
  security_groups = [
    aws_security_group.vpc-060135c5d2eac2308-sc-alb1.id
  ]
  subnets = [
    aws_subnet.subnet-0a7af08040d4919dd-subnet-0a7af08040d4919dd.id,
    aws_subnet.subnet-0e1a172ba4e8cd117-subnet-0e1a172ba4e8cd117.id
  ]
  enable_deletion_protection = false
  tags = var.tags
}

resource "aws_route53_zone" "laszlo-epam-com-public" {
  name = "laszlo.epam.com"
  comment = ""
  tags = var.tags
}

resource "aws_route53_record" "laszlo-epam-com-A-0" {
  zone_id = aws_route53_zone.laszlo-epam-com-public.id
  name = "laszlo.epam.com"
  type = "A"
  weighted_routing_policy {
    weight = 50
  }
  set_identifier = "2"
  alias {
    name = aws_alb.alb1.dns_name
    zone_id = aws_alb.alb1.zone_id
    evaluate_target_health = true
  }
  tags = var.tags
}

resource "aws_route53_record" "laszlo-epam-com-A-1" {
  zone_id = aws_route53_zone.laszlo-epam-com-public.id
  name = "laszlo.epam.com"
  type = "A"
  weighted_routing_policy {
    weight = 50
  }
  set_identifier = "a"
  alias {
    name = aws_alb.alb1.dns_name
    zone_id = aws_alb.alb1.zone_id
    evaluate_target_health = true
  }
  tags = var.tags
}

resource "aws_route53_record" "laszlo-epam-com-NS" {
  zone_id = aws_route53_zone.laszlo-epam-com-public.id
  name = "laszlo.epam.com"
  type = "NS"
  records = aws_route53_zone.laszlo-epam-com-public.name_servers
  ttl = "172800"
  tags = var.tags
}

resource "aws_route53_record" "laszlo-epam-com-SOA" {
  zone_id = aws_route53_zone.laszlo-epam-com-public.id
  name = "laszlo.epam.com"
  type = "SOA"
  records = [
    aws_route53_zone.laszlo-epam-com-public.name_servers[0]
  ]
  ttl = "900"
  tags = var.tags
}
//endregion

resource "aws_vpc" "vpc-9c4997f6" {
  cidr_block = "172.31.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
  tags = var.tags
}

resource "aws_route_table" "rtb-daf4a4b0" {
  vpc_id = aws_vpc.vpc-9c4997f6.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-ce439ea5.id
  }
  tags = var.tags
}

resource "aws_internet_gateway" "igw-ce439ea5" {
  vpc_id = aws_vpc.vpc-9c4997f6.id
  tags = var.tags
}

resource "aws_security_group" "vpc-9c4997f6-awseb-e-vwprxwpxjj-stack-AWSEBSecurityGroup-1MAR348NF7A1N" {
  name = "awseb-e-vwprxwpxjj-stack-AWSEBSecurityGroup-1MAR348NF7A1N"
  description = "SecurityGroup for ElasticBeanstalk environment."
  vpc_id = aws_vpc.vpc-9c4997f6.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 11211
    to_port = 11211
    protocol = "tcp"
    security_groups = []
    self = true
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}

//region subnet-f0f8799a-subnet-f0f8799a
resource "aws_subnet" "subnet-f0f8799a-subnet-f0f8799a" {
  vpc_id = aws_vpc.vpc-9c4997f6.id
  cidr_block = "172.31.16.0/20"
  availability_zone = data.aws_availability_zones.available.names[0]
  depends_on = [aws_internet_gateway.igw-ce439ea5]
  map_public_ip_on_launch = true
  tags = var.tags
}

resource "aws_network_interface" "eni-009e29af1377eb218" {
  subnet_id = aws_subnet.subnet-f0f8799a-subnet-f0f8799a.id
  private_ips = ["172.31.30.66"]
  security_groups = [aws_security_group.vpc-9c4997f6-awseb-e-vwprxwpxjj-stack-AWSEBSecurityGroup-1MAR348NF7A1N.id]
  source_dest_check = true
  tags = var.tags
}

resource "aws_network_interface" "eni-03576595fa5d73854" {
  subnet_id = aws_subnet.subnet-f0f8799a-subnet-f0f8799a.id
  private_ips = ["172.31.31.151"]
  security_groups = [aws_security_group.vpc-9c4997f6-awseb-e-vwprxwpxjj-stack-AWSEBSecurityGroup-1MAR348NF7A1N.id]
  source_dest_check = true
  tags = var.tags
}

resource "aws_network_interface" "eni-07002e907df61f58a" {
  subnet_id = aws_subnet.subnet-f0f8799a-subnet-f0f8799a.id
  private_ips = ["172.31.29.85"]
  security_groups = ["sg-03459968408970e2b"]
  source_dest_check = true
}
//endregion

//region subnet-45cb3739-subnet-45cb3739
resource "aws_subnet" "subnet-45cb3739-subnet-45cb3739" {
  vpc_id = aws_vpc.vpc-9c4997f6.id
  depends_on = [aws_internet_gateway.igw-ce439ea5]
  cidr_block = "172.31.32.0/20"
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = var.tags
}

resource "aws_network_interface" "eni-0e42a3712d7fafa14" {
  subnet_id = aws_subnet.subnet-45cb3739-subnet-45cb3739.id
  private_ips = ["172.31.36.214"]
  security_groups = [aws_security_group.vpc-9c4997f6-awseb-e-vwprxwpxjj-stack-AWSEBSecurityGroup-1MAR348NF7A1N.id]
  source_dest_check = true
}
//endregion

//region subnet-0305c64f-subnet-0305c64f
resource "aws_subnet" "subnet-0305c64f-subnet-0305c64f" {
  vpc_id = aws_vpc.vpc-9c4997f6.id
  depends_on = [aws_internet_gateway.igw-ce439ea5]
  cidr_block = "172.31.0.0/20"
  availability_zone = data.aws_availability_zones.available.names[2]
  map_public_ip_on_launch = true
  tags = var.tags
}

resource "aws_network_interface" "eni-08dbe103560238168" {
  subnet_id = aws_subnet.subnet-0305c64f-subnet-0305c64f.id
  private_ips = ["172.31.3.54"]
  security_groups = [
    aws_security_group.vpc-9c4997f6-awseb-e-vwprxwpxjj-stack-AWSEBSecurityGroup-1MAR348NF7A1N.id
  ]
  source_dest_check = true
  attachment {
    instance = "i-0f9911f5000f1ddcf"
    device_index = 0
  }
  tags = var.tags
}
//endregion

resource "aws_security_group" "vpc-9c4997f6-default" {
  name = "default"
  description = "default VPC security group"
  vpc_id = aws_vpc.vpc-9c4997f6.id
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = []
    self = true
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}

resource "aws_security_group" "vpc-9c4997f6-library-sg" {
  name = "library-sg"
  description = "load-balancer-wizard-1 created on 2020-06-24T15:41:14.368+02:00"
  vpc_id = aws_vpc.vpc-9c4997f6.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
}

resource "aws_iam_role" "aws-elasticbeanstalk-ec2-role" {
  name = "aws-elasticbeanstalk-ec2-role"
  path = "/"
  assume_role_policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_instance_profile" "aws-elasticbeanstalk-ec2-role" {
  name = aws_iam_role.aws-elasticbeanstalk-ec2-role.name
  path = "/"
  role = aws_iam_role.aws-elasticbeanstalk-ec2-role.id
}

resource "aws_launch_configuration" "awseb-e-vwprxwpxjj-stack-AWSEBAutoScalingLaunchConfiguration-1105JU9N5WT6J" {
  name = "awseb-e-vwprxwpxjj-stack-AWSEBAutoScalingLaunchConfiguration-1105JU9N5WT6J"
  image_id = var.ami2
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.aws-elasticbeanstalk-ec2-role.id
  security_groups = [
    aws_security_group.vpc-9c4997f6-awseb-e-vwprxwpxjj-stack-AWSEBSecurityGroup-1MAR348NF7A1N.id
  ]
  /*  user_data =
  "Q29udGVudC1UeXBlOiBtdWx0aXBhcnQvbWl4ZWQ7IGJvdW5kYXJ5PSI9PT09PT09PT09PT09PT01MTg5MDY1Mzc3MjIyODk4NDA3PT0iCk1JTUUtVmVyc2lvbjogMS4wCgotLT09PT09PT09PT09PT09PTUxODkwNjUzNzcyMjI4OTg0MDc9PQpDb250ZW50LVR5cGU6IHRleHQvY2xvdWQtY29uZmlnOyBjaGFyc2V0PSJ1cy1hc2NpaSIKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogN2JpdApDb250ZW50LURpc3Bvc2l0aW9uOiBhdHRhY2htZW50OyBmaWxlbmFtZT0iY2xvdWQtY29uZmlnLnR4dCIKCiNjbG91ZC1jb25maWcKcmVwb191cGdyYWRlOiBub25lCnJlcG9fcmVsZWFzZXZlcjogMi4wCmNsb3VkX2ZpbmFsX21vZHVsZXM6CiAtIFtzY3JpcHRzLXVzZXIsIGFsd2F5c10KCi0tPT09PT09PT09PT09PT09NTE4OTA2NTM3NzIyMjg5ODQwNz09CkNvbnRlbnQtVHlwZTogdGV4dC94LXNoZWxsc2NyaXB0OyBjaGFyc2V0PSJ1cy1hc2NpaSIKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogN2JpdApDb250ZW50LURpc3Bvc2l0aW9uOiBhdHRhY2htZW50OyBmaWxlbmFtZT0idXNlci1kYXRhLnR4dCIKCiMhL2Jpbi9iYXNoCmV4ZWMgPiA+KHRlZSAtYSAvdmFyL2xvZy9lYi1jZm4taW5pdC5sb2d8bG9nZ2VyIC10IFtlYi1jZm4taW5pdF0gLXMgMj4vZGV2L2NvbnNvbGUpIDI+JjEKZWNobyBbYGRhdGUgLXUgKyIlWS0lbS0lZFQlSDolTTolU1oiYF0gU3RhcnRlZCBFQiBVc2VyIERhdGEKc2V0IC14CgoKZnVuY3Rpb24gc2xlZXBfZGVsYXkgCnsKICBpZiAoKCAkU0xFRVBfVElNRSA8ICRTTEVFUF9USU1FX01BWCApKTsgdGhlbiAKICAgIGVjaG8gU2xlZXBpbmcgJFNMRUVQX1RJTUUKICAgIHNsZWVwICRTTEVFUF9USU1FICAKICAgIFNMRUVQX1RJTUU9JCgoJFNMRUVQX1RJTUUgKiAyKSkgCiAgZWxzZSAKICAgIGVjaG8gU2xlZXBpbmcgJFNMRUVQX1RJTUVfTUFYICAKICAgIHNsZWVwICRTTEVFUF9USU1FX01BWCAgCiAgZmkKfQoKIyBFeGVjdXRpbmcgYm9vdHN0cmFwIHNjcmlwdApTTEVFUF9USU1FPTEwClNMRUVQX1RJTUVfTUFYPTM2MDAKd2hpbGUgdHJ1ZTsgZG8gCiAgY3VybCBodHRwczovL2VsYXN0aWNiZWFuc3RhbGstcGxhdGZvcm0tYXNzZXRzLWV1LWNlbnRyYWwtMS5zMy5ldS1jZW50cmFsLTEuYW1hem9uYXdzLmNvbS9zdGFsa3MvZWJfdG9tY2F0ODVjb3JyZXR0bzExX2FtYXpvbl9saW51eF8yXzEuMC4xMjUuMF8yMDIwMDYxOTAxMDg0My9saWIvVXNlckRhdGFTY3JpcHQuc2ggPiAvdG1wL2ViYm9vdHN0cmFwLnNoIAogIFJFU1VMVD0kPwogIGlmIFtbICIkUkVTVUxUIiAtbmUgMCBdXTsgdGhlbiAKICAgIHNsZWVwX2RlbGF5IAogIGVsc2UKICAgIFNMRUVQX1RJTUU9MgogICAgL2Jpbi9iYXNoIC90bXAvZWJib290c3RyYXAuc2ggICAgICdodHRwczovL2Nsb3VkZm9ybWF0aW9uLXdhaXRjb25kaXRpb24tZXUtY2VudHJhbC0xLnMzLmV1LWNlbnRyYWwtMS5hbWF6b25hd3MuY29tL2FybiUzQWF3cyUzQWNsb3VkZm9ybWF0aW9uJTNBZXUtY2VudHJhbC0xJTNBNjg2MTc3NjM5MDY3JTNBc3RhY2svYXdzZWItZS12d3ByeHdweGpqLXN0YWNrLzQ0NDVmODUwLWE3MmItMTFlYS1iNTEzLTA2NGE4ZDMyZmM5ZS9BV1NFQkluc3RhbmNlTGF1bmNoV2FpdEhhbmRsZT9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1EYXRlPTIwMjAwNjA1VDEyNTEyOVomWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JlgtQW16LUV4cGlyZXM9ODYzOTkmWC1BbXotQ3JlZGVudGlhbD1BS0lBSUdGVlhDSUJGSzdTUExLUSUyRjIwMjAwNjA1JTJGZXUtY2VudHJhbC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotU2lnbmF0dXJlPTg1ZjQ0NTA4NzY5ZjE4ODU1NGIyMmI3YTlkNTA3N2M0YjVkMjc3YThlNTI2YmY4ZDg1ZDM5ZDEzYTY3NDRhODYnICAgICdhcm46YXdzOmNsb3VkZm9ybWF0aW9uOmV1LWNlbnRyYWwtMTo2ODYxNzc2MzkwNjc6c3RhY2svYXdzZWItZS12d3ByeHdweGpqLXN0YWNrLzQ0NDVmODUwLWE3MmItMTFlYS1iNTEzLTA2NGE4ZDMyZmM5ZScgICAgJzc3MTQ1YjQ3LWQ1ZTEtNGFmNC04OTNmLTg2OWE1ZDE0YzhhZicgICAgJ2h0dHBzOi8vZWxhc3RpY2JlYW5zdGFsay1oZWFsdGguZXUtY2VudHJhbC0xLmFtYXpvbmF3cy5jb20nICAgICcnICAgICdodHRwczovL2VsYXN0aWNiZWFuc3RhbGstcGxhdGZvcm0tYXNzZXRzLWV1LWNlbnRyYWwtMS5zMy5ldS1jZW50cmFsLTEuYW1hem9uYXdzLmNvbS9zdGFsa3MvZWJfdG9tY2F0ODVjb3JyZXR0bzExX2FtYXpvbl9saW51eF8yXzEuMC4xMjUuMF8yMDIwMDYxOTAxMDg0My9saWIvcGxhdGZvcm0tZW5naW5lLnppcCcgICAgJ2V1LWNlbnRyYWwtMScKICAgIFJFU1VMVD0kPwogICAgaWYgW1sgIiRSRVNVTFQiIC1uZSAwIF1dOyB0aGVuIAogICAgICBzbGVlcF9kZWxheSAKICAgIGVsc2UgCiAgICAgIGV4aXQgMCAgCiAgICBmaSAKICBmaSAKZG9uZQoKLS09PT09PT09PT09PT09PT01MTg5MDY1Mzc3MjIyODk4NDA3PT0tLSAjI0VjMkluc3RhbmNlUmVwbGFjZW1lbnRSZXF1ZXN0PTMyOWIyYzVjLWY2MDAtNDljOC05ODQxLTAzM2I0MTM0M2RiNw=="*/
  enable_monitoring = false
  ebs_optimized = false

}

resource "aws_autoscaling_group" "awseb-e-vwprxwpxjj-stack-AWSEBAutoScalingGroup-LPHYBIM8OCG7" {
  availability_zones = data.aws_availability_zones.available.names
  desired_capacity = 1
  health_check_grace_period = 0
  health_check_type = "EC2"
  launch_configuration = aws_launch_configuration
  .awseb-e-vwprxwpxjj-stack-AWSEBAutoScalingLaunchConfiguration-1105JU9N5WT6J.id
  max_size = 1
  min_size = 1
  name = "awseb-e-vwprxwpxjj-stack-AWSEBAutoScalingGroup-LPHYBIM8OCG7"
  tag {
    key = "Name"
    value = "Myebapp-env"
    propagate_at_launch = true
  }
  tag {
    key = "aws:cloudformation:logical-id"
    value = "AWSEBAutoScalingGroup"
    propagate_at_launch = true
  }
  tag {
    key = "aws:cloudformation:stack-id"
    /*    value = "arn:aws:cloudformation:eu-central-1:686177639067:stack/awseb-e-vwprxwpxjj-stack/4445f850-a72b-11ea
    -b513-064a8d32fc9e"*/
    propagate_at_launch = true
  }
  tag {
    key = "aws:cloudformation:stack-name"
    value = "awseb-e-vwprxwpxjj-stack"
    propagate_at_launch = true
  }
  tag {
    key = "elasticbeanstalk:environment-id"
    value = "e-vwprxwpxjj"
    propagate_at_launch = true
  }
  tag {
    key = "elasticbeanstalk:environment-name"
    value = "Myebapp-env"
    propagate_at_launch = true
  }
}

resource "aws_elasticache_subnet_group" "cachesubnet1" {
  name = "cachesubnet1"
  description = "cache test"
  //  subnet_ids = ["${aws_subnet.default.*.id}"]
  subnet_ids = [
    aws_subnet.subnet-f0f8799a-subnet-f0f8799a.id,
    aws_subnet.subnet-45cb3739-subnet-45cb3739.id
  ]
}

resource "aws_elasticache_cluster" "cachetest" {
  cluster_id = "cachetest"
  engine = "memcached"
  engine_version = "1.5.16"
  node_type = var.cache_instance_type
  num_cache_nodes = 1
  parameter_group_name = "default.memcached1.5"
  port = 11211
  subnet_group_name = aws_elasticache_subnet_group.cachesubnet1.name
  security_group_ids = [
    aws_security_group.vpc-9c4997f6-awseb-e-vwprxwpxjj-stack-AWSEBSecurityGroup-1MAR348NF7A1N.id
  ]
}

resource "aws_instance" "Myebapp-env" {
  count = 1
  ami = lookup(var.aws_amis, var.region)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  ebs_optimized = false
  instance_type = var.instance_type
  monitoring = false
  key_name = ""
  subnet_id = aws_subnet.subnet-0305c64f-subnet-0305c64f.id
  vpc_security_group_ids = [
    aws_security_group.vpc-9c4997f6-awseb-e-vwprxwpxjj-stack-AWSEBSecurityGroup-1MAR348NF7A1N.id
  ]
  associate_public_ip_address = true
  private_ip = "172.31.3.54"
  source_dest_check = true
  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    delete_on_termination = true
  }
  tags = var.tags
}

resource "aws_eip" "eipalloc-0b1593e2e6923b32f" {
  depends_on = [aws_internet_gateway.igw-ce439ea5]
  instance = aws_instance.Myebapp-env.id
  vpc = true
}

resource "aws_network_acl" "acl-c6c4afac" {
  vpc_id = aws_vpc.vpc-9c4997f6.id
  subnet_ids = [
    aws_subnet.subnet-45cb3739-subnet-45cb3739.id,
    aws_subnet.subnet-f0f8799a-subnet-f0f8799a.id,
    aws_subnet.subnet-0305c64f-subnet-0305c64f.id
  ]
  ingress {
    from_port = 0
    to_port = 0
    rule_no = 100
    action = "allow"
    protocol = "-1"
    cidr_block = "0.0.0.0/0"
  }
  egress {
    from_port = 0
    to_port = 0
    rule_no = 100
    action = "allow"
    protocol = "-1"
    cidr_block = "0.0.0.0/0"
  }
  tags = var.tags
}
