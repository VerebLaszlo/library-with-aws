//Outputs
output url {
  value = aws_lb.lb-main.dns_name
}

output zone-id {
  value = aws_lb.lb-main.zone_id
}

output dep-target-group {
  value = aws_lb_target_group.lb-library
}
