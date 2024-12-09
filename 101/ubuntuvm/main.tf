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
  name                = var.vnet_name
  resource_group_name = var.vnet_rg
}
