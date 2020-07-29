# script parameters
variable project-name {}

variable tags { type = map(string) }

# configuration parameters
variable vpc-id {}

variable vpc-cidr {}

variable cidrs { type = list(string) }

variable route-table {}
