1. terraform workspace show  - to check the workspace currently being used
2. Create a new workspace using - terraform workspace new development
3. change region to a different location
4. run terraform plan and apply to create resources in new region
5. Introduce new default tag as Environment = terraform.workspace 