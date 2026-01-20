## Lab: Terraform Collections and Structure Types

This lab introduces how to organize and structure data in Terraform using various value types. You'll learn to use primitive types (string, number, bool) and complex types (list, map, object) to make your configurations more flexible and maintainable.

### Value Types in Terraform

- **string**: Text values, e.g., `"hello"`
- **number**: Numeric values, e.g., `15`, `6.28`
- **bool**: Boolean values, `true` or `false`
- **list/tuple**: Ordered sequences, e.g., `["us-west-1a", "us-west-1c"]`
- **map/object**: Key/value pairs, e.g., `{name = "Mabel", age = 52}`

### Lab Tasks Overview

1. **Create and Reference a List**
    - Define a list variable for AWS availability zones.
    - Reference list elements by index in resource configuration.

2. **Use a Map Variable**
    - Replace static values with a map variable for subnet CIDR blocks.
    - Reference map values using keys and variables.

3. **Iterate Over a Map**
    - Use `for_each` to create multiple resources from a map.
    - Each resource is uniquely identified by the map key.

4. **Group Information with a Map of Maps**
    - Use a map of maps to group environment-specific settings.
    - Simplifies configuration and improves readability.

### Example Snippets

**List Variable Example:**
```hcl
variable "us-east-1-azs" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e"]
}
```
**Reference by Index:**
```hcl
availability_zone = var.us-east-1-azs[0]
```

**Map Variable Example:**
```hcl
variable "ip" {
  type = map(string)
  default = {
     prod = "10.0.150.0/24"
     dev  = "10.0.250.0/24"
  }
}
```
**Reference by Key:**
```hcl
cidr_block = var.ip[var.environment]
```

**Iterate with for_each:**
```hcl
resource "aws_subnet" "list_subnet" {
  for_each          = var.ip
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value
  availability_zone = var.us-east-1-azs[0]
}
```

**Map of Maps Example:**
```hcl
variable "env" {
  type = map(any)
  default = {
     prod = { ip = "10.0.150.0/24", az = "us-east-1a" }
     dev  = { ip = "10.0.250.0/24", az = "us-east-1e" }
  }
}
```
**Reference Nested Values:**
```hcl
cidr_block        = each.value.ip
availability_zone = each.value.az
```

---
