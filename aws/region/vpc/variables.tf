# script parameters
variable project_name {}

variable tags { type = map(string) }

# configuration parameters
variable region {}

variable vpc_cidr {}

variable public_cidrs { type = list(string) }

variable private_cidrs { type = list(string) }

variable access_ip {}
