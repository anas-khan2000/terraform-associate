1. Till now we have been working on workspace called default, to check -
    terraform workspace show  - to check the workspace currently being used
2. To Create a new workspace - 
    terraform workspace new development
3. This workspace will act as a new environment and we can deploy all the resources in a new region or location 4-
    change region to a different location on main.tf
4. run terraform plan and apply to create resources in new region
5. Introduce new default tag as Environment = terraform.workspace 