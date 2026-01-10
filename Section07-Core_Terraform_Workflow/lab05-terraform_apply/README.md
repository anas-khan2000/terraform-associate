This lab focuses on terraform apply command which executes changes to infrastructure and the various ways we can use this command.
1. Make an update on main.tf on any of the tags and run terraform apply and then review the execution plan and approve it.
2. Make another update on the tags and run terraform apply -auto-approve which will not ask for approval and directly make the changes.
3. Make another change on the tags and save the plan using terraform plan -out myplan and the apply the changes using the saved plan.