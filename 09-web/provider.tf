terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.68.0"
    }
  }

  backend "s3" {
    bucket         = "roboriya-backend-state-dev"
    key            = "web" # path where it needs to be stored in s3
    region         = "us-east-1"
    dynamodb_table = "roboriya-state-lock-dev"

  }

}


provider "aws" {
  region = "us-east-1"
}



