terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.27.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "cd35503e-9e28-4b2b-8445-45fc816ba088"
  tenant_id       = "e15b8f94-b657-4f98-a1f2-9df013c37c73"
}

locals {
  location = "eastus"
}

resource azurerm_resource_group rg {
  name = "rg-terraform-sandbox"
  location = local.location
}

// deploy a resource (storage account w/ container)
resource azurerm_storage_account storage {
  name                      = "stterraformsample01"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
}

resource azurerm_storage_container images {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}