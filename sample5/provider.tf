provider azurerm {
  features {}

  alias           = "dev"
  subscription_id = "cd35503e-9e28-4b2b-8445-45fc816ba088"
  tenant_id       = "e15b8f94-b657-4f98-a1f2-9df013c37c73"
}

provider azurerm {
  features {
    key_vault {
        purge_soft_delete_on_destroy = true
    }
  }

  alias           = "test"
  subscription_id = "67a9ab59-779c-451d-81f7-c7aa294c2102"
  tenant_id       = "e15b8f94-b657-4f98-a1f2-9df013c37c73"
}

provider "azuread" {
  tenant_id       = "e15b8f94-b657-4f98-a1f2-9df013c37c73"
}