
resource azurerm_resource_group rg {
    name        = "rg-terraform-test"
    location    = "eastus"
}

resource azurerm_app_service_plan plan {
  name                = "plan-crossappjx01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource azurerm_app_service app {
  name                = "app-crossappjx01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    linux_fx_version    = "DONTNET|6.0"
  }

  app_settings = {
    "BucketName" = var.bucket_name
  }
}