terraform {
  cloud {
    organization = "soyroberto"

    workspaces {
      name = "terraform"
    }
  }
}
resource "random_pet" "rgp" {
  length = 2
  prefix = "rg"
}
resource "random_pet" "rsa" {
  length = 1 #SA do not allow -
  #prefix = "sa"
}
resource "random_string" "sarx" {
  length  = 6
  special = false
  upper   = false
  numeric = false
}


variable "region" {
  type    = string
  default = "Australia Southeast"

}
resource "azurerm_resource_group" "xrg" {
  name     = random_pet.rgp.id
  location = var.region
}

resource "azurerm_storage_account" "storage_account" {
  name                     = random_string.sarx.id
  resource_group_name      = azurerm_resource_group.xrg.name
  location                 = var.region
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind
  static_website {
    index_document     = var.static_website_index_document
    error_404_document = var.static_website_error_404_document
  }
}


