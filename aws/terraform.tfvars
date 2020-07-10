# script arguments
project_name = "library"
tableName = "Books"
tags = {
  access-project = "library"
  access-team = "eng"
}

# configuration arguments
instance_type = "t3a.nano"
ami_owner_ids = ["099720109477", "137112412989"]
ami_name_filter = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server*", "amzn2-ami-hvm-2.0.*-x86_64-gp2"]
vpc_cidr = "10.0.0.0/16"
public_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24",
]
private_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24",
  "10.0.21.0/24",
  "10.0.22.0/24"
]
access_ip = "0.0.0.0/0"
