variable "container_app_image_name" {
  description = "Name of the container image"
  type        = string
  default     = "tmosampleapi"
}

variable "container_app_cpu" {
  description = "Desired CPU size for container"
  type        = number
  default     = 0.25
}

variable "container_app_memory" {
  description = "Desired Memory size for container"
  type        = string
  default     = "0.5Gi"
}

variable "client_id" {}
variable "client_secret" {}
variable "subscription_id" {}
variable "tenant_id" {}