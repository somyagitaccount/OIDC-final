terraform {
  backend "s3" {
    bucket = "github-oidc-terraform-aws-bucket06"
    dynamodb_table = "state-lock"
    key = "state-file/terraform.tfstate"
    region = "us-east-1"
    encrypt = true 
  }
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }
}