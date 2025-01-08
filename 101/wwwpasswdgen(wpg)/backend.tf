terraform {
  backend "azurerm" {
    resource_group_name  = "RGTFSTAUPWD"       # Resource group of the storage account
    storage_account_name = "saauetfpwd"      # Name of the storage account
    container_name       = "terraform-state"       # Name of the container
    key                  = "terraform.tfstate"     # Name of the state file
  }
}