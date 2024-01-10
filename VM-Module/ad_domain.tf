resource "azurerm_virtual_machine_extension" "domjoin" {
  for_each             = var.vm_is_domjoin ? toset(local.instance_names) : []
  name                 = "domjoin"
  virtual_machine_id   = local.vm_is_windows ? azurerm_windows_virtual_machine.vm_windows[each.value].id : azurerm_linux_virtual_machine.vm_linux[each.value].id
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"
  # What the settings mean: https://docs.microsoft.com/en-us/windows/desktop/api/lmjoin/nf-lmjoin-netjoindomain
  settings           = <<SETTINGS
{
"Name": "${var.domjoin_url}",
"OUPath": "${var.domjoin_oupath}",
"User": "${var.domjoin_sc_username}",
"Restart": "true",
"Options": "3"
}
SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
{
"Password": "${var.domjoin_sc_password}"
}
PROTECTED_SETTINGS
  depends_on         = [azurerm_windows_virtual_machine.vm_windows]
}