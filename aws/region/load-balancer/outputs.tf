//Outputs
output url {
  value = aws_lb.lb-main.dns_name
}

output dep-target-group {
  value = aws_lb_target_group.lb-library
}
