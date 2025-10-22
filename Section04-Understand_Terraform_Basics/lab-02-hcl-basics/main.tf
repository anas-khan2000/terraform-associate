provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "web" {
  ami           = "ami-06fa3f12191aa3337"
  instance_type = "t3.micro"

  subnet_id              = "subnet-068ad35d9473447d0"
  vpc_security_group_ids = ["sg-09e8ba3a643c5d7dd"]

  tags = {
    "terraform"  = "true"
    "created_by" = "mak"
  }
}