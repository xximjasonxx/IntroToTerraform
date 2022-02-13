
terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "=2.91.0"
    }
  }

  backend "azurerm"    {
    storage_account_name    = "stgtfstatejx01"
    container_name          = "tfstate"
    subscription_id         = "cd35503e-9e28-4b2b-8445-45fc816ba088"
    tenant_id               = "e15b8f94-b657-4f98-a1f2-9df013c37c73"
  }
}