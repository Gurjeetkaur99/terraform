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