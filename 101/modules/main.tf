terraform {
  cloud {
    organization = "soyroberto"

    workspaces {
      name = "terraform"
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
  name = random_pet.rgp.id
  location = var.region
}