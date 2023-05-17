
# Configure the AWS Provider
provider "aws" {
    region = "ap-southeast-1"
    profile = "default"
}
terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.29"
    }
    }
  backend "s3" {
    bucket         = "nghianv2-tfstate-s3-backend"
    key            = "test/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
  }
}
provider "aws" {
        alias  = "acm_provider"
        region = "ap-southeast-1"
}