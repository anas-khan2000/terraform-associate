This Lab focuses on validation terraform configuration using terraform validate-
1. Run terraform validate to validate configuration files, it verifies whether a condition is syntactically valid and internally consistent.
2. Make changes to main.tf that is not valid and rerun a validate to see if the syntax error is picked up,ex:
    Add region inside vpc section and run terraform validate -> it will return error
3. In some cases terraform validate reports successful but our plan/apply may still fail because it only checks whether configuration is syntactically valid and internally consistent
    ex: inside loca_file resource give a path that doesn't exist -> it will still return configuration valid but on applying it will give error
4. To produce output of terraform validate n JSON format-
    terraform validate -json