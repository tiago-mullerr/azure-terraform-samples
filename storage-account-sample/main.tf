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

// AZURE STORAGE ACCOUNT
resource "azurerm_storage_account" "tfstate" {
  name                     = "${var.environment}devopssa"
  resource_group_name      = "${var.environment}"
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false

  tags = {
    Env   = "${var.environment}"
    Owner = var.owner
  }
}

// AZURE STORAGE CONTAINER
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate-${var.environment}"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}