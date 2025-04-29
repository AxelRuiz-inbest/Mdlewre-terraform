resource "azurerm_application_insights" "insights_functions_2" {
  name                = "appinsig-func-nadro-lot-prod-001"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.logs.id
  
  tags = {
    Proyecto     = var.tag_Proyecto
    Ambiente     = var.tag_Ambiente
    Owner-iNBest = var.tag_Owner-iNBest
    Cliente      = var.tag_Cliente
    Contacto     = var.tag_Contacto
    ID-Proyecto  = var.tag_ID-Proyecto
  }
}

resource "azurerm_windows_function_app" "net_function_2" {
  name                       = "net-nadro-lot-prod-002"
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
    APPINSIGHTS_INSTRUMENTATIONKEY      = azurerm_application_insights.insights_functions_2.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.insights_functions_2.connection_string
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


resource "azurerm_windows_function_app" "net_function_3" {
  name                       = "net-nadro-lot-prod-003"
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
    APPINSIGHTS_INSTRUMENTATIONKEY      = azurerm_application_insights.insights_functions_2.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.insights_functions_2.connection_string
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
