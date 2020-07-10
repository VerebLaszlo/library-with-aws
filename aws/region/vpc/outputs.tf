output vpc_region {
  value = var.region
}

output vpc_name {
  value = lookup(aws_vpc.library.tags, "Name", "unknown")
}
