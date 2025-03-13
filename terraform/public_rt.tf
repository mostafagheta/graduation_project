# Create Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "PublicRouteTable"
  }
}


# Add Route to Internet Gateway in Public Route Table
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}


# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rt.id
}