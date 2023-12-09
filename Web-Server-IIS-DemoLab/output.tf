output "password" {
 value = azurerm_key_vault_secret.vmpassword.value
 sensitive = true
}

output "rg1" {
value = random_pet.rg_name.id  
}

output "rg2" {
 value = random_pet.rg_name2.id 
}
