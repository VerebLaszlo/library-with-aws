# script parameters
variable project-name {}

variable tags { type = map(string) }

# configuration parameters
variable region {}

variable vpc-cidr {}

variable public-cidrs { type = list(string) }

variable private-cidrs { type = list(string) }

variable access-ip {}
