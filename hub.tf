resource "azurerm_service_plan" "function_plan_hub" {
  name                = "serviceplan-nadro-lot-prod-001"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  os_type             = "windows"
  sku_name            = "EP2"
}

resource "azurerm_storage_account" "function_storage_hub" {
  name                     = "stge1nadro1lot1prod1001"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  identity {
    type = "SystemAssigned"
  }
  tags = {
    Proyecto = var.tag_Proyecto
    Ambiente = var.tag_Ambiente
    Owner-iNBest = var.tag_Owner-iNBest
    Cliente = var.tag_Cliente
    Contacto = var.tag_Contacto
    ID-Proyecto = var.tag_ID-Proyecto
  }
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_servicebus_namespace" "servicebus" {
  name                = "sb-nadro-lot-prod-001"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Premium"
  capacity            = 1 
  premium_messaging_partitions = 1

  tags = {
    Proyecto      = var.tag_Proyecto
    Ambiente      = var.tag_Ambiente
    Owner-iNBest  = var.tag_Owner-iNBest
    Cliente       = var.tag_Cliente
    Contacto      = var.tag_Contacto
    ID-Proyecto   = var.tag_ID-Proyecto
  }
}
resource "azurerm_monitor_diagnostic_setting" "diag_webpubsub" {
  name                       = "diag-wps-nadro-lot-prod-001"
  target_resource_id         = azurerm_web_pubsub.webpubsub-hub.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id

  enabled_log {
    category = "ConnectivityLogs"
  }

  enabled_log {
    category = "MessagingLogs"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
resource "azurerm_monitor_diagnostic_setting" "diag_servicebus" {
  name                       = "diag-sbus-nadro-lot-prod-001"
  target_resource_id         = azurerm_servicebus_namespace.servicebus.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id

  enabled_log {
    category = "OperationalLogs"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_windows_function_app" "net_function_1" {
  name                       = "net-nadro-lot-prod-001"
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  service_plan_id            = azurerm_service_plan.function_plan_hub.id
  storage_account_name       = azurerm_storage_account.function_storage_hub.name
  storage_account_access_key = azurerm_storage_account.function_storage_hub.primary_access_key

  site_config {
    application_stack {
      dotnet_version = "v8.0"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  https_only = true

  app_settings = {
    "AzureWebJobsStorage"          = azurerm_storage_account.function_storage_hub.primary_connection_string
    "FUNCTIONS_WORKER_RUNTIME"     = "dotnet-isolated"
    "WEB_PUBSUB_CONNECTION_STRING" = azurerm_web_pubsub.webpubsub-hub.primary_connection_string
    "SERVICEBUS_CONNECTION"        = azurerm_servicebus_namespace.servicebus.default_primary_connection_string
    "DESTINATION_APP_URL"          = "https://appservicioexterno.com/api/endpoint"
  }

  depends_on = [
    azurerm_service_plan.function_plan_hub,
    azurerm_storage_account.function_storage_hub
  ]
  tags = {
    Proyecto = var.tag_Proyecto
    Ambiente = var.tag_Ambiente
    Owner-iNBest = var.tag_Owner-iNBest
    Cliente = var.tag_Cliente
    Contacto = var.tag_Contacto
    ID-Proyecto = var.tag_ID-Proyecto
  }
}

resource "azurerm_monitor_diagnostic_setting" "diag_function" {
  name                       = "diag-netfun-nadro-lot-prod-001"
  target_resource_id         = azurerm_windows_function_app.net_function_1.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id

  enabled_log {
    category = "FunctionAppLogs"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_log_analytics_workspace" "logs" {
  name                = "log-pruebas-1"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    Proyecto     = var.tag_Proyecto
    Ambiente     = var.tag_Ambiente
    Owner-iNBest = var.tag_Owner-iNBest
    Cliente      = var.tag_Cliente
    Contacto     = var.tag_Contacto
    ID-Proyecto  = var.tag_ID-Proyecto
  }
}

resource "azurerm_role_assignment" "webpubsub_sender" {
  scope                = azurerm_web_pubsub.webpubsub-hub.id
  role_definition_name = "SignalR/Web PubSub Contributor"
  principal_id         = azurerm_windows_function_app.net_function_1.identity[0].principal_id
}
resource "azurerm_role_assignment" "servicebus_sender" {
  scope                = azurerm_servicebus_namespace.servicebus.id
  role_definition_name = "Azure Service Bus Data Sender"
  principal_id         = azurerm_windows_function_app.net_function_1.identity[0].principal_id
}
resource "azurerm_web_pubsub" "webpubsub-hub" {
  name                = "tfex-webpubsub-hub"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  sku      = "Standard_S1"
  capacity = 1

  public_network_access_enabled = false

  live_trace {
    enabled                   = true
    messaging_logs_enabled    = true
    connectivity_logs_enabled = false
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Proyecto = var.tag_Proyecto
    Ambiente = var.tag_Ambiente
    Owner-iNBest = var.tag_Owner-iNBest
    Cliente = var.tag_Cliente
    Contacto = var.tag_Contacto
    ID-Proyecto = var.tag_ID-Proyecto
  }
}
