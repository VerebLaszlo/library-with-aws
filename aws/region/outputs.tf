//
output vpc_region {
  value = module.vpc.vpc_name
}

output vpc_name {
  value = module.vpc.vpc_name
}

output ami_desc {
  value = data.aws_ami.linux.description
}

output lb_id {
  value = aws_lb.public_library.id
}
