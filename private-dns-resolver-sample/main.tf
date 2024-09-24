locals {
  resource_group_name = "${var.environment}"
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

data "terraform_remote_state" "source" {
  backend = "azurerm"
  config = {
    storage_account_name = "${var.environment}devopssa"
    container_name       = "tfstate-${var.environment}"
    resource_group_name  = "${var.environment}"
    key                  = "container-env.terraform.tfstate"
  }
}

resource "azurerm_private_dns_resolver" "private_dns_resolver" {  
  name                = "private-dns-resolver"
  resource_group_name = var.remote_vnet_rg
  location            = var.location
  virtual_network_id  = "/subscriptions/${var.remote_vnet_sub}/resourceGroups/${var.remote_vnet_rg}/providers/Microsoft.Network/virtualNetworks/${var.remote_vnet}"
  provider            = azurerm.site_core_sub

  tags = {
    Env   = var.environment
    Owner = var.owner
  }
}

// PRIVATE DNS ZONE VIRTUAL LINK TO REMOTE VNET
resource "azurerm_private_dns_zone_virtual_network_link" "remote_vnet" {
  name                = "remote_vnet"
  resource_group_name = local.resource_group_name
  private_dns_zone_name = data.terraform_remote_state.source.outputs.azurerm_private_dns_zone_redis_name
  virtual_network_id  = "/subscriptions/${var.remote_vnet_sub}/resourceGroups/${var.remote_vnet_rg}/providers/Microsoft.Network/virtualNetworks/${var.remote_vnet}"
  registration_enabled = false
}

// OUTBOUND ENDPOINT
resource "azurerm_private_dns_resolver_outbound_endpoint" "outbound" {  
  name                    = "wus2-dns-outbound-endpoint"
  private_dns_resolver_id = azurerm_private_dns_resolver.private_dns_resolver.id
  location                = var.location
  subnet_id               = data.terraform_remote_state.source.outputs.azurerm_subnet_outbound_id

  tags = {
    Env   = var.environment
    Owner = var.owner
  }
}

// INBOUND ENDPOINT
resource "azurerm_private_dns_resolver_inbound_endpoint" "inbound" {  
  name                    = "wus2-dns-inbound-endpoint"
  private_dns_resolver_id = azurerm_private_dns_resolver.private_dns_resolver.id
  location                = var.location

  ip_configurations {
    private_ip_allocation_method = "Dynamic"
    subnet_id                    = data.terraform_remote_state.source.outputs.azurerm_subnet_inbound_id
  }

  tags = {
    Env   = var.environment
    Owner = var.owner
  }
}

// DEV FORWARDING RULE
resource "azurerm_private_dns_resolver_forwarding_rule" "dev_rule" {
  name                      = "${var.on_prem_env_name}-outbound-ruleset"
  domain_name               = var.on_prem_domain_name
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.ruleset.id
  enabled                   = true

  target_dns_servers {
    ip_address = "XXX.XXX.XXx.XXX"
    port       = 53
  }
}

// DNS OUTBOUND RULESET
resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "ruleset" {  
  name                                       = "outbound-ruleset"
  resource_group_name                        = var.remote_vnet_rg
  location                                   = var.location
  private_dns_resolver_outbound_endpoint_ids = [azurerm_private_dns_resolver_outbound_endpoint.outbound.id]
  provider                                   = azurerm.site_core_sub

  tags = {
    Env   = var.environment
    Owner = var.owner
  }
}

// AZURE PRIVATE DNS ZONE VIRTUAL LINK 
resource "azurerm_private_dns_resolver_virtual_network_link" "default" {  
  name                      = "${var.environment}-vnet-link"
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.ruleset.id
  virtual_network_id        = data.terraform_remote_state.source.outputs.vnet_id
  provider                  = azurerm.site_core_sub
}

provider "azurerm" {
  skip_provider_registration = true
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  alias           = "external_sub"
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.remote_vnet_sub
}
