terraform {
  required_version = "1.6.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.29.0"
    }
  }

  backend "s3" {
    bucket = "674283423467-terraform-state"
    key    = "arithmetic-lambda"
    region = "eu-north-1"
  }
}

provider "aws" {
  allowed_account_ids = ["674283423467"]
  region              = "eu-north-1"

  default_tags {
    tags = {
      application = "arithmetic-lambda"
      terraform   = true
    }
  }
}
