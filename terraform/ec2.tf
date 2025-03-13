resource "aws_instance" "private_ec2_1" {
  ami= "ami-0cb91c7de36eed2cb"  # Ubuntu AMI
  instance_type = "t3.large"
  subnet_id     = aws_subnet.private1.id
  associate_public_ip_address = false
  key_name       = aws_key_pair.my_key.key_name
  private_ip     = "10.0.2.10"
  security_groups = [aws_security_group.security_group.id]
  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              echo "Hello from EC2 number 1 - Private IP: $(hostname -I)" > /var/www/html/index.html
              systemctl enable nginx
              systemctl start nginx
              EOF
}
resource "aws_instance" "private_ec2_2" {
  ami= "ami-0cb91c7de36eed2cb"  
  instance_type = "t3.large"
  subnet_id     = aws_subnet.private1.id
  associate_public_ip_address = false
  key_name       = aws_key_pair.my_key.key_name
  private_ip     = "10.0.2.11"
  security_groups = [aws_security_group.security_group.id]
  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              echo "Hello from EC2 number 2 - Private IP: $(hostname -I)" > /var/www/html/index.html
              systemctl enable nginx
              systemctl start nginx
              EOF
}
resource "aws_instance" "private_ec2_3" {
  ami= "ami-0cb91c7de36eed2cb"  
  instance_type = "t3.large"
  subnet_id     = aws_subnet.private1.id
  associate_public_ip_address = false
  key_name       = aws_key_pair.my_key.key_name
  private_ip     = "10.0.2.12"
  security_groups = [aws_security_group.security_group.id]
  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              echo "Hello from EC2 number 3 - Private IP: $(hostname -I)" > /var/www/html/index.html
              systemctl enable nginx
              systemctl start nginx
              EOF
}
resource "aws_instance" "public_ec2" {
  ami= "ami-0cb91c7de36eed2cb"  # Ubuntu AMI
  instance_type = "t3.large"
  subnet_id     = aws_subnet.public1.id
  associate_public_ip_address = true
  key_name       = aws_key_pair.my_key.key_name
  private_ip     = "10.0.1.10"
  security_groups = [aws_security_group.security_group.id]
}
resource "aws_key_pair" "my_key" {
public_key = file("/home/mostafagheta/.ssh/my_key.pub")
}