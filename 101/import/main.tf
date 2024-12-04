#Import exising resources into terraform state
# @soyroberto
terraform {
  cloud {
    organization = "soyroberto"

    workspaces {
      name = "terraform"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.11.0"
    }
  }
}


provider "azurerm" {
  features {}
}

resource "random_pet" "rgp" {
  length = 2
  prefix = "rg"
}
variable "region" {
  type    = string
  default = "Australia Southeast"
}

resource "azurerm_resource_group" "xrg" {
  name     = random_pet.rgp.id
  location = var.region
}


# import {
#     id = "/subscriptions/<SUB_ID>/resourceGroups/rg-precious-molly/providers/Microsoft.Storage/storageAccounts/sanauenoterraforx"
#     to =  azurerm_storage_account.existing
# }

# resource "azurerm_storage_account" "existing" {
#   name                     = "sanauenoterraforx"
#   resource_group_name      = "rg-precious-molly" 
#   location                 = "australiaeast"
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

import {
  id = "/subscriptions/<SUB_ID>/resourceGroups/rg-precious-molly/providers/Microsoft.Network/virtualNetworks/vneterrafx"
  #    id = "/subscriptions/${var.TF_ARM_SUBSCRIPTION_ID}/resourceGroups/rg-precious-molly/providers/Microsoft.Network/virtualNetworks/vneterrafx"

    to =  azurerm_virtual_network.azvnet
}

resource "azurerm_virtual_network" "azvnet" {
  name                = "vneterrafx"
  location            = "australiaeast"
  resource_group_name = "rg-precious-molly" 
  address_space       = ["10.0.0.0/24"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name             = "computers"
    address_prefixes = ["10.0.0.0/26"]
  }
}