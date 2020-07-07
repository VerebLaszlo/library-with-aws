// Variables
//region Input Variables
variable "vpc_id" {}

variable "availability_zone" {}
//endregion

//region Constants
variable "tags" {
  description = "Tags to use for ABAC"
  type = map(string)
  default = {
    access-project = "library"
    access-team = "eng"
  }
}

variable "az_numbers" {
  default = {
    a = 0
    b = 1
    c = 2
    d = 3
    e = 4
    f = 5
    g = 6
    h = 7
    i = 8
    j = 9
    k = 10
    l = 11
    m = 12
    n = 13
  }
}
//endregion

//region data sources
data "aws_availability_zone" "target" {
  name = var.availability_zone
}

data "aws_vpc" "target" {
  id = var.vpc_id
}
//endregion
