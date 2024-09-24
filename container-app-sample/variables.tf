variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "container_app_image_name" {
  description = "Name of the container image"
  type        = string
}

variable "container_app_cpu" {
  description = "Desired CPU size for container"
  type        = number
  default     = 0.5
}

variable "container_app_memory" {
  description = "Desired Memory size for container"
  type        = string
  default     = "1Gi"
}

variable "client_id" {}
variable "client_secret" {}
variable "subscription_id" {}
variable "tenant_id" {}