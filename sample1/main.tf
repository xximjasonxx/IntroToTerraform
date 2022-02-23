
// get a reference to an existing resource group (data source)
resource azurerm_resource_group rg {
  name      = "rg-terraform-sample1"
  location  = "eastus"
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