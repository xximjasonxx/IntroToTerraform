
data azurerm_resource_group rg {
  name      = var.resource_group_name
}

module "storage-account" {
  source  = "app.terraform.io/Farrellsoft/storage-account/azure"
  version = "1.0.3"
  
  resource_group_name = data.azurerm_resource_group.rg.name
  storage_account_name = "sttfsandboxym01"
  containers = [
    "images",
    "documents",
    "profiles"
  ]
}