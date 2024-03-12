
resource "aws_instance" "app_server" {
  ami                         = var.ami
  instance_type               = var.instance_size
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.main.id

  vpc_security_group_ids = [aws_security_group.allow_http_external.id, aws_security_group.allow_ssh_external.id]

  tags = {
    Name = "demo"
    Environment = var.environment_name
  }
}


resource "aws_security_group" "allow_http_external" {
  name        = "allow-http-external"
  description = "Incoming HTTP traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "allow_ssh_external" {
  name        = "allow-ssh-external"
  description = "Incoming SSH traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 21
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  lifecycle {
    create_before_destroy = true
  }
}