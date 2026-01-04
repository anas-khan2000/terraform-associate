1. Updated server module into 3 parts(best practice) - 
    a. variables.tf -> which contains all the variables(inputs).
    b. main.tf -> which contains resource configuration.
    c. outputs.tf -> which contains all outputs(return) values.
2. Update variables.tf file to comment default value under size so that size becomes a required value wherever the module being referenced.
    Run terraform validate to confirm error : The argument "size" is required.
    Update root main.tf file server module section to include size argument in order to fix this.
3. Updated server module outputs.tf file to return instance type and updated root main.tf to call this output.