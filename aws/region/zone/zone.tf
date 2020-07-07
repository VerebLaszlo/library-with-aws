/* Represents a subnet within a given availability zone. This is instantiated twice per region, using the first two
 * availability zones supported within the target AWS account.
 */

resource "aws_subnet" "library_sn" {
  cidr_block = cidrsubnet(data.aws_vpc.target.cidr_block,
                          2,
                          lookup(var.az_numbers, data.aws_availability_zone.target.name_suffix, 0))
  vpc_id = var.vpc_id
  availability_zone = var.availability_zone

  tags = var.tags
}

resource "aws_route_table" "library_rt" {
  vpc_id = var.vpc_id

  tags = var.tags
}

resource "aws_route_table_association" "library_rta" {
  subnet_id = aws_subnet.library_sn.id
  route_table_id = aws_route_table.library_rt.id
}

resource "aws_security_group" "library_sg" {
  name = "library-az-${data.aws_availability_zone.target.name}"
  description = "Open access within the AZ ${data.aws_availability_zone.target.name}"
  vpc_id = var.vpc_id

  ingress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = [aws_subnet.library_sn.cidr_block]
  }

  tags = var.tags
}
