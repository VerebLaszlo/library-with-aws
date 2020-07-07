output "subnet_id" {
  value = aws_subnet.library_sn.id
}

output "security_group_id" {
  value = aws_security_group.library_sg.id
}
