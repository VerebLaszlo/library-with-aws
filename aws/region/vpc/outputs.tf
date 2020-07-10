output vpc_region {
  value = var.region
}

output vpc_name {
  value = lookup(aws_vpc.library.tags, "Name", "unknown")
}

output private_sg_id {
  value = aws_security_group.library_private.id
}

output private_subnet_ids {
  value = aws_subnet.library_private.*.id
}

output public_sg_id {
  value = aws_security_group.library_public.id
}

output public_subnet_ids {
  value = aws_subnet.library_public.*.id
}
