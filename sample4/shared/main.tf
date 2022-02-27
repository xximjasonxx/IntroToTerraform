
resource azurerm_resource_group rg {
  name      = "rg-shared"
  location  = var.location
}

// create the container registry
resource azurerm_container_registry acr {
  name                = "acrsharedjx01"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Basic"
  admin_enabled       = false
}
