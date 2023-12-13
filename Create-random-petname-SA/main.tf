terraform {
  cloud {
    organization = "soyroberto"
    workspaces {
      name = "az"
    }
  }
}

terraform {
  required_version = ">=0.12"
}

resource "random_pet" "sto_acct" {
  length = 6
  #lenght is the number of strings separated by '-' stoaccts don't allow that special character
}

data "azurerm_resource_group" "xrg" {
  name = "rgkvaus"
}

resource "azurerm_storage_account" "az_sto" {
  #name                     = sto_acct.random_pet.data
  name                     = "sa${lower(substr(random_pet.sto_acct.id, 0, 10))}"
  resource_group_name      = data.azurerm_resource_group.xrg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}
