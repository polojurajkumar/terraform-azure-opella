#variable "name" {
 # description = "The name of the virtual network"
  #type        = string
#}

#variable "resource_group_name" {
 # description = "The name of the resource group in which to create the virtual network"
  #type        = string
#}

#variable "location" {
 # description = "The location/region where the virtual network is created"
  #type        = string
#}

variable "address_space" {
  description = "The address space that is used by the virtual network"
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
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "create_nsg" {
  description = "Whether to create a Network Security Group"
  type        = bool
  default     = true
}

variable "nsg_rules" {
  description = "A list of Network Security Group rules"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "AllowSSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "AllowHTTP"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
} 
