
resource azurerm_app_service_plan plan {
  name                = "plan-${var.app_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "Linux"
  reserved            = true

  sku {
    tier              = var.plan_size == "B1" ? "Basic" : "Standard"
    size              = var.plan_size
  }
}

resource azurerm_app_service app {
  name                = "app-${var.app_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    always_on         = true
    linux_fx_version = var.container_image_name
  }
}