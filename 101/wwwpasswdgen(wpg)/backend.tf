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

  client_id       = "a4b10b4c-c8c0-411d-a566-eb330fe6c8bd"
  client_secret   = var.client_secret
  tenant_id       = "b25f0c4b-3037-4565-a787-0b8b56a49970"
  subscription_id = "ff8e65ab-9922-40f7-a46c-610fd088a25c"
}
variable "client_secret" {
    type = string
}


# sh variable setting
# export ARM_CLIENT_ID=" "
# export ARM_CLIENT_SECRET=""
# export ARM_TENANT_ID=""
# export ARM_SUBSCRIPTION_ID=""