terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.52.0"
      # https://registry.terraform.io/providers/hashicorp/aws/latest - refer this link to get the version and how to use the provider
    }
  }
}

provider "aws" {
  region = "us-east-1"
  # We will use "us-east-1" region for our testing
}
