This Lab focuses on terraform plan
1. Run terraform plan to -
    Reading the current state of any already-existing remote objects to make sure that the Terraform state is up-to-date.
    Comparing the current configuration to the prior state and noting any differences.
    Proposing a set of change actions that should, if applied, make the remote objects match the configuration.
    The plan shows you what will happen and the reasons for certain actions (such as re-create).
2. Save plan using terraform plan -out myplan
3. To look at the details of a plan -
    terraform show myplan
4. Use --refresh-only option with terraform plan to update the Terraform state and any root module output values to match changes made to remote objects outside of Terraform.
    This can be useful if you've intentionally changed one or more remote objects outside of the usual workflow (e.g. while responding to an incident) and you now need to reconcile Terraform's records with those changes.
    ex: add a tag directly on a ec2 instance and run terraform plan --refresh-only