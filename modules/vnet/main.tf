resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  tags                = var.tags

  dynamic "subnet" {
    for_each = var.subnets
    content {
      name           = subnet.key
      address_prefix = subnet.value
    }
  }
}

resource "azurerm_network_security_group" "nsg" {
  count = var.create_nsg ? 1 : 0

  name                = "${var.name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  dynamic "security_rule" {
    for_each = var.nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  count = var.create_nsg ? length(var.subnets) : 0

  subnet_id                 = azurerm_virtual_network.vnet.subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg[0].id
} 