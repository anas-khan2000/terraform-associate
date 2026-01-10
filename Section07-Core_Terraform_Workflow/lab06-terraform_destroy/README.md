In this lab we focus on destroying unwanted resources using terraform destroy commands and the various alternatives.
1. To destroy our infra run terraform destroy, it will not delete configuration files only destroys the resources built by our terraform code.
2. Running terraform destroy will ask for our approval before deleting the infra.
3. To automatically delete the infra we can run terraform destroy -auto-approve.
4. Alternate to terraform destroy we can also run terraform apply -destroy, which will again requires manual approval.