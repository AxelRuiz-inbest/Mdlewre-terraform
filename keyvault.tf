data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "keyvault" {
  name                        = var.key_vult
  location                    = data.azurerm_resource_group.rg.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true
  public_network_access_enabled = true
  enable_rbac_authorization   = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Create",
      "Delete"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete"
    ]

  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
    ip_rules       = ["177.248.19.209/32"]
  }
}

resource "azurerm_key_vault_secret" "servicebus" {
  name         = "ServiceBusConnectionString"
  value        = var.ServiceBusConnectionString
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "webpubsub" {
  name         = "WebPubSubConnectionString"
  value        = var.WebPubSubConnectionString
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "cosmosdb" {
  name         = "CosmosDBConnectionString"
  value        = var.CosmosDBConnectionString
  key_vault_id = azurerm_key_vault.keyvault.id
}