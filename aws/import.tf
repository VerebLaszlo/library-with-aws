# Import 1
//region ALB
resource "aws_alb" "library-lb" {
  idle_timeout = 60
  internal = false
  name = "library-lb"
  security_groups = [
    "sg-03459968408970e2b"
  ]
  subnets = [
    "subnet-45cb3739",
    "subnet-f0f8799a"
  ]

  enable_deletion_protection = false

  tags {
  }
}

resource "aws_alb" "alb1" {
  idle_timeout = 60
  internal = false
  name = "alb1"
  security_groups = [
    "sg-0e517ee701ab28870"
  ]
  subnets = [
    "subnet-0a7af08040d4919dd",
    "subnet-0e1a172ba4e8cd117"
  ]

  enable_deletion_protection = false

  tags {
  }
}
//endregion
//region AutoScaling Group
resource "aws_autoscaling_group" "EC2ContainerService-myapp-cluster-EcsInstanceAsg-1MME543ZZRH7V" {
  desired_capacity = 2
  health_check_grace_period = 0
  health_check_type = "EC2"
  launch_configuration = "EC2ContainerService-myapp-cluster-EcsInstanceLc-C65P627E4JGV"
  max_size = 2
  min_size = 0
  name = "EC2ContainerService-myapp-cluster-EcsInstanceAsg-1MME543ZZRH7V"
  vpc_zone_identifier = [
    "subnet-0a7af08040d4919dd",
    "subnet-0e1a172ba4e8cd117"
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

resource "aws_autoscaling_group" "awseb-e-vwprxwpxjj-stack-AWSEBAutoScalingGroup-LPHYBIM8OCG7" {
  availability_zones = [
    "eu-central-1a",
    "eu-central-1c",
    "eu-central-1b"
  ]
  desired_capacity = 1
  health_check_grace_period = 0
  health_check_type = "EC2"
  launch_configuration = "awseb-e-vwprxwpxjj-stack-AWSEBAutoScalingLaunchConfiguration-1105JU9N5WT6J"
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
//endregion
//region EC2
resource "aws_instance" "ECS-Instance---EC2ContainerService-myapp-cluster" {
  ami = "ami-0b34f371a12d673de"
  availability_zone = "eu-central-1a"
  ebs_optimized = false
  instance_type = "t3a.nano"
  monitoring = true
  key_name = ""
  subnet_id = "subnet-0a7af08040d4919dd"
  vpc_security_group_ids = ["sg-090ba253f12089c4f"]
  associate_public_ip_address = true
  private_ip = "10.0.0.134"
  source_dest_check = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 30
    delete_on_termination = true
  }

  tags {
    Name = "ECS Instance - EC2ContainerService-myapp-cluster"
    /*    "aws:cloudformation:stack-id" = "arn:aws:cloudformation:eu-central-1:686177639067:stack/EC2ContainerService
    -myapp-cluster/ccc74550-b6ec-11ea-bc86-02433c861a1c"*/
    //    "Description" = "This instance is the part of the Auto Scaling group which was created through ECS Console"
    //    "aws:cloudformation:stack-name" = "EC2ContainerService-myapp-cluster"
    //    "aws:cloudformation:logical-id" = "EcsInstanceAsg"
    //    "aws:autoscaling:groupName" = "EC2ContainerService-myapp-cluster-EcsInstanceAsg-1MME543ZZRH7V"
  }
}

resource "aws_instance" "ECS-Instance---EC2ContainerService-myapp-cluster" {
  ami = "ami-0b34f371a12d673de"
  availability_zone = "eu-central-1b"
  ebs_optimized = false
  instance_type = "t3a.nano"
  monitoring = true
  key_name = ""
  subnet_id = "subnet-0e1a172ba4e8cd117"
  vpc_security_group_ids = ["sg-090ba253f12089c4f"]
  associate_public_ip_address = true
  private_ip = "10.0.1.180"
  source_dest_check = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 30
    delete_on_termination = true
  }

  tags {
    Name = "ECS Instance - EC2ContainerService-myapp-cluster"
    //    "aws:autoscaling:groupName" = "EC2ContainerService-myapp-cluster-EcsInstanceAsg-1MME543ZZRH7V"
    //    "aws:cloudformation:stack-name" = "EC2ContainerService-myapp-cluster"
    //    "aws:cloudformation:logical-id" = "EcsInstanceAsg"
    //    "Description" = "This instance is the part of the Auto Scaling group which was created through ECS Console"
    /*    "aws:cloudformation:stack-id" = "arn:aws:cloudformation:eu-central-1:686177639067:stack/EC2ContainerService
    -myapp-cluster/ccc74550-b6ec-11ea-bc86-02433c861a1c"*/
  }
}

resource "aws_instance" "Myebapp-env" {
  ami = "ami-071b284a58700fbda"
  availability_zone = "eu-central-1c"
  ebs_optimized = false
  instance_type = "t2.micro"
  monitoring = false
  key_name = ""
  subnet_id = "subnet-0305c64f"
  vpc_security_group_ids = ["sg-0525af0ac1c5967ae"]
  associate_public_ip_address = true
  private_ip = "172.31.3.54"
  source_dest_check = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    delete_on_termination = true
  }

  tags {
    Name = "Myebapp-env"
    //    "aws:cloudformation:logical-id" = "AWSEBAutoScalingGroup"
    //    "aws:cloudformation:stack-name" = "awseb-e-vwprxwpxjj-stack"
    //    "elasticbeanstalk:environment-id" = "e-vwprxwpxjj"
    //    "aws:autoscaling:groupName" = "awseb-e-vwprxwpxjj-stack-AWSEBAutoScalingGroup-LPHYBIM8OCG7"
    /*    "aws:cloudformation:stack-id" = "arn:aws:cloudformation:eu-central-1:686177639067:stack/awseb-e-vwprxwpxjj
    -stack/4445f850-a72b-11ea-b513-064a8d32fc9e"*/
    //    "elasticbeanstalk:environment-name" = "Myebapp-env"
  }
}
//endregion
//region ElastiCache Cluster
resource "aws_elasticache_cluster" "cachetest" {
  cluster_id = "cachetest"
  engine = "memcached"
  engine_version = "1.5.16"
  node_type = "cache.t2.micro"
  num_cache_nodes = 1
  parameter_group_name = "default.memcached1.5"
  port = 11211
  subnet_group_name = "cachesubnet1"
  security_group_ids = [
    "sg-0525af0ac1c5967ae"
  ]
}
//endregion
//region ElastiCache Subnet Group
resource "aws_elasticache_subnet_group" "cachesubnet1" {
  name = "cachesubnet1"
  description = "cache test"
  subnet_ids = [
    "subnet-f0f8799a",
    "subnet-45cb3739"
  ]
}
//endregion
//region EIP
resource "aws_eip" "eipalloc-0b1593e2e6923b32f" {
  instance = "i-0f9911f5000f1ddcf"
  vpc = true
}
//endregion
//region IAM Instance Profile
resource "aws_iam_instance_profile" "aws-elasticbeanstalk-ec2-role" {
  name = "aws-elasticbeanstalk-ec2-role"
  path = "/"
  role = "aws-elasticbeanstalk-ec2-role"
}

resource "aws_iam_instance_profile" "ecsInstanceRole" {
  name = "ecsInstanceRole"
  path = "/"
  role = "ecsInstanceRole"
}
//endregion
//region IAM Role
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

resource "aws_iam_role" "aws-elasticbeanstalk-service-role" {
  name = "aws-elasticbeanstalk-service-role"
  path = "/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "elasticbeanstalk.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "elasticbeanstalk"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role" "AWSServiceRoleForApplicationAutoScaling_DynamoDBTable" {
  name = "AWSServiceRoleForApplicationAutoScaling_DynamoDBTable"
  path = "/aws-service-role/dynamodb.application-autoscaling.amazonaws.com/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "dynamodb.application-autoscaling.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "AWSServiceRoleForAutoScaling" {
  name = "AWSServiceRoleForAutoScaling"
  path = "/aws-service-role/autoscaling.amazonaws.com/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "autoscaling.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "AWSServiceRoleForDynamoDBReplication" {
  name = "AWSServiceRoleForDynamoDBReplication"
  path = "/aws-service-role/replication.dynamodb.amazonaws.com/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "replication.dynamodb.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "AWSServiceRoleForECS" {
  name = "AWSServiceRoleForECS"
  path = "/aws-service-role/ecs.amazonaws.com/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "AWSServiceRoleForElastiCache" {
  name = "AWSServiceRoleForElastiCache"
  path = "/aws-service-role/elasticache.amazonaws.com/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "elasticache.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "AWSServiceRoleForElasticLoadBalancing" {
  name = "AWSServiceRoleForElasticLoadBalancing"
  path = "/aws-service-role/elasticloadbalancing.amazonaws.com/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "elasticloadbalancing.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "AWSServiceRoleForSupport" {
  name = "AWSServiceRoleForSupport"
  path = "/aws-service-role/support.amazonaws.com/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "support.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "AWSServiceRoleForTrustedAdvisor" {
  name = "AWSServiceRoleForTrustedAdvisor"
  path = "/aws-service-role/trustedadvisor.amazonaws.com/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "trustedadvisor.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "codebuild-docker-sample-service-role" {
  name = "codebuild-docker-sample-service-role"
  path = "/service-role/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "cwe-role-eu-central-1-docker-sample-pipeline" {
  name = "cwe-role-eu-central-1-docker-sample-pipeline"
  path = "/service-role/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "docker-sample-ecs-role" {
  name = "docker-sample-ecs-role"
  path = "/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "docker-sample-pipeline-role" {
  name = "docker-sample-pipeline-role"
  path = "/service-role/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
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

resource "aws_iam_role" "ecsServiceRole" {
  name = "ecsServiceRole"
  path = "/"
  assume_role_policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "StepFunctions-MyStateMachine-role-46b64e76" {
  name = "StepFunctions-MyStateMachine-role-46b64e76"
  path = "/service-role/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "states.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "StepFunctions-MyStateMachine-role-d10f5415" {
  name = "StepFunctions-MyStateMachine-role-d10f5415"
  path = "/service-role/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "states.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "TestPool-SMS-Role" {
  name = "TestPool-SMS-Role"
  path = "/service-role/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "cognito-idp.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "695c9daf-2e5a-41d9-a8b5-d67a4f9a838f"
        }
      }
    }
  ]
}
POLICY
}
//endregion
//region Internet Gateway
resource "aws_internet_gateway" "igw-00bf18b3c727d9a8e" {
  vpc_id = "vpc-060135c5d2eac2308"

  tags {
    /*    "aws:cloudformation:stack-id" = "arn:aws:cloudformation:eu-central-1:686177639067:stack/EC2ContainerService
    -myapp-cluster/ccc74550-b6ec-11ea-bc86-02433c861a1c"*/
    //    "aws:cloudformation:logical-id" = "InternetGateway"
    //    "aws:cloudformation:stack-name" = "EC2ContainerService-myapp-cluster"
  }
}

resource "aws_internet_gateway" "igw-ce439ea5" {
  vpc_id = "vpc-9c4997f6"

  tags {
  }
}
//endregion
//region Launch Configuration
resource "aws_launch_configuration" "EC2ContainerService-myapp-cluster-EcsInstanceLc-C65P627E4JGV" {
  name = "EC2ContainerService-myapp-cluster-EcsInstanceLc-C65P627E4JGV"
  image_id = "ami-0b34f371a12d673de"
  instance_type = "t3a.nano"
  iam_instance_profile = "arn:aws:iam::686177639067:instance-profile/ecsInstanceRole"
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
}

resource "aws_launch_configuration" "awseb-e-vwprxwpxjj-stack-AWSEBAutoScalingLaunchConfiguration-1105JU9N5WT6J" {
  name = "awseb-e-vwprxwpxjj-stack-AWSEBAutoScalingLaunchConfiguration-1105JU9N5WT6J"
  image_id = "ami-071b284a58700fbda"
  instance_type = "t2.micro"
  iam_instance_profile = "aws-elasticbeanstalk-ec2-role"
  security_groups = [
    "awseb-e-vwprxwpxjj-stack-AWSEBSecurityGroup-1MAR348NF7A1N"
  ]
  /*  user_data =
  "Q29udGVudC1UeXBlOiBtdWx0aXBhcnQvbWl4ZWQ7IGJvdW5kYXJ5PSI9PT09PT09PT09PT09PT01MTg5MDY1Mzc3MjIyODk4NDA3PT0iCk1JTUUtVmVyc2lvbjogMS4wCgotLT09PT09PT09PT09PT09PTUxODkwNjUzNzcyMjI4OTg0MDc9PQpDb250ZW50LVR5cGU6IHRleHQvY2xvdWQtY29uZmlnOyBjaGFyc2V0PSJ1cy1hc2NpaSIKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogN2JpdApDb250ZW50LURpc3Bvc2l0aW9uOiBhdHRhY2htZW50OyBmaWxlbmFtZT0iY2xvdWQtY29uZmlnLnR4dCIKCiNjbG91ZC1jb25maWcKcmVwb191cGdyYWRlOiBub25lCnJlcG9fcmVsZWFzZXZlcjogMi4wCmNsb3VkX2ZpbmFsX21vZHVsZXM6CiAtIFtzY3JpcHRzLXVzZXIsIGFsd2F5c10KCi0tPT09PT09PT09PT09PT09NTE4OTA2NTM3NzIyMjg5ODQwNz09CkNvbnRlbnQtVHlwZTogdGV4dC94LXNoZWxsc2NyaXB0OyBjaGFyc2V0PSJ1cy1hc2NpaSIKTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogN2JpdApDb250ZW50LURpc3Bvc2l0aW9uOiBhdHRhY2htZW50OyBmaWxlbmFtZT0idXNlci1kYXRhLnR4dCIKCiMhL2Jpbi9iYXNoCmV4ZWMgPiA+KHRlZSAtYSAvdmFyL2xvZy9lYi1jZm4taW5pdC5sb2d8bG9nZ2VyIC10IFtlYi1jZm4taW5pdF0gLXMgMj4vZGV2L2NvbnNvbGUpIDI+JjEKZWNobyBbYGRhdGUgLXUgKyIlWS0lbS0lZFQlSDolTTolU1oiYF0gU3RhcnRlZCBFQiBVc2VyIERhdGEKc2V0IC14CgoKZnVuY3Rpb24gc2xlZXBfZGVsYXkgCnsKICBpZiAoKCAkU0xFRVBfVElNRSA8ICRTTEVFUF9USU1FX01BWCApKTsgdGhlbiAKICAgIGVjaG8gU2xlZXBpbmcgJFNMRUVQX1RJTUUKICAgIHNsZWVwICRTTEVFUF9USU1FICAKICAgIFNMRUVQX1RJTUU9JCgoJFNMRUVQX1RJTUUgKiAyKSkgCiAgZWxzZSAKICAgIGVjaG8gU2xlZXBpbmcgJFNMRUVQX1RJTUVfTUFYICAKICAgIHNsZWVwICRTTEVFUF9USU1FX01BWCAgCiAgZmkKfQoKIyBFeGVjdXRpbmcgYm9vdHN0cmFwIHNjcmlwdApTTEVFUF9USU1FPTEwClNMRUVQX1RJTUVfTUFYPTM2MDAKd2hpbGUgdHJ1ZTsgZG8gCiAgY3VybCBodHRwczovL2VsYXN0aWNiZWFuc3RhbGstcGxhdGZvcm0tYXNzZXRzLWV1LWNlbnRyYWwtMS5zMy5ldS1jZW50cmFsLTEuYW1hem9uYXdzLmNvbS9zdGFsa3MvZWJfdG9tY2F0ODVjb3JyZXR0bzExX2FtYXpvbl9saW51eF8yXzEuMC4xMjUuMF8yMDIwMDYxOTAxMDg0My9saWIvVXNlckRhdGFTY3JpcHQuc2ggPiAvdG1wL2ViYm9vdHN0cmFwLnNoIAogIFJFU1VMVD0kPwogIGlmIFtbICIkUkVTVUxUIiAtbmUgMCBdXTsgdGhlbiAKICAgIHNsZWVwX2RlbGF5IAogIGVsc2UKICAgIFNMRUVQX1RJTUU9MgogICAgL2Jpbi9iYXNoIC90bXAvZWJib290c3RyYXAuc2ggICAgICdodHRwczovL2Nsb3VkZm9ybWF0aW9uLXdhaXRjb25kaXRpb24tZXUtY2VudHJhbC0xLnMzLmV1LWNlbnRyYWwtMS5hbWF6b25hd3MuY29tL2FybiUzQWF3cyUzQWNsb3VkZm9ybWF0aW9uJTNBZXUtY2VudHJhbC0xJTNBNjg2MTc3NjM5MDY3JTNBc3RhY2svYXdzZWItZS12d3ByeHdweGpqLXN0YWNrLzQ0NDVmODUwLWE3MmItMTFlYS1iNTEzLTA2NGE4ZDMyZmM5ZS9BV1NFQkluc3RhbmNlTGF1bmNoV2FpdEhhbmRsZT9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1EYXRlPTIwMjAwNjA1VDEyNTEyOVomWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JlgtQW16LUV4cGlyZXM9ODYzOTkmWC1BbXotQ3JlZGVudGlhbD1BS0lBSUdGVlhDSUJGSzdTUExLUSUyRjIwMjAwNjA1JTJGZXUtY2VudHJhbC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotU2lnbmF0dXJlPTg1ZjQ0NTA4NzY5ZjE4ODU1NGIyMmI3YTlkNTA3N2M0YjVkMjc3YThlNTI2YmY4ZDg1ZDM5ZDEzYTY3NDRhODYnICAgICdhcm46YXdzOmNsb3VkZm9ybWF0aW9uOmV1LWNlbnRyYWwtMTo2ODYxNzc2MzkwNjc6c3RhY2svYXdzZWItZS12d3ByeHdweGpqLXN0YWNrLzQ0NDVmODUwLWE3MmItMTFlYS1iNTEzLTA2NGE4ZDMyZmM5ZScgICAgJzc3MTQ1YjQ3LWQ1ZTEtNGFmNC04OTNmLTg2OWE1ZDE0YzhhZicgICAgJ2h0dHBzOi8vZWxhc3RpY2JlYW5zdGFsay1oZWFsdGguZXUtY2VudHJhbC0xLmFtYXpvbmF3cy5jb20nICAgICcnICAgICdodHRwczovL2VsYXN0aWNiZWFuc3RhbGstcGxhdGZvcm0tYXNzZXRzLWV1LWNlbnRyYWwtMS5zMy5ldS1jZW50cmFsLTEuYW1hem9uYXdzLmNvbS9zdGFsa3MvZWJfdG9tY2F0ODVjb3JyZXR0bzExX2FtYXpvbl9saW51eF8yXzEuMC4xMjUuMF8yMDIwMDYxOTAxMDg0My9saWIvcGxhdGZvcm0tZW5naW5lLnppcCcgICAgJ2V1LWNlbnRyYWwtMScKICAgIFJFU1VMVD0kPwogICAgaWYgW1sgIiRSRVNVTFQiIC1uZSAwIF1dOyB0aGVuIAogICAgICBzbGVlcF9kZWxheSAKICAgIGVsc2UgCiAgICAgIGV4aXQgMCAgCiAgICBmaSAKICBmaSAKZG9uZQoKLS09PT09PT09PT09PT09PT01MTg5MDY1Mzc3MjIyODk4NDA3PT0tLSAjI0VjMkluc3RhbmNlUmVwbGFjZW1lbnRSZXF1ZXN0PTMyOWIyYzVjLWY2MDAtNDljOC05ODQxLTAzM2I0MTM0M2RiNw=="*/
  enable_monitoring = false
  ebs_optimized = false

}
//endregion
//region Network ACL
resource "aws_network_acl" "acl-09e5da9bf33913d40" {
  vpc_id = "vpc-060135c5d2eac2308"
  subnet_ids = ["subnet-0e1a172ba4e8cd117", "subnet-0a7af08040d4919dd"]

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

  tags {
  }
}

resource "aws_network_acl" "acl-c6c4afac" {
  vpc_id = "vpc-9c4997f6"
  subnet_ids = ["subnet-45cb3739", "subnet-f0f8799a", "subnet-0305c64f"]

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

  tags {
  }
}
//endregion
//region Network Interface
resource "aws_network_interface" "eni-04b9f87210d2b82d4" {
  subnet_id = "subnet-0e1a172ba4e8cd117"
  private_ips = ["10.0.1.102"]
  security_groups = ["sg-0e517ee701ab28870"]
  source_dest_check = true
}

resource "aws_network_interface" "eni-0e42a3712d7fafa14" {
  subnet_id = "subnet-45cb3739"
  private_ips = ["172.31.36.214"]
  security_groups = ["sg-0525af0ac1c5967ae"]
  source_dest_check = true
}

resource "aws_network_interface" "eni-08dbe103560238168" {
  subnet_id = "subnet-0305c64f"
  private_ips = ["172.31.3.54"]
  security_groups = ["sg-0525af0ac1c5967ae"]
  source_dest_check = true
  attachment {
    instance = "i-0f9911f5000f1ddcf"
    device_index = 0
  }
}

resource "aws_network_interface" "eni-054f8940e221b5ac2" {
  subnet_id = "subnet-0e1a172ba4e8cd117"
  private_ips = ["10.0.1.180"]
  security_groups = ["sg-090ba253f12089c4f"]
  source_dest_check = true
  attachment {
    instance = "i-08776e73661a04ed1"
    device_index = 0
  }
}

resource "aws_network_interface" "eni-07002e907df61f58a" {
  subnet_id = "subnet-f0f8799a"
  private_ips = ["172.31.29.85"]
  security_groups = ["sg-03459968408970e2b"]
  source_dest_check = true
}

resource "aws_network_interface" "eni-07b4d5c5b7438a19f" {
  subnet_id = "subnet-0a7af08040d4919dd"
  private_ips = ["10.0.0.134"]
  security_groups = ["sg-090ba253f12089c4f"]
  source_dest_check = true
  attachment {
    instance = "i-0203c704b17f36a84"
    device_index = 0
  }
}

resource "aws_network_interface" "eni-097d03c96a9dbb5ef" {
  subnet_id = "subnet-0a7af08040d4919dd"
  private_ips = ["10.0.0.161"]
  security_groups = ["sg-0e517ee701ab28870"]
  source_dest_check = true
}

resource "aws_network_interface" "eni-03576595fa5d73854" {
  subnet_id = "subnet-f0f8799a"
  private_ips = ["172.31.31.151"]
  security_groups = ["sg-0525af0ac1c5967ae"]
  source_dest_check = true
}

resource "aws_network_interface" "eni-009e29af1377eb218" {
  subnet_id = "subnet-f0f8799a"
  private_ips = ["172.31.30.66"]
  security_groups = ["sg-0525af0ac1c5967ae"]
  source_dest_check = true
}
//endregion
//region Route53 Record
resource "aws_route53_record" "laszlo-epam-com-A-0" {
  zone_id = "Z08929871P79Z9AZQE6PE"
  name = "laszlo.epam.com"
  type = "A"
  weighted_routing_policy {
    weight = 50
  }
  set_identifier = "2"

  alias {
    name = "dualstack.library-lb-53809025.eu-central-1.elb.amazonaws.com"
    zone_id = "Z215JYRZR1TBD5"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "laszlo-epam-com-A-1" {
  zone_id = "Z08929871P79Z9AZQE6PE"
  name = "laszlo.epam.com"
  type = "A"
  weighted_routing_policy {
    weight = 50
  }
  set_identifier = "a"

  alias {
    name = "dualstack.alb1-180402111.eu-central-1.elb.amazonaws.com"
    zone_id = "Z215JYRZR1TBD5"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "laszlo-epam-com-NS" {
  zone_id = "Z08929871P79Z9AZQE6PE"
  name = "laszlo.epam.com"
  type = "NS"
  records = [
    "ns-520.awsdns-01.net.",
    "ns-1452.awsdns-53.org.",
    "ns-1978.awsdns-55.co.uk.",
    "ns-51.awsdns-06.com."
  ]
  ttl = "172800"
}

resource "aws_route53_record" "laszlo-epam-com-SOA" {
  zone_id = "Z08929871P79Z9AZQE6PE"
  name = "laszlo.epam.com"
  type = "SOA"
  records = [
    "ns-520.awsdns-01.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
  ]
  ttl = "900"
}
//endregion
//region Route53 Hosted Zone
resource "aws_route53_zone" "laszlo-epam-com-public" {
  name = "laszlo.epam.com"
  comment = ""

  tags {
  }
}
//endregion
//region Route Table
resource "aws_route_table" "rtb-daf4a4b0" {
  vpc_id = "vpc-9c4997f6"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-ce439ea5"
  }

  tags {
  }
}

resource "aws_route_table" "rtb-0eae91b8eb8a4755b" {
  vpc_id = "vpc-060135c5d2eac2308"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-00bf18b3c727d9a8e"
  }

  tags {
    /*    "aws:cloudformation:stack-id" = "arn:aws:cloudformation:eu-central-1:686177639067:stack/EC2ContainerService
    -myapp-cluster/ccc74550-b6ec-11ea-bc86-02433c861a1c"*/
    //    "aws:cloudformation:stack-name" = "EC2ContainerService-myapp-cluster"
    //    "aws:cloudformation:logical-id" = "RouteViaIgw"
  }
}

resource "aws_route_table" "rtb-0ac678ea656acc91f" {
  vpc_id = "vpc-060135c5d2eac2308"

  tags {
  }
}
//endregion
//region Route Table Association
resource "aws_route_table_association" "rtb-0eae91b8eb8a4755b-rtbassoc-0390ae378c4271068" {
  route_table_id = "rtb-0eae91b8eb8a4755b"
  subnet_id = "subnet-0e1a172ba4e8cd117"
}

resource "aws_route_table_association" "rtb-0eae91b8eb8a4755b-rtbassoc-0046816ae16dd0092" {
  route_table_id = "rtb-0eae91b8eb8a4755b"
  subnet_id = "subnet-0a7af08040d4919dd"
}
//endregion
//region S3
resource "aws_s3_bucket" "codepipeline-eu-central-1-861105447198" {
  bucket = "codepipeline-eu-central-1-861105447198"
  acl = "private"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "SSEAndSSLPolicy",
  "Statement": [
    {
      "Sid": "DenyUnEncryptedObjectUploads",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::codepipeline-eu-central-1-861105447198/*",
      "Condition": {
        "StringNotEquals": {
          "s3:x-amz-server-side-encryption": "aws:kms"
        }
      }
    },
    {
      "Sid": "DenyInsecureConnections",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::codepipeline-eu-central-1-861105447198/*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "elasticbeanstalk-eu-central-1-686177639067" {
  bucket = "elasticbeanstalk-eu-central-1-686177639067"
  acl = "private"
  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "eb-ad78f54a-f239-4c90-adda-49e5f56cb51e",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::686177639067:role/aws-elasticbeanstalk-ec2-role"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::elasticbeanstalk-eu-central-1-686177639067/resources/environments/logs/*"
    },
    {
      "Sid": "eb-af163bf3-d27b-4712-b795-d1e33e331ca4",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::686177639067:role/aws-elasticbeanstalk-ec2-role"
      },
      "Action": [
        "s3:ListBucket",
        "s3:ListBucketVersions",
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": [
        "arn:aws:s3:::elasticbeanstalk-eu-central-1-686177639067",
        "arn:aws:s3:::elasticbeanstalk-eu-central-1-686177639067/resources/environments/*"
      ]
    },
    {
      "Sid": "eb-58950a8c-feb6-11e2-89e0-0800277d041b",
      "Effect": "Deny",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:DeleteBucket",
      "Resource": "arn:aws:s3:::elasticbeanstalk-eu-central-1-686177639067"
    }
  ]
}
POLICY
}
//endregion
//region Security Group
resource "aws_security_group" "vpc-9c4997f6-library-sg" {
  name = "library-sg"
  description = "load-balancer-wizard-1 created on 2020-06-24T15:41:14.368+02:00"
  vpc_id = "vpc-9c4997f6"

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

}

resource "aws_security_group" "vpc-9c4997f6-awseb-e-vwprxwpxjj-stack-AWSEBSecurityGroup-1MAR348NF7A1N" {
  name = "awseb-e-vwprxwpxjj-stack-AWSEBSecurityGroup-1MAR348NF7A1N"
  description = "SecurityGroup for ElasticBeanstalk environment."
  vpc_id = "vpc-9c4997f6"

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

  tags {
    Name = "Myebapp-env"
    /*    "aws:cloudformation:stack-id" = "arn:aws:cloudformation:eu-central-1:686177639067:stack/awseb-e-vwprxwpxjj
    -stack/4445f850-a72b-11ea-b513-064a8d32fc9e"*/
    //    "elasticbeanstalk:environment-name" = "Myebapp-env"
    //    "elasticbeanstalk:environment-id" = "e-vwprxwpxjj"
    //    "aws:cloudformation:logical-id" = "AWSEBSecurityGroup"
    //    "aws:cloudformation:stack-name" = "awseb-e-vwprxwpxjj-stack"
  }
}

resource "aws_security_group" "vpc-060135c5d2eac2308-EC2ContainerService-myapp-cluster-EcsSecurityGroup-1JJI2HGDOUKYT" {
  name = "EC2ContainerService-myapp-cluster-EcsSecurityGroup-1JJI2HGDOUKYT"
  description = "ECS Allowed Ports"
  vpc_id = "vpc-060135c5d2eac2308"

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

  tags {
    //    "aws:cloudformation:logical-id" = "EcsSecurityGroup"
    //    "aws:cloudformation:stack-name" = "EC2ContainerService-myapp-cluster"
    /*    "aws:cloudformation:stack-id" = "arn:aws:cloudformation:eu-central-1:686177639067:stack/EC2ContainerService
    -myapp-cluster/ccc74550-b6ec-11ea-bc86-02433c861a1c"*/
  }
}

resource "aws_security_group" "vpc-060135c5d2eac2308-sc-alb1" {
  name = "sc-alb1"
  description = "load-balancer-wizard-1 created on 2020-06-25T16:43:28.700+02:00"
  vpc_id = "vpc-060135c5d2eac2308"

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
}

resource "aws_security_group" "vpc-060135c5d2eac2308-default" {
  name = "default"
  description = "default VPC security group"
  vpc_id = "vpc-060135c5d2eac2308"

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

}

resource "aws_security_group" "vpc-9c4997f6-default" {
  name = "default"
  description = "default VPC security group"
  vpc_id = "vpc-9c4997f6"

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

}
//endregion
//region Subnet
resource "aws_subnet" "subnet-0305c64f-subnet-0305c64f" {
  vpc_id = "vpc-9c4997f6"
  cidr_block = "172.31.0.0/20"
  availability_zone = "eu-central-1c"
  map_public_ip_on_launch = true

  tags {
  }
}

resource "aws_subnet" "subnet-45cb3739-subnet-45cb3739" {
  vpc_id = "vpc-9c4997f6"
  cidr_block = "172.31.32.0/20"
  availability_zone = "eu-central-1b"
  map_public_ip_on_launch = true

  tags {
  }
}

resource "aws_subnet" "subnet-f0f8799a-subnet-f0f8799a" {
  vpc_id = "vpc-9c4997f6"
  cidr_block = "172.31.16.0/20"
  availability_zone = "eu-central-1a"
  map_public_ip_on_launch = true

  tags {
  }
}

resource "aws_subnet" "subnet-0a7af08040d4919dd-subnet-0a7af08040d4919dd" {
  vpc_id = "vpc-060135c5d2eac2308"
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-central-1a"
  map_public_ip_on_launch = true

  tags {
    /*    "aws:cloudformation:stack-id" = "arn:aws:cloudformation:eu-central-1:686177639067:stack/EC2ContainerService
    -myapp-cluster/ccc74550-b6ec-11ea-bc86-02433c861a1c"*/
    //    "aws:cloudformation:logical-id" = "PubSubnetAz1"
    //    "aws:cloudformation:stack-name" = "EC2ContainerService-myapp-cluster"
  }
}

resource "aws_subnet" "subnet-0e1a172ba4e8cd117-subnet-0e1a172ba4e8cd117" {
  vpc_id = "vpc-060135c5d2eac2308"
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-central-1b"
  map_public_ip_on_launch = true

  tags {
    /*    "aws:cloudformation:stack-id" = "arn:aws:cloudformation:eu-central-1:686177639067:stack/EC2ContainerService
    -myapp-cluster/ccc74550-b6ec-11ea-bc86-02433c861a1c"*/
    //    "aws:cloudformation:stack-name" = "EC2ContainerService-myapp-cluster"
    //    "aws:cloudformation:logical-id" = "PubSubnetAz2"
  }
}
//endregion
//region SNS Subscription
resource "aws_sns_topic_subscription" "d4215257-0f6d-412e-8cd3-cafe60849750" {
  topic_arn = "arn:aws:sns:eu-central-1:686177639067:MySNS"
  protocol = "sqs"
  endpoint = "arn:aws:sqs:eu-central-1:686177639067:MsgQueue"
  raw_message_delivery = "false"
}
//endregion
//region SNS Topic
resource "aws_sns_topic" "MySNS" {
  name = "MySNS"
  display_name = "TestSNS"
  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish",
        "SNS:Receive"
      ],
      "Resource": "arn:aws:sns:eu-central-1:686177639067:MySNS",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "686177639067"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_sns_topic" "dynamodb" {
  name = "dynamodb"
  display_name = ""
  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish",
        "SNS:Receive"
      ],
      "Resource": "arn:aws:sns:eu-central-1:686177639067:dynamodb",
      "Condition": {
        "StringEquals": {
          "AWS:SourceOwner": "686177639067"
        }
      }
    }
  ]
}
POLICY
}
//endregion
//region SQS
resource "aws_sqs_queue" "MsgQueue" {
  name = "MsgQueue"
  visibility_timeout_seconds = 30
  message_retention_seconds = 345600
  max_message_size = 262144
  delay_seconds = 0
  receive_wait_time_seconds = 0
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "arn:aws:sqs:eu-central-1:686177639067:MsgQueue/SQSDefaultPolicy",
  "Statement": [
    {
      "Sid": "Sid1591349132683",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "SQS:SendMessage",
      "Resource": "arn:aws:sqs:eu-central-1:686177639067:MsgQueue",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws:sns:eu-central-1:686177639067:MySNS"
        }
      }
    }
  ]
}
POLICY
}
//endregion
//region VPC
resource "aws_vpc" "vpc-060135c5d2eac2308" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"

  tags {
    //    "aws:cloudformation:stack-name" = "EC2ContainerService-myapp-cluster"
    //    "aws:cloudformation:logical-id" = "Vpc"
    /*    "aws:cloudformation:stack-id" = "arn:aws:cloudformation:eu-central-1:686177639067:stack/EC2ContainerService
    -myapp-cluster/ccc74550-b6ec-11ea-bc86-02433c861a1c"*/
  }
}

resource "aws_vpc" "vpc-9c4997f6" {
  cidr_block = "172.31.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"

  tags {
  }
}
//endregion
