## Lab: Variable Validation and Suppression

This lab demonstrates how to validate variable inputs and suppress sensitive information in Terraform.

### Tasks Overview

1. **Validate variables in a configuration block**  
    - Create a `variable_validation` folder with a `variables.tf` file.
    - Use the `validation` block to restrict allowed values and enforce lowercase input.
    - Example:
      ```hcl
      variable "cloud" {
         type = string
         validation {
            condition     = contains(["aws", "azure", "gcp", "vmware"], lower(var.cloud))
            error_message = "You must use an approved cloud."
         }
         validation {
            condition     = lower(var.cloud) == var.cloud
            error_message = "The cloud name must not have capital letters."
         }
      }
      ```
    - Test with `terraform plan -var cloud=aws` and `terraform plan -var cloud=alibabba`.

2. **More Validation Options**  
    - Add further variable validations:
      - Enforce lowercase (`no_caps`)
      - Character length (`character_limit`)
      - IP address format (`ip_address`)
    - Example:
      ```hcl
      variable "no_caps" {
         type = string
         validation {
            condition = lower(var.no_caps) == var.no_caps
            error_message = "Value must be in all lower case."
         }
      }
      variable "character_limit" {
         type = string
         validation {
            condition = length(var.character_limit) == 3
            error_message = "This variable must contain only 3 characters."
         }
      }
      variable "ip_address" {
         type = string
         validation {
            condition = can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", var.ip_address))
            error_message = "Must be an IP address of the form X.X.X.X."
         }
      }
      ```
    - Test with valid and invalid inputs using `terraform plan`.

3. **Suppress Sensitive Information**  
    - Mark variables as sensitive to prevent them from being displayed in output.
    - Example:
      ```hcl
      variable "phone_number" {
         type = string
         sensitive = true
         default = "867-5309"
      }
      output "phone_number" {
         sensitive = true
         value = var.phone_number
      }
      ```
    - Terraform requires outputs referencing sensitive values to be explicitly marked as `sensitive = true`.

4. **View the Terraform State File**  
    - Sensitive values are still stored in the state file, so restrict access to it.
    - Example output in `terraform.tfstate`:
      ```json
      "phone_number": {
         "value": "867-5309",
         "type": "string",
         "sensitive": true
      }
      ```

### Terraform Cloud Integration

- Configure remote backend in `remote.tf`:
  ```hcl
  terraform {
     backend "remote" {
        organization = "<<ORGANIZATION NAME>>"
        workspaces {
          name = "variable_validation"
        }
     }
  }
  ```
- Use `terraform.auto.tfvars` for variable values.
- Run `terraform init` and `terraform apply` to see sensitive value handling in Terraform Cloud.
