resource "aws_security_group" "http-sg" {
  name        = "allow_http_access"
  description = "allow inbound http traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "from my ip range"
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "from my ip range"
    from_port   = "3000"
    to_port     = "3000"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "from my ip range"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    to_port     = "0"
  }
  tags = {
    "Name" = "Application-1-sg"
  }
}
data "aws_ami" "amazon_ami" {
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20220606.1-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  most_recent = true
  owners      = ["amazon"]
}

resource "aws_instance" "app-server1" {
  instance_type   = "t2.micro"
  ami             = data.aws_ami.amazon_ami.id
  vpc_security_group_ids = [aws_security_group.http-sg.id]
  subnet_id              = aws_subnet.private-2a.id
  private_ip = "172.16.10.5"
  key_name = "terraform-key"
  associate_public_ip_address = true
  tags = {
    Name = "app-server-1"
  }
  user_data = file("user_data.tpl")
}
