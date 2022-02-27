
// create a resource group
resource azurerm_resource_group rg {
  name      = "rg-${var.departmentCode}-sample${var.numberCode}"
  location  = var.location
}

// create the app service (host nginx)
resource azurerm_app_service_plan plan {
  name                = "plan-${var.departmentCode}-sample${var.numberCode}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier              = var.planSize == "B1" ? "Basic" : "Standard"
    size              = var.planSize
  }
}

resource azurerm_app_service app {
  name                = "app-${var.departmentCode}-sample${var.numberCode}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    always_on         = true
    linux_fx_version  = "DOCKER|nginx"
  }
}