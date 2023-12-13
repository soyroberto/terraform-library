output "storage_account_name" {
  description = "storage account name"
  value       = azurerm_storage_account.storage_account.name 
}
output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.xrg.name
}