# script parameters
variable project-name { description = "Name of the project" }

variable tableName { description = "Name of the dynamoDB table" }

variable tags {
  description = "Tags to use for ABAC"
  type = map(string)
}

# configuration parameters
variable domain-name {
  description = "Access library here."
}

variable region {
  description = "The main region"
  default = "us-east-1"
}

variable instance-type {
  description = "Instance type to use for the service"
  default = "t2.micro"
}

variable image-owners {
  description = "List of image owners, like AWS account ID, self, AWS owner alias, e.g. amazon"
}

variable image-name-prefixes {
  description = "List of image name prefixes"
}

variable vpc-cidr {}

variable public-cidrs { type = list(string) }

variable private-cidrs { type = list(string) }

variable access-ip {}
