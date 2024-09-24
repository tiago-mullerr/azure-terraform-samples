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

variable "vnet_range" {
  description = "Environment VNET CIDR Range"
  type        = string
}

variable "ace_subnet_range" {
  description = "Environment SNET CIDR Range"
  type        = string
}

variable "pe_subnet_range" {
  description = "Environment SNET CIDR Range"
  type        = string
}

variable "redis_subnet_range" {
  description = "Environment SNET CIDR Range"
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

variable "certificate_pwd" {
  description = "Certificate password"
  type        = string
}

variable "certificate_base64" {
  description = "Base 64 Encoded PFX File"
  type        = string
}

variable "redis_dns_zone_rg" {
  description = "Resource Group for Private DNS resources"
  type        = string
}