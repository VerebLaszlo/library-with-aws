// Variables
provider "aws" {
  version = "~> 2.67"
  region = "us-east-1"
}

//region Constants
variable "base_cidr_block" {
  default = "10.0.0.0/20"
}

variable "tags" {
  description = "Tags to use for ABAC"
  type = map(string)
  default = {
    access-project = "library"
    access-team = "eng"
  }
}

variable "tableName" {
  default = "Books"
}
//endregion
