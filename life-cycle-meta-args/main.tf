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

resource "aws_instance" "myec2" {
  ami           = "ami-0942ecd5d85baa812"
  instance_type = "t2.micro"
  #lifecycle {
  # create_before_destroy = true
  # }
  #lifecycle {
  # prevent_destroy = true
  #}
  #lifecycle {
   
   # ignore_changes = [tags, ]
  #}
  tags = {
    Name = "WebServer"
    Dept = "IT"

  }
}