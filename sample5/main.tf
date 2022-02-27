
// container registry
resource azurerm_container_registry registry {
    provider            = azurerm.test
    name                = "acrmsitestjx01"
    resource_group_name = azurerm_resource_group.testrg.name
    location            = azurerm_resource_group.testrg.location
    sku                 = "Standard"
    admin_enabled       = false
}

// dev resources
resource azurerm_resource_group devrg {
    provider        = azurerm.dev
    name            = "rg-appservice-dev"
    location        = "eastus"
}

resource azurerm_user_assigned_identity identity {
    provider             = azurerm.dev
    name                 = "identity-appservice-dev"
    resource_group_name  = azurerm_resource_group.devrg.name
    location             = azurerm_resource_group.devrg.location
}

data azuread_service_principal ad-identity {
    application_id    = azurerm_user_assigned_identity.identity.client_id
}

// registry acrpull assignment
resource azurerm_role_assignment acrpull {
    provider             = azurerm.dev
    scope                = azurerm_container_registry.registry.id
    role_definition_name = "AcrPull"
    principal_id         = data.azuread_service_principal.ad-identity.object_id
}

// datasources
data azurerm_client_config current {
    provider = azurerm.test
}

// test resources
resource azurerm_resource_group testrg {
    provider        = azurerm.test
    name            = "rg-keyvault-test"
    location        = "eastus"
}

resource azurerm_key_vault kv {
    provider                    = azurerm.test
    name                        = "keyvault-test-02"
    location                    = azurerm_resource_group.testrg.location
    resource_group_name         = azurerm_resource_group.testrg.name
    tenant_id                   = data.azurerm_client_config.current.tenant_id
    sku_name                    = "standard"
    purge_protection_enabled    = false

    access_policy {
        tenant_id           = data.azurerm_client_config.current.tenant_id
        object_id           = data.azuread_service_principal.ad-identity.object_id
        secret_permissions  = [
            "get",
            "list"
        ]
    }
}