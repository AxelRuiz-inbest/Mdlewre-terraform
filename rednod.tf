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


