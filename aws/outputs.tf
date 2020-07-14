output vpc_names {
  value = [module.us-east-1.vpc_name/*, module.us-west-2.vpc_name*/]
}

output ami_desc {
  value = [module.us-east-1.ami_desc/*, module.us-west-2.ami_desc*/]
}

output s3_id {
  value = aws_s3_bucket.library-learning.id
}
