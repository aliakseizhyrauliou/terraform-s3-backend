terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
  profile = "default"
}

terraform {
  backend "s3" {
    bucket         = "training-tfstate-zhurauliou"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "tfstate-lock"
    encrypt        = true
  }
}