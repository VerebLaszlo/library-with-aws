output vpc_names {
  value = [module.us-east-1.vpc_name, module.us-west-2.vpc_name]
}
