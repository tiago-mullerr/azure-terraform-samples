provider "azurerm" {
  features {    
  }

  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

data "terraform_remote_state" "source" {
  backend = "local"
  config = {
    path = "../container-env-sample/terraform.tfstate"
  }
}

resource "azurerm_container_app" "aca" {
  name                         = var.container_app_image_name
  container_app_environment_id = data.terraform_remote_state.source.outputs.sample_azure_container_environment_id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  template {
    container {
      name   = var.container_app_image_name
      image  = "${data.terraform_remote_state.source.outputs.container_registry_name}.azure.io/${var.container_app_image_name}:latest"
      cpu    = var.container_app_cpu
      memory = var.container_app_memory
    }
  }
}