output "password" {
 value = azurerm_key_vault_secret.vmpassword.value
 sensitive = true
}
