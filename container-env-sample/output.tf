output "container_environment_id" {
  value = azapi_resource.ace.id
}

output "container_registry_name" {
  value = azurerm_container_registry.acr.name
}

output "container_registry_id" {
  value = azurerm_container_registry.acr.id
}

output "vnet_id" {
  value = azurerm_virtual_network.default.id
}

output "subnet_id" {
  value = azurerm_subnet.default.id
}

output "pe_subnet_id" {
  value = azurerm_subnet.pe_snet.id
}

output "ace_cert_id" {
  value = azurerm_container_app_environment_certificate.default.id
}

output "azurerm_private_dns_zone_redis_name" {
  value = azurerm_private_dns_zone.redis.name
}

output "azurerm_subnet_outbound_id" {
  value = azurerm_subnet.outbound.id
}

output "azurerm_subnet_inbound_id" {
  value = azurerm_subnet.inbound.id
}