output subnet-ids {
  value = aws_subnet.private-subnet.*.id
}
