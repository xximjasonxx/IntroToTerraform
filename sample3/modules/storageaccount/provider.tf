terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.97.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "67a9ab59-779c-451d-81f7-c7aa294c2102"
  tenant_id       = "e15b8f94-b657-4f98-a1f2-9df013c37c73"
}