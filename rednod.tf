resource "azurerm_service_plan" "planappnodered" {
  name                = var.name_plan_app_service
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "S2"
}

resource "azurerm_linux_web_app" "appnodered" {
  name                = var.name_app_service_1
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.planappnodered.id
  virtual_network_subnet_id = azurerm_subnet.subnet_fun.id
  
  site_config {
      application_stack {
      node_version = "22-lts"
      }
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