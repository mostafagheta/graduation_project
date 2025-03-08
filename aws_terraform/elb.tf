# Create Elastic Load Balancer Security Group
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Allow inbound HTTP from internet"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound traffic
  }
}

# Create Application Load Balancer
resource "aws_lb" "my_alb" {
  name               = "my-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets           = [aws_subnet.public1.id , aws_subnet.public_subnet_2.id]  # Attach to public subnet

  tags = {
    Name = "MyALB"
  }
}

# Create Target Group
resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "MyTargetGroup"
  }
}

# Attach EC2 Instances to Target Group
resource "aws_lb_target_group_attachment" "attach_1" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.private_ec2_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach_2" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.private_ec2_2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach_3" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.private_ec2_3.id
  port             = 80
}

# Create Load Balancer Listener on Port 80
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}