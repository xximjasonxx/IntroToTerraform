
resource random_string suffix {
  length  = 5
  upper   = false
  lower   = true
  number  = true
  special = false
}

resource azurerm_storage_account storage {
  name                      = "st${var.department_code}${var.number_code}${random_string.suffix.result}"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  account_tier              = "Standard"
  account_replication_type  = "LRS"
}

resource azurerm_storage_container containers {
  for_each              = var.containers
    name                  = each.key
    storage_account_name  = azurerm_storage_account.storage.name
    container_access_type = "private"
}

resource azurerm_role_assignment assignments {
  for_each              = var.containers
    scope                = "${azurerm_storage_account.storage.id}/blobServices/default/containers/${each.key}"
    role_definition_name = each.value["role_name"]
    principal_id         = each.value["principal_id"]
}