# Outputs
output subnet-ids {
  value = aws_subnet.subnet[*].id
}
