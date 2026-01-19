# Lab: Secure Secrets in Terraform Code

When working with Terraform, handling sensitive values securely is crucial. This lab demonstrates common techniques to manage secrets safely.

## Task 1: Do Not Store Secrets in Plain Text

- **Never store secrets** (like passwords or tokens) directly in `.tf` files or source control.
- Risks include unauthorized access, lack of auditability, and inability to revoke secrets.

## Task 2: Mark Variables as Sensitive

- Use the `sensitive = true` attribute in variable definitions to prevent Terraform from displaying values in CLI output.
- Example:
    ```hcl
    variable "phone_number" {
        type      = string
        sensitive = true
        default   = "867-5309"
    }

    output "phone_number" {
        value     = var.phone_number
        sensitive = true
    }
    ```
- Note: Sensitive values still appear in the Terraform state file.

## Task 3: Environment Variables

- Remove default values from sensitive variables and set them via environment variables:
    ```hcl
    variable "phone_number" {
        type      = string
        sensitive = true
    }
    ```
    ```sh
    export TF_VAR_phone_number="867-5309"
    ```
- This keeps secrets out of code and version control.

## Task 4: Secret Stores (e.g., HashiCorp Vault)

- Store secrets in a dedicated secrets manager like Vault.
- Example workflow:
    1. Install and start Vault in dev mode.
        ```sh
        vault server -dev
        ```

    2. Set `VAULT_ADDR` and log in with the root token.
        ```sh
        export VAULT_ADDR="http://127.0.0.1:8200"
        ```

    3. Store a secret:
         ```sh
         vault kv put /secret/app phone_number=867-5309
         ```
    4. Configure Terraform to use Vault:
         ```hcl
         provider "vault" {
             address = "http://127.0.0.1:8200"
             token   = "<root token>"
         }

         data "vault_generic_secret" "phone_number" {
             path = "secret/app"
         }

         output "phone_number" {
             value     = data.vault_generic_secret.phone_number.data["phone_number"]
             sensitive = true
         }
         ```
- Use `terraform output phone_number` to retrieve the value securely.

**Note:** Never use root tokens in production. Use proper authentication methods like AppRole.
