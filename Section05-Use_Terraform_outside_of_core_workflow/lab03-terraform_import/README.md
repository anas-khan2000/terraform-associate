1. created a instance manually on aws portal
2. created a empty instance resource block on main.tf
3. used terraform import command with newly created instance resource block name with the instance ID we want to import
    ex: terraform import aws_instance.aws_linux i-02b32a9590184bf99
4. after successful import run terraform state list to verify import
5. Run terraform plan to make necessary changes on .tf file if any entries needed on resource block. In our case we needed to add instance_type and ami id which we gathered using terraform state show aws_instance.aws_linux

