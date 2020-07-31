# script parameters
variable project-name {}

variable tags { type = map(string) }

# configuration parameters
variable is-public {}

variable vpc-id {}

variable vpc-cidr {}

variable cidrs { type = list(string) }

variable route-table {}

variable http-inbound-port {}

variable http-outbound-port {}

variable response-port {
  type = object({
    from = number
    to = number
  })
}
