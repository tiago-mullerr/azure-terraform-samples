output "sample_azure_container_environment_id" {
  value = azurerm_container_app_environment.ace.id
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "container_registry_name" {
  value = azurerm_container_registry.acr.name
}