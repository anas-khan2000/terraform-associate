## Terraform State Locking and `terraform apply`

### State Locking Overview

Terraform uses a state file to keep track of the resources it manages. To prevent multiple users or processes from making concurrent changes to the same infrastructure, Terraform implements a mechanism called **state locking**. This ensures that only one operation can modify the state at a time, reducing the risk of state corruption.

### How State Locking Works

- When you run `terraform apply`, Terraform attempts to acquire a lock on the state file.
- If the lock is acquired, Terraform proceeds with the operation.
- If another process is already holding the lock (for example, someone else is running `terraform apply` at the same time), Terraform will display an error and will not proceed until the lock is released.

### Error Example

If you try to run `terraform apply` while the state is locked, you may see an error like:
```
Error: Error acquiring the state lock

Error locking state: Error acquiring the state lock: state lock already held
```

### Using `-lock-timeout` Option

If you expect the lock to be released soon, you can use the `-lock-timeout` flag with `terraform apply` to tell Terraform how long to wait for the lock before failing. For example:

```
terraform apply -lock-timeout=60s
```

This command will make Terraform wait up to 60 seconds to acquire the state lock before giving up.
