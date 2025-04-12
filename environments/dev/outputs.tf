output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "vnet_id" {
  description = "The ID of the virtual network"
  value       = module.vnet.vnet_id
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = module.vnet.vnet_name
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = module.vnet.subnet_ids
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.storage.name
}

output "vm_public_ip" {
  description = "The public IP address of the virtual machine"
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "vm_private_ip" {
  description = "The private IP address of the virtual machine"
  value       = azurerm_network_interface.nic.private_ip_address
} 