terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "dev-rg-${var.environment}"
  location = var.location
  tags     = var.tags
}

module "vnet" {
  source = "../../modules/vnet"

  name                = "dev-vnet-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location           = var.location
  address_space      = var.vnet_address_space
  subnets            = var.subnets
  tags               = var.tags
}

resource "azurerm_storage_account" "storage" {
  name                     = "devst${var.environment}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "dev-vm-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = var.tags
}

resource "azurerm_network_interface" "nic" {
  name                = "dev-nic-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet.subnet_ids["subnet1"]
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
} 