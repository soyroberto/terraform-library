terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }


  backend "azurerm" {
    resource_group_name  = "RGAUSNetCh"     # Resource group of the storage account
    storage_account_name = "saterraformstx" # Name of the storage account

    container_name = "log-analytics"     # Name of the container
    key            = "terraform.tfstate" # Name of the state file

  }
}
provider "azurerm" {
  features {}
}