# script parameters
variable project-name { description = "Name of the project" }

variable tableName { description = "Name of the dynamoDB table" }

variable tags {
  description = "Tags to use for ABAC"
  type = map(string)
}

# configuration parameters
variable region {
  description = "The main region"
  default = "us-east-1"
}

variable instance-type {
  description = "Instance type to use for the service"
  default = "t2.micro"
}

variable image-id {
  description = "Image id to use on the instance"
}

variable vpc-cidr {}

variable public-cidrs { type = list(string) }

variable private-cidrs { type = list(string) }

variable access-ip {}
