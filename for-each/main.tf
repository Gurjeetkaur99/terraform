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

resource "aws_s3_bucket" "mys3buckets" {
  for_each = {
    "dev"   = "my-devapp-bucket-ncpl"
    "qa"    = "my-qaapp-bucket-ncpl"
    "stage" = "my-stageapp-bucket-ncpl"
    "prod"  = "my-prodapp-bucket-ncpl"
  }

  bucket = "${each.key}-${each.value}" //dev-my-devapp-bucket-ncpl

  tags = {
    Environment = each.key
    bucketname  = "${each.key}-${each.value}"
  }
}