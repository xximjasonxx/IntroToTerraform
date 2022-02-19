
// create the identity
resource azurerm_user_assigned_identity identity {
  name                = "id-${var.app_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

// create role assignments
resource azurerm_role_assignment role_assignments {
  for_each              = var.role_assignments
  scope                 = each.value["resource_id"]
  role_definition_name  = each.value["role_definition_name"]
  principal_id          = azurerm_user_assigned_identity.identity.principal_id
}