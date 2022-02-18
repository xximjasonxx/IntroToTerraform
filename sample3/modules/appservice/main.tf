
// create the app service plan
resource azurerm_app_service_plan plan {
  name                = "plan-${var.app_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  kind                = var.plan_kind
  reserved            = var.plan_kind == "Linux"

  sku {
    tier    = var.plan_tier
    size    = var.plan_size
  }
}

// look up the managed identity
locals {
  user_identity_parts_array = split("/", var.user_managed_identity_id)
  identity_name             = local.user_identity_parts_array[length(local.user_identity_parts_array) - 1]
  identity_rg_name          = local.user_identity_parts_array[4]
}

data azurerm_user_assigned_identity identity {
  name                = local.identity_name
  resource_group_name = local.identity_rg_name
}

// create the app service
resource azurerm_app_service app {
  name                = "app-${var.app_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  app_service_plan_id = azurerm_app_service_plan.plan.id

  identity {
    type = "UserAssigned"
    identity_ids = [
      var.user_managed_identity_id
    ]
  }

  site_config {
    acr_use_managed_identity_credentials  = true
    acr_user_managed_identity_client_id   = data.azurerm_user_assigned_identity.identity.client_id
    always_on                             = true
    linux_fx_version                      = "DOCKER|${var.docker_image}"
  }

  logs {
    application_logs {
      file_system_level = "Verbose"
    }
  }
}