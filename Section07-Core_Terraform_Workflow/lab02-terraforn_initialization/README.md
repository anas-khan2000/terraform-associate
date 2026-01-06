This lab mainly focuses on initializing terraform with terrafrom init and the various cases where we need to rerun terraform init
1. To initialize a new working directory we must run terraform init.
    Inside main.tf add resource block of random provider and run terraform init.
    Once it is successfully initialized a new directory is created named .terraform/ where the providers are downloaded
2. Introduce new providers under terrafrom.tf and again run terraform init to reinitialize.
    All the providers are now downloaded and can be verified using terraform version/terraform provider
3. Introduce a module block on main.tf and again initialize the same using terraform init inorder to use it.
    Inside main.tf add s3 bucker module block and run terraform init.
    Once terraform init is successfully completed we can under .terraform directory a new modules folder is created where all the modules are downloaded.
4. To update the versions of providers or to update all modules to latest available source code run terraform init -upgrade
5. During init, the root configuration directory is consulted for backend configuration and by default terraform choses a local backend and saves its state file to a terraform.    tfstate file located in the working directory.
If we update the default backend to move terraform state file to a different directory we need to run init again.
    Inside terraform.tf add a backed block for a new state file location and rerun terraform init.
    If the state file is not empty then after running the command we will be prompted to copy the existing state to new backend, entering yes will will automatically copy the state information from the default location to your new directory during the re-initialization process.