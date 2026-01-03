1. This lab is to go through various terraform state command options
2. Run terraform show to render all the .tfstate file contents in more readable format.
3. Run terraform state list to get summary of all the resources within terraform.tfstate file.
4. To look more in depth of a particular resource we can use terraform state show command-
    terraform state show aws_instance.web_server