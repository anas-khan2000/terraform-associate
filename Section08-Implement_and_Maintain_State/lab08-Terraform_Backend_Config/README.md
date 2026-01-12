## Terraform Backend Configuration

### Default Backend

By default, Terraform uses the local backend, storing state in a `terraform.tfstate` file in your working directory. To explicitly specify the backend, add a backend configuration block to your `terraform.tf`:

```hcl
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
```

Initialize and apply your configuration:

```sh
terraform init
terraform plan
terraform apply
```

---

### Partial Backend Configuration via File

Backend blocks do **not** support variable interpolation. However, you can provide partial backend configuration via files and merge them during `terraform init` using the `-backend-config=PATH` option.

**Directory structure example:**

```
|--- main.tf
|--- modules
|--- state_configuration
|   |--- dev_local.hcl
|   |--- test_local.hcl
|--- state_data
|--- terraform.tf
|--- variables.tf
```

**dev_local.hcl**
```hcl
path = "state_data/terraform.dev.tfstate"
```

**test_local.hcl**
```hcl
path = "state_data/terraform.test.tfstate"
```

**Initialize for development:**
```sh
terraform init -backend-config="state_configuration/dev_local.hcl" -migrate-state
terraform plan
terraform apply
```

**Initialize for test:**
```sh
terraform init -backend-config="state_configuration/test_local.hcl" -migrate-state
terraform plan
terraform apply
```

---

### Partial Backend Configuration via Command Line

You can specify backend key/value pairs directly:

```sh
terraform init -backend-config="path=state_data/terraform.prod.tfstate" -migrate-state
terraform plan
terraform apply
```

---

### Multiple Partial Backend Configurations

Backend configuration can be split across multiple files. For example, with the S3 backend:

**terraform.tf**
```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state-ghm"
    key    = "dev/aws_infra"
    region = "us-east-1"
  }
}
```

**Partial configuration:**

```hcl
terraform {
  backend "s3" {}
}
```

**dev-s3-state.hcl**
```hcl
bucket = "my-terraform-state-ghm"
key    = "dev/aws_infra"
region = "us-east-1"
```

**Initialize:**
```sh
terraform init -backend-config="state_configuration/dev-s3-state.hcl" -migrate-state
terraform plan
```

**Split configuration:**

- `s3-state-bucket.hcl`
  ```hcl
  bucket = "my-terraform-state-ghm"
  region = "us-east-1"
  ```
- `dev-s3-state-key.hcl`
  ```hcl
  key = "dev/aws_infra"
  ```

**Initialize with multiple files:**
```sh
terraform init \
  -backend-config="state_configuration/s3-state-bucket.hcl" \
  -backend-config="state_configuration/dev-s3-state-key.hcl" \
  -migrate-state
terraform plan
terraform apply
```

---

### Partial Backend Configuration via CLI Prompt

If a required backend value is missing, Terraform will prompt for it interactively during `terraform init` (unless interactive input is disabled).
**Example: Prompting for missing backend values**

If you run:

```sh
terraform init -backend-config="state_configuration/s3-state-bucket.hcl" \
  -migrate-state
```

Terraform will prompt interactively for the missing `key` value required by the S3 backend.

---

### Backend Configuration from Multiple Locations

When backend settings are provided in multiple locations, Terraform merges them in the following order:

1. Main configuration file (`terraform.tf`)
2. Command-line options (`-backend-config`)
3. Later command-line options override earlier ones

**Example:**

Update your `terraform.tf` to supply all S3 backend information:

```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state-ghm"
    key    = "dev/aws_infra"
    region = "us-east-1"
  }
}
```

Create a partial configuration file `state_configuration/prod-s3-state-key.hcl`:

```hcl
key = "prod/aws_infra"
```

Initialize with multiple backend config files:

```sh
terraform init \
  -backend-config=state_configuration/s3-state-bucket.hcl \
  -backend-config=state_configuration/prod-s3-state-key.hcl \
  -migrate-state
```

In this example, the `key` value from `prod-s3-state-key.hcl` will override the one in `terraform.tf`, resulting in the state being stored at `prod/aws_infra`.