terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }


  backend "azurerm" {
    resource_group_name  = "rgkvaus"           # Resource group of the storage account
    storage_account_name = "satfpwds"          # Name of the storage account
    container_name       = "terraform-state"   # Name of the container
    key                  = "terraform.tfstate" # Name of the state file
  }
}
provider "azurerm" {
  features {}

  client_id       = ""
  client_secret   = var.client_secret
  tenant_id       = ""
  subscription_id = ""
}
variable "client_secret" {
    type = string
}


# sh variable setting
# export ARM_CLIENT_ID=" "
# export ARM_CLIENT_SECRET=""
# export ARM_TENANT_ID=""
# export ARM_SUBSCRIPTION_ID=""
