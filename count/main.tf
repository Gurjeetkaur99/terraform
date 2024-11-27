terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.76.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

resource "aws_instance" "web" {
  count         = 2
  ami           = "ami-0942ecd5d85baa812"
  instance_type = "t2.micro"
  tags = {
    Name = "web-0${count.index}"
    //web-00
    //web-01
  }
}

/* if count is 2---count.index--0
               1-----------0
               2-----------1
               */