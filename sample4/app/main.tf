
resource azurerm_resource_group rg {
  name      = "rg-${var.app_name}-${var.environment}"
  location  = var.location
}

// reference the container registry
data azurerm_container_registry acr {
  name                = var.registry_name
  resource_group_name = var.registry_resource_group
}

// create the storage account
module storage {
  source   = "./modules/storage"

  app_name            = var.app_name
  environment         = var.environment
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  account_kind        = "BlobStorage"
  containers          = [ "images" ]
}

// create the identity
module identity {
  source   = "./modules/identity"

  app_name            = var.app_name
  environment         = var.environment
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  role_assignments    = {
    "imagesContrib" = {
      role_definition_name = "Storage Blob Data Contributor"
      resource_id          = module.storage.containers["images"]
    }
    "acrPull" = {
      role_definition_name = "AcrPull"
      resource_id          = data.azurerm_container_registry.acr.id
    }
    "saReader" = {
      role_definition_name = "Reader"
      resource_id          = module.storage.storage_account_resource_id
    }
   }
}

// create the app service
module app_service {
  source    = "./modules/appservice"

  app_name                  = var.app_name
  environment               = var.environment
  location                  = var.location
  resource_group_name       = azurerm_resource_group.rg.name
  plan_kind                 = "Linux"
  plan_tier                 = var.environment == "p" ? "Standard" : "Basic"
  plan_size                 = var.environment == "p" ? "S1" : "B1"
  user_managed_identity_id  = module.identity.identity_resource_id
  docker_image              = "${data.azurerm_container_registry.acr.login_server}/fileupload:v1"
}