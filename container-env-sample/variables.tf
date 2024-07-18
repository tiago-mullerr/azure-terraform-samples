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

variable "stateStorageContainerName" {
  description = "Terraform State Storage Container Name"
  type        = string
  default     = "container-app-sample-tfstate"
}

variable "client_id" {}
variable "client_secret" {}
variable "subscription_id" {}
variable "tenant_id" {}