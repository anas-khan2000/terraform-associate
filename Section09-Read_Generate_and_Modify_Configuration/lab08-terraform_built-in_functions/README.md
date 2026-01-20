## Lab: Terraform Built-in Functions

This lab demonstrates how to use Terraform's built-in functions to manipulate and transform data within your configurations. These functions help you work with numbers, strings, collections, and networking constructs efficiently.

### Task 1: Use Basic Numerical Functions

Terraform provides functions like `max()` and `min()` to operate on numbers. For example, you can define variables in `variables.tf`:

```hcl
variable "num_1" { type = number, default = 88 }
variable "num_2" { type = number, default = 73 }
variable "num_3" { type = number, default = 52 }
```

And use them in `main.tf`:

```hcl
locals {
    maximum = max(var.num_1, var.num_2, var.num_3)
    minimum = min(var.num_1, var.num_2, var.num_3, 44, 20)
}

output "max_value" { value = local.maximum }
output "min_value" { value = local.minimum }
```

Run `terraform apply -auto-approve` to see the outputs.

---

### Task 2: Manipulate Strings Using Terraform Functions

String functions like `upper()` and `lower()` help standardize resource tags:

```hcl
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name        = upper(var.vpc_name)
        Environment = upper(var.environment)
        Terraform   = upper("true")
    }
    enable_dns_hostnames = true
}
```

#### Task 2.1: Enforce Lowercase Tag Standards

Use `lower()` to ensure all tags are lowercase:

```hcl
locals {
    common_tags = {
        Name      = lower(local.server_name)
        Owner     = lower(local.team)
        App       = lower(local.application)
        Service   = lower(local.service_name)
        AppTeam   = lower(local.app_team)
        CreatedBy = lower(local.createdby)
    }
}
```

Set variables in `terraform.auto.tfvars` and run `terraform plan` and `terraform apply` to see the changes.

#### Task 2.2: Dynamic Tag Generation with `join()`

Generate tag values dynamically:

```hcl
locals {
    common_tags = {
        Name = join("-", [local.application, data.aws_region.current.name, local.createdby])
        # other tags...
    }
}
```

This approach makes modules reusable and tags consistent.

---

### Task 3: Use `cidrsubnet` to Create Subnets

The `cidrsubnet()` function helps generate subnet CIDRs from a base VPC CIDR:

```hcl
resource "aws_subnet" "private_subnets" {
    for_each          = var.private_subnets
    vpc_id            = aws_vpc.vpc.id
    cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value)
    availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]
    tags = {
        Name      = each.key
        Terraform = "true"
    }
}
```

Experiment with `cidrsubnet` to create subnets that fit your requirements.

---

**Summary:**  
Terraform's built-in functions are powerful tools for transforming data, standardizing resource definitions, and automating infrastructure creation. Practice using these functions to make your configurations more dynamic and maintainable.