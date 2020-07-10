# script parameters
variable project_name { description = "Name of the project" }

variable tableName { description = "Name of the dynamoDB table" }

variable tags {
  description = "Tags to use for ABAC"
  type = map(string)
}

#region configuration parameters
variable region {
  description = "The main region"
  default = "us-east-1"
}

variable instance_type {}

variable ami_owner_ids { type = list(string) }

variable ami_name_filter { type = list(string) }

variable vpc_cidr {}

variable public_cidrs { type = list(string) }

variable private_cidrs { type = list(string) }

variable access_ip {}
#endregion
