## Lab: Terraform Graph

Terraform's interpolation syntax is very human-friendly, but under the hood it builds a powerful resource graph. When resources are created, they expose relevant properties, and Terraform's resource graph determines dependency management and execution order. This enables parallel management of resources, optimizing deployment speed.

The resource graph is an internal representation of all resources and their dependencies. A human-readable graph can be generated using the `terraform graph` command.

---

### Task 1: Terraform's Resource Graph and Dependencies

When resources are created, they expose properties that other resources can reference. For example, in a typical `main.tf`:

```hcl
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name        = var.vpc_name
        Environment = "demo_environment"
        Terraform   = "true"
    }
    enable_dns_hostnames = true
}

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

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "demo_igw"
    }
}

resource "tls_private_key" "generated" {
    algorithm = "RSA"
}
```

- The subnets and internet gateway depend on the VPC.
- The private key has no dependencies.

Terraform builds a data structure (the resource graph) around these resources. Some nodes depend on others, while some are independent. The arrows in the graph show dependencies and execution order.

#### Terraform Graph: Built-in Dependency Management

Terraform traverses the graph multiple times (collecting input, validating, planning, applying). It determines which resources can be created in parallel and which must be sequential. For example, the private key can be built in parallel with the VPC, while subnets and internet gateways depend on the VPC.

---

### Task 2: Generate a Graph Using `terraform graph`

The `terraform graph` command generates a visual representation (in DOT format) of the configuration or execution plan. This can be rendered using GraphViz tools.

**Steps:**
```sh
terraform init
terraform apply
terraform graph
```

Sample output:
```
digraph {
    compound = "true"
    newrank = "true"
    subgraph "root" {
        # ...
    }
}
```

Paste the DOT output into [WebGraphviz](http://www.webgraphviz.com) to visualize the dependencies.

---

### Visualize Terraform Graph

- Find your resources on the graph and follow the dependencies.
- Terraform uses this graph to manage resource creation order and parallelism.

---

### Visualize Terraform Graph Dependencies

- Use the graph to understand and troubleshoot resource dependencies in your configuration.
- This visualization helps ensure your infrastructure is built as intended.
