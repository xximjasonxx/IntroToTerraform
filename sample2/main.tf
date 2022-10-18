
// create a resource group
data azurerm_resource_group rg {
  name      = var.resource_group_name
}

module app {
  source = "./modules/app-service"

  app_name    = var.app_name
  location    = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  plan_size = "B1"
  container_image_name = "DOCKER|nginx"
}