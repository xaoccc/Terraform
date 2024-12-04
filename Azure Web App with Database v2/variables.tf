variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
}
variable "service_plan_name" {
  description = "The name of the service plan"
  type        = string
}
variable "app_service_name" {
  description = "The name of the app"
  type        = string
}
variable "sql_server_name" {
  description = "The name of the sql server"
  type        = string
}
variable "sql_database_name" {
  description = "The name of the database"
  type        = string
}
variable "sql_username" {
  description = "The name of the sql user"
  type        = string
}
variable "sql_password" {
  description = "The password of the sql user"
  type        = string
}
variable "firewall_rule_name" {
  description = "The rule name for the firewall"
  type        = string
}
variable "github_repo_url" {
  description = "The url of the github repo"
  type        = string
}
