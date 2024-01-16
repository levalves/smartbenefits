terraform {
  backend "s3" {
    region = "us-east-2"
    bucket = "levalves-terraform-tfstates"
    key    = "my-app-dot-net/terraform.tfstate"
  }
}

provider "aws" {
  region = var.region

  #   assume_role {
  #   role_arn = var.role_arn
  # }

  default_tags {
    tags = {
      product     = var.product
      env         = var.environment
      application = var.application
      terraform   = var.terraform
    }
  }
}