# script parameters
variable project-name {}

variable tags { type = map(string) }

# configuration parameters
variable is-public {}

variable vpc-id {}

variable cidrs { type = list(string) }

variable route-table {}
