provider "azurerm" {
  resource_provider_registrations = "none"
  subscription_id = var.subscription_id
  features {}
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnetprod" {
  name = var.vnetprod
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "subnetdb" {
  name                 = var.subnetdb
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnetprod.name
}

data "azurerm_subnet" "subnetenp" {
  name                 = var.subnetdb
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnetprod.name
}

data "azurerm_subnet" "subnetfunc" {
  name                 = var.subnetdb
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnetprod.name
}
data "azurerm_subnet" "subnetapp" {
  name                 = var.subnetdb
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnetprod.name
}
/*
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}
*/
