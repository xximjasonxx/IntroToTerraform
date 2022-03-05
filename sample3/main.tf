
locals {
  location = "eastus"
}

resource azurerm_resource_group rg {
  name     = "rg-sample3"
  location = local.location
}

resource azurerm_user_assigned_identity identity {
  name                = "id-sample3"
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
}

module storage_account {
  source        = "./modules/storageaccount"

  resource_group_name           = "rg-storage"
  location                      = local.location
  department_code               = "t11"
  containers                    = {
    "images" = {
      principal_id          = azurerm_user_assigned_identity.identity.principal_id
      role_name             = "Storage Blob Data Contributor"
    }
    "documents" = {
      principal_id          = azurerm_user_assigned_identity.identity.principal_id
      role_name             = "Storage Blob Data Reader"
    }
  }
}

module appservice {
  source        = "./modules/appservice"

  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
  service_name        = "appservice-sample3"
  identity_id         = azurerm_user_assigned_identity.identity.id
  app_settings        = [
    {
      name  = "StorageAccountUrl"
      value = module.storage_account.storage_account_blob_endpoint
    },
    {
      name  = "ImagesContainerName"
      value = "images"
    },
    {
      name  = "DocumentsContainerName"
      value = "documents"
    }
  ]

  depends_on = [
    azurerm_user_assigned_identity.identity
  ]
}