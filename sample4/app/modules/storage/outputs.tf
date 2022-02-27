
output storage_account_name {
  value     = azurerm_storage_account.storage_account.name
}

output storage_account_resource_id {
  value     = azurerm_storage_account.storage_account.id
}

output containers {
  value = {
    for name, container in azurerm_storage_container.containers:
      name => "${azurerm_storage_account.storage_account.id}/blobServices/default/containers/${name}"
  }
}