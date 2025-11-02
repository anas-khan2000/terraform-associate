1. added new instance named web_server resource on main.tf with necessary dependencies like security groups.
2. tainted the newly created web_server to mark the server for recreation on next terraform apply.
3. make mistaked like adding "exit 2" on remote provisioner to make the web_server marked tainted by terraform itself
4. Remove the above changes and use terraform untaint command to untaint the instance
5. Use the command terraform apply -replace to recreate the instance as terraform taint is deprecated.

