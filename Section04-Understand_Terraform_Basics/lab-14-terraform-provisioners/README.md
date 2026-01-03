1. Added aws key pair resource to create aws key from the private key we created earlier
2. Added security group to enable ssh and http/https connectivity.
3. Updated ec2 configuration to add the key and updated security group configuration and also added connection block which tells terraform how to connect to this EC2 server.
4. Updated ec2 conf to add local-exec provisioner to update permissions of the private key on the workstation(not on the resource).
5. Updated ec2 conft to add remote-exec provisioner to add series of command which will clone a git repo and start a web server once ec2 is created.