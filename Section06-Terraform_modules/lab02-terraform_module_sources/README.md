1. first tested terraform module using source = local by movind existing server directory under modules and creating a new directory under modules as web_server.
2. added instance configuration as server.tf under web_server and referened the module on root main.tf file.
3. Then tested remote module source by referencing aws autoscaling group module from terraform registry.
4. Updated the module to use github instead of terraform registry.