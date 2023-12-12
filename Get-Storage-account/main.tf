provider "azurerm" {
  features {
  }
}


data "azurerm_storage_account" "rgaz" {
  name                = "saauspii"
  resource_group_name = "AG_RG"
}

output "storage_account_tier" {
  value = data.azurerm_storage_account.rgaz.account_tier
}

output "primary_access_key" {
  value     = data.azurerm_storage_account.rgaz.primary_access_key
  sensitive = true
}