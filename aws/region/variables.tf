# script parameters
variable project_name {}

variable tags { type = map(string) }

# configuration parameters
variable region {
  description = "The name of the AWS region to set up a network within"
}

variable instance_type {}

variable ami_owner_ids { type = list(string) }

variable ami_name_filter { type = list(string) }

variable vpc_cidr {}

variable public_cidrs { type = list(string) }

variable private_cidrs { type = list(string) }

variable access_ip {}
