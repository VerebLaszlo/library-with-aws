provider aws {
  version = "~>2.69"
  region = var.region
}

provider aws {
  alias = "us-east-1"
  version = "~>2.69"
  region = "us-east-1"
}

provider aws {
  alias = "us-west-2"
  version = "~>2.69"
  region = "us-west-2"
}