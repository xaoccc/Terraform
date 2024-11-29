# Terraform
`terraform fmt` - format the code in the .tf file  
`terraform validate` - verify if the code is valid. Usually done before `terraform init`  
`terraform init` - initializes a working directory containing Terraform configuration files  
`terraform plan` - create an execution plan, which shows you what changes Terraform will make to your infrastructure based on the current configuration and the existing state  
`terraform apply` - apply all in the .tf file - create resourses, deploy, etc...applies the changes required to reach the desired state of the configuration. It will create, update, or delete resources based on the plan  
`terraform destroy` - deletes all the resources and configurations  

azurerm_app_service_source_control - resource for deploy from github! Mucho importante!