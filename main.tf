provider "aws" {
  region = "ap-northeast-3"
}

# Subnet (replace VPC ID with your shared one)
resource "aws_subnet" "my_subnet" {
  vpc_id            = "vpc-00ffe463659a905fd"   # 🔴 Replace with your actual VPC ID
  cidr_block        = "10.0.28.0/24"
  availability_zone = "ap-northeast-3a"

  tags = {
    Name = "oromi-subnet"
  }
}

# Security group (for SSH + HTTP)
resource "aws_security_group" "my_sg" {
  vpc_id = "vpc-00ffe463659a905fd"   # 🔴 Replace with your actual VPC ID
  name   = "oromi-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
}

resource "aws_instance" "ubuntu_server" {
  ami           = "ami-05892315364982af3" # Ubuntu 22.04 in ap-northeast-3
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  key_name      = "oromi-key"  # 🔴 Replace with your AWS key pair name

  tags = {
    Name = "oromi-ubuntu-server"
  }
}
