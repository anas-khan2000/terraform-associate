## Terraform State Backend Storage

Terraform uses a backend to store its state file, which keeps track of resources managed by your configuration. Using a remote backend improves collaboration, security, and reliability.

### S3 Backend with DynamoDB

For this lab, we use Amazon S3 as the backend to store the Terraform state file, and DynamoDB for state locking and consistency. This setup is a common standard for production environments.

- **S3 Bucket**: The bucket was pre-created and configured as the backend in the Terraform configuration.
- **Initial State**: Running `terraform state list` confirmed that no resources were managed at the start.
- **Versioning**: We enabled versioning on the S3 bucket via the AWS Console UI. After running `terraform apply`, we verified that new versions of the state file were created in the bucket. This allows for state recovery and auditing.
- **Encryption**: We then enabled encryption on the S3 bucket using the AWS Console UI to ensure the state file is stored securely.
- **DynamoDB Table**: Next, we created a DynamoDB table named `terraform-locks` with `LockID` as the partition key. We updated the Terraform configuration to reference this table for state locking.
- **Testing State Locking**: After making minor changes to the tags in one of the instance resources, we ran `terraform apply` to test state locking. We verified the lock status in the DynamoDB `terraform-locks` table using the AWS Console UI.
### HTTP Backend

Terraform also supports an HTTP backend, which stores the state file at a specified HTTP endpoint. This backend is useful for custom or self-hosted solutions but requires additional setup for authentication and locking.

---

#### Setting Up a Local HTTP Backend

For demonstration, we first created a local HTTP server using Python. This involved:

- Creating a new directory named `webserver`.
- Copying code from [this GitHub repository](https://github.com/mikalstill/junkcode/tree/master/terraform/remote_state) into the `webserver` directory.

We then configured the Terraform backend as follows:

```hcl
backend "http" {
    address        = "http://localhost:5001/terraform_state/my_state"
    lock_address   = "http://localhost:5001/terraform_lock/my_state"
    lock_method    = "PUT"
    unlock_address = "http://localhost:5001/terraform_lock/my_state"
    unlock_method  = "DELETE"
}
```

After updating the backend configuration, we ran:

- `terraform init -reconfigure` to reinitialize the backend.
- `terraform apply` to apply the configuration.

This setup created a `.statesetver` directory inside `webserver`, which contains the state file. Finally, we ran `terraform destroy` to clean up the managed resources.

Using remote backends like S3 with DynamoDB or HTTP ensures your Terraform state is secure, consistent, and accessible for team collaboration.