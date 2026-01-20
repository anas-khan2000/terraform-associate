## Lab: Dynamic Blocks

Dynamic blocks in Terraform allow you to generate repeatable nested blocks within resources, data, provider, and provisioner blocks by iterating over complex values.

### Tasks Overview

1. **Create a Security Group Resource**  
    Define an AWS security group with multiple `ingress` rules directly in `main.tf`.

2. **Inspect State Without Dynamic Block**  
    Apply the configuration and use `terraform state list` and `terraform state show` to view the resource structure.

3. **Refactor Using Dynamic Block**  
    Replace repeated `ingress` blocks with a `dynamic` block, sourcing rule data from a local value for maintainability.

4. **Inspect State With Dynamic Block**  
    Re-apply and inspect the state to confirm the dynamic block generates the expected nested blocks.

5. **Dynamic Block with Map Variable**  
    Move ingress rule definitions to a map variable (`web_ingress`) for greater flexibility and refactor the dynamic block to use this variable.

6. **Inspect State With Map Variable**  
    Apply and inspect the state to verify the dynamic block works with the map variable.

### Best Practices

- Use dynamic blocks only when necessary to simplify module interfaces.
- Prefer explicit nested blocks for readability and maintainability when possible.
- Avoid overusing dynamic blocks, as they can make configurations harder to understand.
### Examples

#### Example 1: Multiple Ingress Rules Without Dynamic Block

```hcl
resource "aws_security_group" "example" {
    name = "example-sg"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
```

#### Example 2: Using a Dynamic Block

```hcl
locals {
    ingress_rules = [
        {
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
        {
            from_port   = 443
            to_port     = 443
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    ]
}

resource "aws_security_group" "example" {
    name = "example-sg"

    dynamic "ingress" {
        for_each = local.ingress_rules
        content {
            from_port   = ingress.value.from_port
            to_port     = ingress.value.to_port
            protocol    = ingress.value.protocol
            cidr_blocks = ingress.value.cidr_blocks
        }
    }
}
```

#### Example 3: Dynamic Block with Map Variable

```hcl
variable "web_ingress" {
    type = map(object({
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = list(string)
    }))
    default = {
        http = {
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
        https = {
            from_port   = 443
            to_port     = 443
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}

resource "aws_security_group" "example" {
    name = "example-sg"

    dynamic "ingress" {
        for_each = var.web_ingress
        content {
            from_port   = ingress.value.from_port
            to_port     = ingress.value.to_port
            protocol    = ingress.value.protocol
            cidr_blocks = ingress.value.cidr_blocks
        }
    }
}
```