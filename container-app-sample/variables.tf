variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "sample-container-app-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Brazil South"
}

variable "containerRegistryName" {
  description = "Container Registry Name"
  type        = string
  default     = "sampleContainerRegistry"
}

variable "client_id" {}
variable "client_secret" {}
variable "subscription_id" {}
variable "tenant_id" {}