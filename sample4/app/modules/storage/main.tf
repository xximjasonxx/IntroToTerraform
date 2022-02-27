
locals {
  storage_account_raw_name = "stg${var.app_name}${var.environment}"
}

resource azurerm_storage_account storage_account {
  name                      = substr(local.storage_account_raw_name, 0, 24)
  location                  = var.location
  resource_group_name       = var.resource_group_name
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = var.account_kind
  access_tier               = "Hot"
  enable_https_traffic_only = true
  allow_blob_public_access  = false
}

// create containers
resource azurerm_storage_container containers {
  for_each        = var.containers
  name                  = each.value
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}