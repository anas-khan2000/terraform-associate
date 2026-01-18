## Lab: Outputs

Terraform generates a large amount of metadata, making it tedious to find specific values using `terraform show`. Outputs allow you to query for specific values directly, making it easier to retrieve important information like IP addresses or URLs.

### Tasks Overview

**Task 1: Create Output Values**
- Outputs customize what Terraform displays after `apply`.
- Example output block in `outputs.tf`:
    ```hcl
    output "public_ip" {
        description = "This is the public IP of my web server"
        value       = aws_instance.web_server.public_ip
    }
    ```
- Run `terraform apply -auto-approve` to see outputs.

**Task 2: Use the Output Command**
- List all outputs:  
    ```
    terraform output
    ```
- Query a specific output:  
    ```
    terraform output public_ip
    ```
- Use output in shell commands:  
    ```
    ping $(terraform output -raw public_dns)
    ```

**Task 3: Suppress Sensitive Outputs**
- Mark outputs as sensitive to hide values in CLI:
    ```hcl
    output "ec2_instance_arn" {
        value     = aws_instance.web_server.arn
        sensitive = true
    }
    ```
- Sensitive outputs show as `<sensitive>` in CLI but are still stored in state files.
- We can still see these sensitive values using terraform output <output_name>, ex: terrafrom output ec2_instance_arn

---

**Example Outputs:**
```
Outputs:

ec2_instance_arn = <sensitive>
hello-world      = "Hello World"
public_ip        = "44.200.207.151"
public_url       = "https://10.0.101.169:8080/index.html"
vpc_id           = "vpc-0dcd2b053088ea107"
vpc_information  = "Your demo_environment VPC has an ID of vpc-0dcd2b053088ea107"
```