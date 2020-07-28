//Outputs
output target-group-arn {
  value = aws_lb_target_group.lb-library.arn
}

output url {
  value = aws_lb.lb-main.dns_name
}
