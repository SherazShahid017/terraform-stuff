# Configure the AWS Provider
provider "aws" {
  region                  = "eu-west-1"
  shared_credentials_file = "/home/ubuntu/.aws/credentials"
}

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
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "Terraform-Priv-Sub"
  }
}

resource "aws_security_group" "instance1-sg" {
  name        = "allow-ssh-terraform"
  description = "Allow SSH inbound, for instance1 ec2"
  vpc_id      = aws_vpc.terraform-vpc.id

  ingress {
    description = "SSH for ec2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.31.42.94", aws_vpc.terraform-vpc.cidr_block]
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

resource "aws_instance" "instance1" {
  ami                    = "ami-0dc8d444ee2a42d8a"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.instance1-sg.id]
  subnet_id              = aws_subnet.pub-sub.id


  tags = {
    Name = "Terraform-built-ec2"
  }
}

resource "aws_key_pair" "keypair" {
  key_name   = "instance1-key"
  public_key = var.pub-key
}