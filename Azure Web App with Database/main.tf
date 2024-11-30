terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.12.0"
    }
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = "35608c6f-b658-452d-be80-131b03c3b89a"
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_resource_group" "arg" {
  name     = "TaskBoardApp-arg-${random_integer.ri.result}"
  location = "West Europe"
}

resource "azurerm_service_plan" "aasp" {
  name                = "TaskBoardApp-aasp-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_resource_group.arg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "alwa" {
  name                = "TaskBoardApp-alwa-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_service_plan.aasp.location
  service_plan_id     = azurerm_service_plan.aasp.id

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
    always_on = false
  }

  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = "Data Source=tcp:${azurerm_mssql_server.mssqlserver.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.mssqldatabase.name};User ID=${azurerm_mssql_server.mssqlserver.administrator_login};Password=${azurerm_mssql_server.mssqlserver.administrator_login_password};Trusted_Connection=False; MultipleActiveResultSets=True;"
  }
}

resource "azurerm_mssql_server" "mssqlserver" {
  name                         = "taskboardmssqlserver"
  resource_group_name          = azurerm_resource_group.arg.name
  location                     = azurerm_resource_group.arg.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}


resource "azurerm_mssql_database" "mssqldatabase" {
  name         = "taskboard-db"
  server_id    = azurerm_mssql_server.mssqlserver.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  zone_redundant = true
}

resource "azurerm_app_service_source_control" "example" {
  app_id   = azurerm_linux_web_app.alwa.id
  repo_url = "https://github.com/dimosoftuni/Azure-Web-App-with-Database-TaskBoard"
  branch   = "main"
  #   If the repo is not mine, I need to provide this:
  use_manual_integration = true
}

