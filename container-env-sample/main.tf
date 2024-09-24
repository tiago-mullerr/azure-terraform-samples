terraform {
  required_providers {
    azapi = {
      source = "azure/azapi"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {

  }
}

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

locals {
  resource_group_name = "${var.environment}"
}

// AZURE SHARED REDIS SERVER
resource "azurerm_redis_cache" "server" {
  name                 = "${var.environment}redis01"
  location             = var.location
  resource_group_name  = local.resource_group_name
  capacity             = 0
  family               = "C"
  sku_name             = "Standard"
  minimum_tls_version  = "1.2"
}

// AZURE CONTAINER ENV CERTIFICATE
resource "azurerm_container_app_environment_certificate" "default" {
  name                         = "${var.environment}-ace-cert"
  container_app_environment_id = azapi_resource.ace.id
  certificate_blob_base64      = var.certificate_base64
  certificate_password         = var.certificate_pwd
}

// AZURE PRIVATE DNS ZONE
resource "azurerm_private_dns_zone" "redis" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = local.resource_group_name
}

// AZURE VNET
resource "azurerm_virtual_network" "default" {
  name                = "${var.environment}-vnet"
  address_space       = [var.vnet_range]
  location            = var.location
  resource_group_name = local.resource_group_name
  dns_servers         = []

  tags = {
    Env   = var.environment
    Owner = var.owner
  }
}

// AZURE CONTAINER ENVIRONMENT
resource "azapi_resource" "ace" {
  type      = "Microsoft.App/managedEnvironments@2024-03-01"
  name      = "${var.environment}-ace"
  location  = var.location
  parent_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.environment}"

  body = jsonencode({
    properties = {
      vnetConfiguration : {
        internal : true,
        infrastructureSubnetId : azurerm_subnet.default.id,
      },
      workloadProfiles : [
        {
          name : "Consumption",
          workloadProfileType : "Consumption"
        }
      ]
    }
    tags = {
      Env   = var.environment
      Owner = var.owner
    }
  })
}

// AZURE PRIVATE ENDPOINT SUBNET
resource "azurerm_subnet" "pe_snet" {
  name                 = "${var.environment}-pe-subnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes     = [var.pe_subnet_range]

  service_endpoints = ["Microsoft.KeyVault"]
}

// AZURE SUBNET
resource "azurerm_subnet" "default" {
  name                 = "${var.environment}-ace-subnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes     = [var.ace_subnet_range]

  delegation {
    name = "Microsoft.App.environments"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.App/environments"
    }
  }
}

// AZURE SHARED REDIS PRIVATE DNS ZONE
resource "azurerm_private_dns_zone_virtual_network_link" "vnet" {
  name                = "${var.environment}vnet"
  resource_group_name = var.redis_dns_zone_rg
  private_dns_zone_name = azurerm_private_dns_zone.redis.name
  virtual_network_id  = azurerm_virtual_network.default.id
  registration_enabled = false
}

// AZURE SHARED REDIS SERVER PRIVATE ENDPOINT
resource "azurerm_private_endpoint" "redis_private_endpoint" {
  name                = "${var.environment}-redis-pe-01"
  location            = var.location
  resource_group_name = local.resource_group_name
  subnet_id           = azurerm_subnet.redis_snet.id

  private_service_connection {
    name                           = "${azurerm_redis_cache.server.name}-psc"
    private_connection_resource_id = azurerm_redis_cache.server.id
    is_manual_connection           = false
    subresource_names              = ["redisCache"]
  }

  tags = {
    ProjectName = "API"
    Env         = "${var.environment}"
    Owner       = var.owner
  }
}

// AZURE REDIS SUBNET
resource "azurerm_subnet" "redis_snet" {
  name                 = "${var.environment}-redis-subnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes     = [var.redis_subnet_range]
  default_outbound_access_enabled = false
}

// AZURE CONTAINER REGISTRY
resource "azurerm_container_registry" "acr" {
  name                = "${var.environment}acr"
  resource_group_name = local.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true

  tags = {
    Env   = var.environment
    Owner = var.owner
  }
}

// AZURE SHARED REDIS SERVER
resource "azurerm_redis_cache" "server" {
  name                 = "${var.environment}redis01"
  location             = var.location
  resource_group_name  = local.resource_group_name
  capacity             = 0
  family               = "C"
  sku_name             = "Standard"
  minimum_tls_version  = "1.2"
}
