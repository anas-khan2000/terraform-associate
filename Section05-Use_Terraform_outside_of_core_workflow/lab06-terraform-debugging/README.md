1. enable logging using : export TF_LOG=TRACE
2. Run terraform plan to see the detailed output
3. Enable logging path to force the log to always be appended to a specific file when logging is enabled using: export TF_LOG_PATH="terraform_log.txt"
4. Run terraform plan again which will create terraform_log.txt and stored all the logs
5. To disable loggin : export TF_LOG=""