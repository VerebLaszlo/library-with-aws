# script arguments
project_name = "library"
tableName = "Books"
tags = {
  access-project = "library"
  access-team = "eng"
}

# configuration arguments
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
