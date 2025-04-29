resource "azurerm_service_plan" "planappnodered" {
  name                = "plan-nodered-lot-prod-001"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "S2"
}

resource "azurerm_linux_web_app" "appnodered" {
  name                = "appservice-nodered-lot-prod-001"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.planappnodered.id
  
  site_config {
      application_stack {
      node_version = "22-lts"
    }
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


