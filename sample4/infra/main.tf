
data azurerm_resource_group rg {
  name = var.resource_group_name
}

resource azurerm_static_site swa {
  name                = "swa-reactapp-jm01"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = "eastus2"
  sku_tier            = "Standard"
  sku_size            = "Standard"
}