# script arguments
project-name = "Library"
tableName = "Books"
tags = {
  access-project = "library"
  access-team = "eng"
  managed-by = "terraform"
}

# configuration arguments
domain-name = "library-epam.tk"
instance-type = "t2.micro"
image-owners = ["amazon"]
image-name-prefixes = ["amzn2-ami-hvm*"]
vpc-cidr = "10.0.0.0/16"
public-cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24",
]
private-cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24",
  "10.0.21.0/24",
  "10.0.22.0/24"
]
access-ip = "0.0.0.0/0"
