provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

// AZURE RESOURCE GROUP
resource "azurerm_resource_group" "rg" {
  name     = var.resourceGroupName
  location = var.location
}

// AZURE CONTAINER REGISTRY
resource "azurerm_container_registry" "acr" {
  name                = var.containerRegistryName
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_virtual_network" "default" {
  name                = "default-vnet"
  address_space       = ["11.0.0.0/23"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes     = ["11.0.0.0/23"]
}

// AZURE CONTAINER ENVIRONMENT
resource "azurerm_container_app_environment" "ace" {
  name                       = var.containerEnvironmentName
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg.name
  infrastructure_subnet_id = azurerm_subnet.default.id

  depends_on = [
    azurerm_resource_group.rg,
    azurerm_subnet.default
  ]  
}