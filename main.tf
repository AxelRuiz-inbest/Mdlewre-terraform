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
    use_32_bit_worker = false
    ip_restriction_default_action = "Deny"
      ip_restriction {
        name       = "eduardo-office"
        ip_address  = "149.19.169.152/32"
        action     = "Allow"
        priority   = 100
        }
      ip_restriction {
        name       = "axel-office"
        ip_address  = "177.248.19.209/32"
        action     = "Allow"
        priority   = 110
      }
      ip_restriction {
          name       = "VPN-Nadro"
          ip_address  = "201.144.207.82/32"
          action     = "Allow"
          priority   = 120
        }
      ip_restriction {
        virtual_network_subnet_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.name_vnet_1}/subnets/${var.name_subnet_funt}"  
      }
      ip_restriction {
        virtual_network_subnet_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.name_vnet_1}/subnets/${var.name_subnet_en}"  
      }
      ip_restriction {
        virtual_network_subnet_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.name_vnet_1}/subnets/${var.name_subnet_sql}"  
      }
  }

  identity {
    type = "SystemAssigned"
  }

  https_only = true

  app_settings = {
    "AzureWebJobsStorage"          = azurerm_storage_account.function_storage_hub.primary_connection_string
    "FUNCTIONS_WORKER_RUNTIME"     = "dotnet-isolated"
    "DESTINATION_APP_URL"          = "https://appservicioexterno.com/api/endpoint"
    APPINSIGHTS_INSTRUMENTATIONKEY      = azurerm_application_insights.insights_functions_2.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.insights_functions_2.connection_string
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.insights_functions_2.connection_string
    "SERVICEBUS_CONNECTION"       = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.servicebus.id})"
    "SERVICEBUS_TOPIC_NAME"            = "nadro-iot-plc-topic"
    "KEY_VAULT_URL"	                   = "https://keyvault-lot-prod-01.vault.azure.net/"
    SEND_ADDITIONAL_PARAM_TO_SAP	     = true
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
    use_32_bit_worker = false
    ip_restriction_default_action = "Deny"
      ip_restriction {
        name       = "eduardo-office"
        ip_address  = "149.19.169.152/32"
        action     = "Allow"
        priority   = 100
        }
      ip_restriction {
        name       = "axel-office"
        ip_address  = "177.248.19.209/32"
        action     = "Allow"
        priority   = 110
      }
      ip_restriction {
          name       = "VPN-Nadro"
          ip_address  = "201.144.207.82/32"
          action     = "Allow"
          priority   = 120
        }
      ip_restriction {
        virtual_network_subnet_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.name_vnet_1}/subnets/${var.name_subnet_funt}"  
      }
      ip_restriction {
        virtual_network_subnet_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.name_vnet_1}/subnets/${var.name_subnet_en}"  
      }
      ip_restriction {
        virtual_network_subnet_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.name_vnet_1}/subnets/${var.name_subnet_sql}"  
      }
  }

  identity {
    type = "SystemAssigned"
  }

  https_only = true

  app_settings = {
    "AzureWebJobsStorage"          = azurerm_storage_account.function_storage_hub.primary_connection_string
    "FUNCTIONS_WORKER_RUNTIME"     = "dotnet-isolated"
    "DESTINATION_APP_URL"          = "https://appservicioexterno.com/api/endpoint"
    APPINSIGHTS_INSTRUMENTATIONKEY      = azurerm_application_insights.insights_functions_3.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.insights_functions_3.connection_string
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.insights_functions_3.connection_string
    "SERVICEBUS_CONNECTION"       = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.servicebus.id})"
    "SERVICEBUS_TOPIC_NAME"            = "nadro-iot-plc-topic"
    "KEY_VAULT_URL"	                   = "https://keyvault-lot-prod-01.vault.azure.net/"
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
    use_32_bit_worker = false
    ip_restriction_default_action = "Deny"
      ip_restriction {
        name       = "eduardo-office"
        ip_address  = "149.19.169.152/32"
        action     = "Allow"
        priority   = 100
        }
      ip_restriction {
        name       = "axel-office"
        ip_address  = "177.248.19.209/32"
        action     = "Allow"
        priority   = 110
      }
      ip_restriction {
          name       = "VPN-Nadro"
          ip_address  = "201.144.207.82/32"
          action     = "Allow"
          priority   = 120
        }
      ip_restriction {
        virtual_network_subnet_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.name_vnet_1}/subnets/${var.name_subnet_funt}"  
      }
      ip_restriction {
        virtual_network_subnet_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.name_vnet_1}/subnets/${var.name_subnet_en}"  
      }
      ip_restriction {
        virtual_network_subnet_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.name_vnet_1}/subnets/${var.name_subnet_sql}"  
      }
  }

  identity {
    type = "SystemAssigned"
  }

  https_only = true

  app_settings = {
    "AzureWebJobsStorage"          = azurerm_storage_account.function_storage_hub.primary_connection_string
    "FUNCTIONS_WORKER_RUNTIME"     = "dotnet-isolated"
    "DESTINATION_APP_URL"          = "https://appservicioexterno.com/api/endpoint"
    APPINSIGHTS_INSTRUMENTATIONKEY      = azurerm_application_insights.insights_functions_4.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.insights_functions_4.connection_string
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.insights_functions_4.connection_string
    "SERVICEBUS_CONNECTION"       = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.servicebus.id})"
    "DATABASE_NAME"               = "nosqldb-nadro-lot-prod-00"
    "KEY_VAULT_URL"	              = "https://keyvault-lot-prod-01.vault.azure.net/"
    "CONTAINER_NAME"	            = "maincontainer"
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