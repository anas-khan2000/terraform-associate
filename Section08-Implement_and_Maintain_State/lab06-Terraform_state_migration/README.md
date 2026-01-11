## Terraform State Migration

This section demonstrates how to migrate Terraform state between different backends.

### 1. Start with Local Backend

- Remove any existing `backend` block from your Terraform configuration.
- Initialize the configuration and apply to create infrastructure locally:

    ```sh
    terraform init
    terraform apply
    ```

- The state file `terraform.tfstate` will be created locally.

---

### 2. Migrate State to S3 Backend

- Update your Terraform configuration to add an S3 backend:

    ```hcl
    terraform {
        backend "s3" {
            bucket = "your-s3-bucket"
            key    = "path/to/terraform.tfstate"
            region = "us-east-1"
        }
    }
    ```

- Run the following command to migrate the state:

    ```sh
    terraform init -migrate-state
    ```

- Confirm the migration when prompted.
- Verify the migration:

    ```sh
    terraform state list
    ```

- You can also check the S3 bucket via the AWS Console to confirm the state file is present.

---

### 3. Migrate State to Remote Enhanced Backend (Terraform Cloud)

- Update your configuration to use the remote backend:

    ```hcl
    terraform {
        backend "remote" {
            organization = "your-org"

            workspaces {
                name = "your-workspace"
            }
        }
    }
    ```

- Run the migration:

    ```sh
    terraform init -migrate-state
    ```

- Confirm the migration when prompted.
- Verify the state:

    ```sh
    terraform state list
    ```

- You can also verify the state in the Terraform Cloud UI.

---

### 4. Migrate State Back to Local Backend

- Remove the `backend` block from your configuration.
- Run the migration:

    ```sh
    terraform init -migrate-state
    ```

- Confirm the migration when prompted.
- Verify that the `terraform.tfstate` file is created locally.

---

**Note:** Always back up your state files before performing migrations.