resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Terraform-VPC"
  }
}

resource "aws_subnet" "pub-sub" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Terraform-SUB"
  }
}

resource "aws_subnet" "priv-sub" {
  availability_zone       = "eu-west-1a"
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "Terraform-Priv-Sub"
  }
}

resource "aws_subnet" "priv-sub2" {
  availability_zone       = "eu-west-1b"
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "Terraform-Priv-Sub2"
  }
}

resource "aws_security_group" "instance1-sg" {
  name        = "network rules"
  description = "Allow SSH and port 80 for instance1"
  vpc_id      = aws_vpc.terraform-vpc.id

  dynamic "ingress" {
    iterator = port
    for_each = var.inbound_ports
    content {
      from_port   = port.key
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0", aws_vpc.terraform-vpc.cidr_block]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terraform-SG"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "Terraform-IGW"
  }
}

resource "aws_route_table" "routetable" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "Terraform-RT"
  }
}

resource "aws_route_table_association" "route-subnet" {
  subnet_id      = aws_subnet.pub-sub.id
  route_table_id = aws_route_table.routetable.id
}