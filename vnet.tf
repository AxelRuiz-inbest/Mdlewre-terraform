resource "azurerm_virtual_network" "vnet-functions" {
  name                  = var.name_vnet_1
  resource_group_name   = data.azurerm_resource_group.rg.name
  location              = data.azurerm_resource_group.rg.location
  address_space = [ "172.21.8.0/26" ]

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

resource "azurerm_subnet" "subnet_sql" {
  name                  = var.name_subnet_sql
  address_prefixes      = ["172.21.8.0/28"]
  resource_group_name   = data.azurerm_resource_group.rg.name
  virtual_network_name  = azurerm_virtual_network.vnet-functions.name

  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.Sql",
    "Microsoft.ServiceBus",
    "Microsoft.EventHub"
  ]
}

resource "azurerm_subnet" "subnet_fun" {
  name                  = var.name_subnet_funt
  address_prefixes      = ["172.21.8.16/28"]
  resource_group_name   = data.azurerm_resource_group.rg.name
  virtual_network_name  = azurerm_virtual_network.vnet-functions.name

  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
  
  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.Sql",
    "Microsoft.ServiceBus",
    "Microsoft.EventHub"
  ]

}

resource "azurerm_subnet" "subnet_en" {
  name                  = var.name_subnet_en
  address_prefixes      = ["172.21.8.32/28"]
  resource_group_name   = data.azurerm_resource_group.rg.name
  virtual_network_name  = azurerm_virtual_network.vnet-functions.name
}