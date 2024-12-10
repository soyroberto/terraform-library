terraform {
  cloud {
    organization = "soyroberto"

    workspaces {
      name = "az2"
    }
  }
}

provider "azurerm" {
  features {}

}
resource "azurerm_resource_group" "rg" {
  name     = "rgaueryc"
  location = var.location

  tags = {
    environment = "POC"
    pii         = "no"
    customer    = "troncoso"
    iac         = "terraform"
  }
}

data "azurerm_virtual_network" "vnet" {
  #Vnet is in a different resource group
  name                = var.vnet_name
  resource_group_name = var.vnet_rg
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = var.vnet_rg
}

resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
} #public IP
resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ubuntuvm-ipconfig"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "vm-${var.prefix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_F2"
  admin_username      = "roberto"
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username = "roberto"
    #public_key = file("/Users/roberto/.ssh/id_rsa.pub")
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCvA5QmN+6IL2Ro0VKxaxbv/AN7j+yviKYQvLYA1ReNzvMeJ//r91f1dm0Tj3IJuKUqCJxsREWI+2uDudFX6D5Kr/Spl1lZKEwU9xRDytXOOOo2aawu4v4AAOBjzK9tN9FZurwBRYgUQ2tNH53A37Y/qxGmZ2R5Ed6/gGaEE1JFpbKpEwlQW/GWjqNcgT8ONPk+AseKwD6ZecCgFnlrefAT3BaT/44b1+87z/XrD0iaQIfJkZfbXgM2W9Dum1SAQBf+7bDtaAT8MhTjgfjG2cuPlQh0wqc0vqjM/Y2f0owx6jhbs3j9hX0dnfJ2SZhnt1oFUWHn7OxduXT+sdXWfWVMGsyQj5gplTm29PPv2W0o2ofEV03Oo5WJrAq57ZF0vyChY/L0zVmhlAzteFeN1+pgnkeGJX4Nh7ly/IShPYCK+cqYFiyeoJebFBbxCqERQZXsyqpz7Sm8hYeQCaKLhexUoZU89M0oup60v0V6ms6Akb1jF5Rq8JdtfMYwj3M9LKk= roberto@MacGomitos.local"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}