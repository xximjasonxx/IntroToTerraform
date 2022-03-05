
output storage_account_name {
  value     = azurerm_storage_account.storage.name
}

output storage_account_resource_id {
  value     = azurerm_storage_account.storage.id
}

output storage_account_blob_endpoint {
  value     = azurerm_storage_account.storage.primary_blob_endpoint
}