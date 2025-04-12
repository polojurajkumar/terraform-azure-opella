variable "environment" {
  description = "The environment name"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "eastus"
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "A map of subnet configurations"
  type        = map(string)
  default     = {
    "subnet1" = "10.0.1.0/24"
    "subnet2" = "10.0.2.0/24"
  }
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {
    Environment = "Development"
    Project     = "Opella"
    ManagedBy   = "Terraform"
  }
}

variable "admin_username" {
  description = "The username for the virtual machine"
  type        = string
  default     = "adminuser"
}

variable "ssh_public_key" {
  description = "The SSH public key for the virtual machine"
  type        = string
  sensitive   = true
} 