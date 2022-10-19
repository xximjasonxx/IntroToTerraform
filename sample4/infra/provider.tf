terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.97.0"
    }
  }

  backend "azurerm"    {
    storage_account_name    = "stgtfstatejx01"
    container_name          = "tfstate"
    subscription_id         = "cd35503e-9e28-4b2b-8445-45fc816ba088"
    tenant_id               = "e15b8f94-b657-4f98-a1f2-9df013c37c73"
    key                     = "sample4.tfstate"
  }
  
}

provider "azurerm" {
  features {}

  use_msi         = true
  client_id       = "23f3ad76-c3d9-4e14-9c67-8229519fc287"
  client_secret   = var.client_secret
  subscription_id = "cd35503e-9e28-4b2b-8445-45fc816ba088"
  tenant_id       = "e15b8f94-b657-4f98-a1f2-9df013c37c73"
}