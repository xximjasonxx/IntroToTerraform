
resource azurerm_app_service_plan plan {
  name                = "plan-${var.service_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = var.service_tier
    size = var.service_size
  }
}

resource azurerm_app_service app {
  name                = "app-${var.service_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    linux_fx_version    = "DOCKER|nginx"
  }

  identity {
    type = "UserAssigned"
    identity_ids = [ var.identity_id ]
  }

  app_settings = { for obj in var.app_settings: obj.name => obj.value }
}