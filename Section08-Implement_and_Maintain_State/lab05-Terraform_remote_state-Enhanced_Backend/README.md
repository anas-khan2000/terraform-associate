## Enhanced Terraform Remote State Lab

In this lab, we implement an enhanced Terraform remote state using Terraform Cloud.

### Steps Overview

1. **Login to Terraform Cloud**
    - Access the Terraform Cloud UI and note your organization name.

2. **Authenticate via CLI**
    - Run `terraform login` in your terminal and authenticate using your token.

3. **Configure Remote Backend**
    - Update your `terraform` block to use the remote backend:
      ```hcl
      terraform {
         backend "remote" {
            hostname     = "app.terraform.io"
            organization = "YOUR-ORGANIZATION"

            workspaces {
              name = "my-aws-app"
            }
         }
      }
      ```

4. **Reinitialize and Apply**
    - Run `terraform init` to reinitialize the backend.
    - Apply your configuration. State and logs are now managed in Terraform Cloud.

5. **Handle Credentials**
    - If you encounter a credentials error, add variables (e.g., `AWS_ACCESS_KEY`, `AWS_SECRET_KEY`) in Terraform Cloud as sensitive variables.

6. **Approve and Apply via UI**
    - After running `terraform apply`, review and approve the plan in the UI. Infrastructure is created upon approval.

### Benefits of Remote Backend

- Centralized state storage and workflow management.
- View run history, state history, and all workspaces.
- Lock workspaces to prevent conflicting changes and state corruption.
- Execute Terraform workflows via CLI or UI.

### Workspace Locking

- Viewing and locking the state file prevents concurrent modifications.
- If locked, `terraform apply` will wait until the workspace is unlocked.

### Cleanup

- Destroy the infrastructure when finished.
