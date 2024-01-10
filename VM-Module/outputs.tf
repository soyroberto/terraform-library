output "vm_ids" {
  value = local.vm_is_windows ? [for vm in azurerm_windows_virtual_machine.vm_windows : vm.id] : [for vm in azurerm_linux_virtual_machine.vm_linux : vm.id]
}
output "vm_names" {
  value = local.vm_is_windows ? [for vm in azurerm_windows_virtual_machine.vm_windows : vm.name] : [for vm in azurerm_linux_virtual_machine.vm_linux : vm.name]
}
output "vm_private_ip_addresses" {
  value = local.vm_is_windows ? [for vm in azurerm_windows_virtual_machine.vm_windows : vm.private_ip_address] : [for vm in azurerm_linux_virtual_machine.vm_linux : vm.private_ip_address]
}
output "vm_public_ip_addresses" {
  value = local.vm_is_windows ? [for vm in azurerm_windows_virtual_machine.vm_windows : vm.public_ip_address] : [for vm in azurerm_linux_virtual_machine.vm_linux : vm.public_ip_address]
}
output "vm_admin_names" {
  value = local.vm_is_windows ? [for vm in azurerm_windows_virtual_machine.vm_windows : vm.admin_username] : [for vm in azurerm_linux_virtual_machine.vm_linux : vm.admin_username]
}