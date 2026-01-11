1. Run terraform show to view the applied configuration/resources created.
2. Run terraform state list to list all the resources in Terraform's managed state.
3. By default terraform uses a local backend and saves its state file to a terraform.tfstate file located in the working directory.
4. By default there is no backend configuration block within our configuration. Because no backend was included in our configuration Terraform will use it's default backend - local
   To be explicit about which backend Terraform should use add backend config under terraform configuration block.
5. Terraform automatically creates backup of state file.
6. To validate if the state file is getting updated, add another ec2 instance resource block under main.tf any apply to build the resource.
7. Once successfully build open the tfstate file and search for the instance it should be present, also we cab run terraform state show aws_instance.web_server_2 to check the details of the instance.