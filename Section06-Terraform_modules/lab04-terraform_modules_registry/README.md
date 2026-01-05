1. In this lab we tested various modules available on public registry.
2. First we created s3 bucket using s3 module from terraform registry.
3. Then we tested vpc module from the terraform module registry.
4. This shows how easy it is to use for creating common infra, instead of creating all the required resources separately we should utilize these modules to create infra.
ex: vpc module-
Below module will handle creation of subnets,gateways -

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc-terraform"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Name        = "VPC from Module"
    Terraform   = "true"
    Environment = "dev"
  }
}