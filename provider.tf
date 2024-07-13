provider "aws" {
  region = var.aws_region
}


terraform {
  required_version = "<= 2.6.6" #Forcing which version of Terraform needs to be used
  required_providers {
    aws = {
      version = "<= 6.0.0" #Forcing which version of plugin needs to be used.
      source  = "hashicorp/aws"
    }
  }
}


resource "aws_vpc" "k8svpc" {
  cidr_block           = var.vpccidr_block
  enable_dns_hostnames = true
  tags = {
    Name        = var.vpc_name
    owner       = "harsha"
    environment = var.vpc_env
  }

}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.k8svpc.id
  tags = {
    Name = var.vpcIGWname
  }

}

resource "aws_subnet" "publicsubnet1" {
  vpc_id            = aws_vpc.k8svpc.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = "us-east-1a"
  tags = {
    Name = var.subnet1name
  }
}

resource "aws_subnet" "publicsubnet2" {
  vpc_id            = aws_vpc.k8svpc.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = "us-east-1b"
  tags = {
    Name = var.subnet2name
  }
}

resource "aws_subnet" "publicsubnet3" {
  vpc_id            = aws_vpc.k8svpc.id
  cidr_block        = var.public_subnet3_cidr
  availability_zone = "us-east-1c"
  tags = {
    Name = var.subnet3name
  }
}


resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.k8svpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = var.RTname
  }
}

resource "aws_route_table_association" "subnet1-rt" {
  subnet_id      = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.publicroute.id
}

resource "aws_route_table_association" "subner2-rt" {
  subnet_id      = aws_subnet.publicsubnet2.id
  route_table_id = aws_route_table.publicroute.id
}

resource "aws_route_table_association" "subet3-rt" {
  subnet_id      = aws_subnet.publicsubnet3.id
  route_table_id = aws_route_table.publicroute.id
}


resource "aws_security_group" "SG" {
  name        = "allowall"
  description = "allow all inbound traffic"
  vpc_id      = aws_vpc.k8svpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

