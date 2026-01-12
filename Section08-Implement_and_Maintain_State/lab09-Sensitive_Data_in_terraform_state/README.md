## Sensitive Data in Terraform State

Terraform state files can contain sensitive data, such as initial database passwords or secrets returned by providers. Every time you deploy infrastructure, Terraform stores detailed information—including all input parameters—within the state file.

### State File Storage

By default, Terraform stores state locally in plain-text JSON (`terraform.tfstate`). This file is not encrypted beyond your disk's protections. For example, a typical state file may look like:

```json
{
  "version": 4,
  "terraform_version": "1.1.1",
  "outputs": {
    "public_dns": { "value": "ec2-34-224-58-141.compute-1.amazonaws.com", "type": "string" },
    "public_ip": { "value": "34.224.58.141", "type": "string" }
  },
  ...
}
```

Some remote backends (e.g., Amazon S3, Terraform Cloud) support encryption at rest and in transit, IAM access controls, and logging.

---

## Suppressing Sensitive Information

Regardless of storage location, treat state files as sensitive. Terraform allows you to mark variables and outputs as sensitive:

```hcl
variable "phone_number" {
  type      = string
  sensitive = true
  default   = "867-5309"
}

output "phone_number" {
  sensitive = true
  value     = var.phone_number
}
```

If you attempt to output a sensitive value without marking the output as sensitive, Terraform will produce an error:

```
Error: Output refers to sensitive values
To reduce the risk of accidentally exporting sensitive data, annotate the output value as sensitive.
```

When marked as sensitive, Terraform will hide the value in CLI output:

```
Outputs:
phone_number = <sensitive>
```

However, **sensitive values are still stored in plain text in the state file**. For example:

```json
"phone_number": {
  "value": "867-5309",
  "type": "string",
  "sensitive": true
}
```

---

## Best Practices for Terraform State

- **Treat State as Sensitive Data:** Always assume state files may contain secrets.
- **Encrypt State Backend:** Use a backend that supports encryption (e.g., S3 with encryption enabled, Terraform Cloud).
- **Control Access:** Restrict access to state files using IAM policies or equivalent controls.
- **Limit Output of Sensitive Data:** Use the `sensitive = true` attribute for outputs and variables containing secrets.

**After working with sensitive data, remove any test configurations and destroy resources as needed.**
