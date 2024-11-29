terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.12.0"
    }
  }
}

provider "azurerm" {
    features {

    }
    subscription_id = "35608c6f-b658-452d-be80-131b03c3b89a"
}

resource "azurerm_resource_group" "name" {
    name     = "example-resources"
    location = "West Europe"
}