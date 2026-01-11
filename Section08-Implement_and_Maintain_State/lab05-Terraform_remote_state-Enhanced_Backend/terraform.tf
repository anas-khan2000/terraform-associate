terraform {
  backend "http" {
    address        = "http://localhost:5001/terraform_state/my_state"
    lock_address   = "http://localhost:5001/terraform_lock/my_state"
    lock_method    = "PUT"
    unlock_address = "http://localhost:5001/terraform_lock/my_state"
    unlock_method  = "DELETE"
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