terraform {
    # A required_providers block is used to specify the required providers and their constraints. 
    # Currently I am using the Microsoft provider azure.
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.12.0"
    }
  }
}

# Configure the Microsoft Azure Provider. It is necessary to provide the subscription_id so that Terraform can authenticate with Azure.
provider "azurerm" {
  features {

  }
  subscription_id = "35608c6f-b658-452d-be80-131b03c3b89a"
}

# Generate a random integer
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

# Create a resource group with display title "ContactsBook-arg-<random>" and name "arg". The name can be used in other resources.
resource "azurerm_resource_group" "arg" {
  name     = "ContactsBook-arg-${random_integer.ri.result}"
  location = "West Europe"
}

# Create a resource service plan with display title "ContactsBook-aasp-<random>" and name "aasp". 
resource "azurerm_service_plan" "aasp" {
  name                = "ContactsBook-aasp-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_resource_group.arg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

# Create a resource Linux Web App with display title "ContactsBook-alwa-<random>" and name "alwa".
resource "azurerm_linux_web_app" "alwa" {
  name                = "ContactsBook-alwa-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_service_plan.aasp.location
  service_plan_id     = azurerm_service_plan.aasp.id

  site_config {
    application_stack {
      node_version = "16-lts"
    }
    always_on = false
  }
}

# Create a resource "azurerm_app_service_source_control" with the following properties:
resource "azurerm_app_service_source_control" "example" {
  app_id   = azurerm_linux_web_app.alwa.id
  repo_url = "https://github.com/nakov/ContactBook"
  branch   = "master"
  #   If the repo is not mine, I need to provide this:
  use_manual_integration = true
}

