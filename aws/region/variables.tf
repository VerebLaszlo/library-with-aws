// Variables
provider "aws" {
  version = "~> 2.67"
  region = "us-east-1"
}

//region Input Variables
variable "region" {
  description = "The name of the AWS region to set up a network within"
}

variable "base_cidr_block" {}
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

variable "region_numbers" {
  default = {
    us-east-1 = 0
    us-east-2 = 1
    us-west-1 = 2
    us-west-2 = 3
  }
}
//endregion
