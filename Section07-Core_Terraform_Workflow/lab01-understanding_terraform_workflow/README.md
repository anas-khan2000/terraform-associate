This lab covers what we previously saw, understanding terraform workflow-
The core Terraform workflow has three steps:

Write - Author infrastructure as code.
Plan - Preview changes before applying.
Apply - Provision reproducible infrastructure.

1. Verify terraform installation - terraform -version
2. run terraform -help to recall a specific command
3. On main.tf write a small code using random_string resource of length 16.
4. initialize using terraform init
5. run terraform plan to preview the changes which terraform will perform.
6. run terraform plan -out myplan which will create a plan file.
7. run terraform apply to build the resource.
8. run terraform plan -destroy to run a planned destroy.
9. to destroy resources managed by terraform run terraform destroy.