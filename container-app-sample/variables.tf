variable "resourceGroupName" {
  description = "Name of the resource group"
  type        = string
  default     = "tmo-sample-container-app-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "South Central US"
}

variable "containerRegistryName" {
  description = "Container Registry Name"
  type        = string
  default     = "tmoSampleContainerRegistry"
}

variable "logAnalyticsWorkspaceName" {
  description = "Log Analytics Workspace Name"
  type        = string
  default     = "tmoSampleLogAnalyticsWorkspace"
}

variable "containerEnvironmentName" {
  description = "Container Environment Name"
  type        = string
  default     = "tmoSampleContainerEnvironment"
}

variable "containerEnvironmentSubnetId" {
  description = "Container Environment Subnet ID"
  type        = string
  default     = "/subscriptions/86ee32c6-1d3a-4adc-8413-bdfa33d69328/resourceGroups/ilumiare-patient-app-rg/providers/Microsoft.Network/virtualNetworks/default-vnet/subnets/default"
}

variable "vNetName" {
  description = "Subscription default VNET Name"
  type        = string
  default     = "default-vnet"
}

variable "client_id" {}
variable "client_secret" {}
variable "subscription_id" {}
variable "tenant_id" {}