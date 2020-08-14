# Outputs
output id {
  value = aws_vpc.vpc-main.id
}

output public-subnet-ids {
  value = module.public.subnet-ids
}

output private-subnet-ids {
  value = module.private.subnet-ids
}
