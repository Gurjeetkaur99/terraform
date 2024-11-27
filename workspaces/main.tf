terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.76.0"
    }
  }
  backend "s3" {
    bucket = "terraformawsbackendconfgurj"
    key = "terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "terraform-lockgurj"
    encrypt = true
  }
}

provider "aws" {
  # Configuration options
}

variable "ami_id" {}
variable "instance_type" {}
variable "Name" {}
variable "env" {}

resource "aws_instance" "myec2" {
  instance_type = var.instance_type
  ami = var.ami_id
  tags = {
    Name = var.Name
    env = var.env
  }
}



