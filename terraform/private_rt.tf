# Create Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "PrivateRouteTable"
  }
}

# Add Route to NAT Gateway in Private Route Table
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_rt.id
}