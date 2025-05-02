resource "azurerm_service_plan" "function_plan_main" {
  name                = var.name_plan_app_fun_premium2
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  os_type             = "Windows"
  sku_name            = "EP2"
}

resource "azurerm_application_insights" "insights_functions_2" {
  name                = var.name_app_insig_fun_2
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

resource "azurerm_windows_function_app" "net_function_2" {
  name                       = var.name_app_funt_2
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  service_plan_id            = azurerm_service_plan.function_plan_main.id
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
    APPINSIGHTS_INSTRUMENTATIONKEY      = azurerm_application_insights.insights_functions_2.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.insights_functions_2.connection_string
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.insights_functions_2.connection_string
  }

  depends_on = [
    azurerm_service_plan.function_plan_main,
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

resource "azurerm_application_insights" "insights_functions_3" {
  name                = var.name_app_insig_fun_3
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

resource "azurerm_windows_function_app" "net_function_3" {
  name                       = var.name_app_funt_3
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  service_plan_id            = azurerm_service_plan.function_plan_main.id
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
    APPINSIGHTS_INSTRUMENTATIONKEY      = azurerm_application_insights.insights_functions_3.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.insights_functions_3.connection_string
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.insights_functions_3.connection_string
  }

  depends_on = [
    azurerm_service_plan.function_plan_main,
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

resource "azurerm_application_insights" "insights_functions_4" {
  name                = var.name_app_insig_fun_4
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

resource "azurerm_windows_function_app" "net_function_4" {
  name                       = var.name_app_funt_4
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  service_plan_id            = azurerm_service_plan.function_plan_main.id
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
    APPINSIGHTS_INSTRUMENTATIONKEY      = azurerm_application_insights.insights_functions_4.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.insights_functions_4.connection_string
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.insights_functions_4.connection_string
  }

  depends_on = [
    azurerm_service_plan.function_plan_main,
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

resource "azurerm_log_analytics_workspace" "logs_func" {
  name                = var.name_logs_func
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