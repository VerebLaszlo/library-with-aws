# Outputs
output subnet-ids {
  value = aws_subnet.public-subnet[*].id
}
