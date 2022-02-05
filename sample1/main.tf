
// get a reference to an existing resource group (data source)
data azurerm_resource_group rg {
  name      = "rg-terraform"
}

// deploy a resource (storage account w/ container)
resource azurerm_storage_account storage {
  name                      = "stterraformsample01"
  resource_group_name       = data.azurerm_resource_group.rg.name
  location                  = data.azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
}

resource azurerm_storage_container images {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}