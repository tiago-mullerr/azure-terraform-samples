variable "environment" {
  description = "Name of the target environment"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "owner" {
  description = "Resource Owner Default Tag Value"
  type        = string
}

variable "remote_vnet" {
  description = "Name of Remote VNET"
  type        = string
}

variable "remote_vnet_sub" {
  description = "Subscription Id for Remote VNET"
  type        = string
}

variable "remote_vnet_rg" {
  description = "Resource Group for remote VNET"
  type        = string
}

variable "on_prem_domain_name" {
  description = "On-Premises Network Domain Name"
  type        = string
}

variable "client_id" {
  description = "Client ID"
  type        = string
}

variable "client_secret" {
  description = "Client Secret"
  type        = string
}

variable "subscription_id" {
  description = "Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
}

variable "redis_dns_zone_rg" {
  description = "Resource Group for Private DNS resources"
  type        = string
}

variable "certificate_pwd" {
  description = "Certificate password"
  type        = string
}

variable "certificate_base64" {
  description = "Base 64 Encoded PFX File"
  type        = string
}

variable "on_prem_env_name" {
  description = "On Prem Env Name"
  type        = string
}