# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {

  cloud {
    organization = "soyroberto"
    workspaces {
      name = "terraform"
      #name = "az"
    }
  }

  /*  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.1"
    }
  }
 */ required_version = ">= 1.1.0"
}

/*provider "azurerm" {
  features {}
}*/

resource "random_string" "random" {
  length  = 10
  special = false
  lower   = true
  upper   = false
}

resource "random_string" "varx" {
  length  = 10
  special = false
  lower   = true
  upper   = false
}




resource "azurerm_resource_group" "example" {
  #name     = "${var.prefix}-resources"
  name     = random_string.varx.result
  location = var.location
}

resource "azurerm_storage_account" "example" {
  name = random_string.random.result
  #name                     = random_string.random.id
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    "Environment" = "Terraform Getting Started"
    "Team"        = "Gomitos"
  }
  network_rules {
    default_action = "Allow"
    ip_rules       = ["23.45.1.0/30"]
  }
}
