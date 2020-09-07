provider aws {
  version = "~>3.0"
  region = var.region
}

provider aws {
  alias = "us-east-1"
  version = "~>3.0"
  region = "us-east-1"
}

provider aws {
  alias = "us-west-2"
  version = "~>3.0"
  region = "us-west-2"
}

provider template {
  version = "~>2.1"
}
