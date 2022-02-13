
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

// create the app service