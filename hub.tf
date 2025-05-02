# Plan de App Service para Function
resource "azurerm_service_plan" "function_plan_hub" {
  name                = var.name_plan_app_fun_premium1
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  os_type             = "Windows"
  sku_name            = "EP2"
}

# Cuenta de almacenamiento para Function App
resource "azurerm_storage_account" "function_storage_hub" {
  name                     = var.name_storage_appfun
  location                 = data.azurerm_resource_group.rg.location
  resource_group_name      = data.azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  identity {
    type = "SystemAssigned"
  }

  tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}

# Aplicación Azure Function
resource "azurerm_application_insights" "insights_functions_1" {
  name                = var.name_app_insig_service_1
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.logs_func.id
  
  tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}

resource "azurerm_windows_function_app" "net_function_1" {
  name                       = var.name_app_funt_1
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  service_plan_id            = azurerm_service_plan.function_plan_hub.id
  storage_account_name       = azurerm_storage_account.function_storage_hub.name
  storage_account_access_key = azurerm_storage_account.function_storage_hub.primary_access_key
  virtual_network_subnet_id  = azurerm_subnet.subnet_fun.id 

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
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.insights_functions_1.connection_string
  }

  depends_on = [
    azurerm_service_plan.function_plan_hub,
    azurerm_storage_account.function_storage_hub
  ]

  tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}

# Diagnóstico para Function App
resource "azurerm_monitor_diagnostic_setting" "diag_function" {
  name                       = var.name_diag_function
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

resource "azurerm_web_pubsub" "webpubsub-hub" {
  name                = var.name_webpubsub-hub
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
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}

resource "azurerm_monitor_diagnostic_setting" "diag_webpubsub" {
  name                       = var.name_diag_webpubsub
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

/*Rol Asignado Nadro */
/*
resource "azurerm_role_assignment" "webpubsub_sender" {
  scope                = azurerm_web_pubsub.webpubsub-hub.id
  role_definition_name = "SignalR/Web PubSub Contributor"
  principal_id         = azurerm_windows_function_app.net_function_1.identity[0].principal_id
}
*/
resource "azurerm_servicebus_namespace" "servicebus" {
  name                = var.name_service_bus
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Premium"
  capacity            = 1
  premium_messaging_partitions = 1

  tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}

resource "azurerm_servicebus_topic" "servicebus_topic" {
  name         = "tfex_servicebus_topic"
  namespace_id = azurerm_servicebus_namespace.servicebus.id
}

resource "azurerm_servicebus_subscription" "sub1" {
  name               = "plc-to-sap-forwarder"
  topic_id           = azurerm_servicebus_topic.servicebus_topic.id
  max_delivery_count = 1
}

resource "azurerm_servicebus_subscription" "sub2" {
  name               = "sap-to-plc-forwarder"
  topic_id           = azurerm_servicebus_topic.servicebus_topic.id
  max_delivery_count = 1
}

resource "azurerm_monitor_diagnostic_setting" "diag_servicebus" {
  name                       = var.name_diag_servicebus
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

/*Rol Asignado Nadro */
/*
resource "azurerm_role_assignment" "servicebus_sender" {
  scope                = azurerm_servicebus_namespace.servicebus.id
  role_definition_name = "Azure Service Bus Data Sender"
  principal_id         = azurerm_windows_function_app.net_function_1.identity[0].principal_id
}
*/
resource "azurerm_log_analytics_workspace" "logs" {
  name                = var.name_logs_webpubsub
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

