# Lab: Variables

Avoid hardcoding values in `main.tf` by using variables. You can set variable values in three main ways, each with a different precedence:

1. **Environment Variables:**  
    Set with `TF_VAR_<variable_name>`. Example:
    ```shell
    export TF_VAR_variables_sub_cidr="10.0.203.0/24"
    ```
    Takes precedence over defaults.

2. **tfvars File:**  
    Create a `terraform.tfvars` file:
    ```hcl
    variables_sub_auto_ip = true
    variables_sub_az      = "us-east-1d"
    variables_sub_cidr    = "10.0.204.0/24"
    ```
    Overrides environment variables and defaults.

3. **CLI Flags:**  
    Use `-var` or `-var-file` when running Terraform:
    ```shell
    terraform plan -var variables_sub_az="us-east-1e" -var variables_sub_cidr="10.0.205.0/24"
    ```
    CLI flags override all other methods.

Order of precedence: **CLI > tfvars > ENV > default**.
