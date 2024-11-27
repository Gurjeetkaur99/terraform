terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.76.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name : "terraform-vpc"
  }
}

resource "aws_subnet" "mysubnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "MySubnet"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route" "myroutes" {
  route_table_id         = aws_route_table.my-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my-igw.id
}

resource "aws_route_table_association" "myrt_association" {
  route_table_id = aws_route_table.my-route-table.id
  subnet_id      = aws_subnet.mysubnet.id
}

resource "aws_security_group" "my-sg" {
  name        = "Allow_All"
  vpc_id      = aws_vpc.myvpc.id
  description = "Allow_All_traffic"
  ingress {
    description = "Allow_All"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    description = "Allow_All"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "Allow_All"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    description = "Allow_All"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]

  }
}

resource "aws_key_pair" "demo-key" {
  key_name = "terraform-key"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "myec2instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.mysubnet.id
  key_name                    = aws_key_pair.demo-key.key_name
  vpc_security_group_ids      = [aws_security_group.my-sg.id]

  tags = {
    Name = "Terraform ec2"
  }

  provisioner "local-exec" {
    command = "echo 'Ec2 Instance with public IP ${self.private_ip} is up and running' > instance_info.txt"
  }
}

resource "null_resource" "copy_file" {
  provisioner "file" {
    source = "install_apache.sh"
    destination = "/tmp/install_apache.sh"
    connection {
      type = "ssh"
      user = "ec2-user"
      host = aws_instance.myec2instance.public_ip
      private_key = file(var.private_key_path)
    }
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ec2-user"
      host = aws_instance.myec2instance.public_ip
      private_key = file(var.private_key_path)
    }
    inline = [ "bash /tmp/install_apache.sh" ]
  }
  depends_on = [ aws_instance.myec2instance ]
}


