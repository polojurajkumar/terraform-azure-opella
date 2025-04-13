output "vnet_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = { for k, v in azurerm_subnet.subnets : k => v.id }
}

output "nsg_id" {
  description = "The ID of the Network Security Group"
  value       = var.create_nsg ? azurerm_network_security_group.nsg[0].id : null
}

output "nsg_name" {
  description = "The name of the Network Security Group"
  value       = var.create_nsg ? azurerm_network_security_group.nsg[0].name : null
} 