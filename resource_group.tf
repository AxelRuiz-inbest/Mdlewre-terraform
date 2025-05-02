provider "azurerm" {
  resource_provider_registrations = "none"
  subscription_id = var.subscription_id
  features {}
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}
