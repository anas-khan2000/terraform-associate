terraform {
  backend "s3" {
    bucket         = "my-terraform-state-mak"
    key            = "lab03/terraform.tfstate"
    region         = "us-east-1"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
  }
}