output "public_ip_address" {
  value = azurerm_public_ip.main.ip_address
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "azurerm_linux_virtual_machine" {
  value = azurerm_linux_virtual_machine.main.name
}