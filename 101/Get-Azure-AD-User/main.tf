data "azuread_users" "users" {
  user_principal_names = ["root@aad.rober.to", "pim@aad.rober.to"]
}

output "user_principal_names" {
  value = data.azuread_users.users.*
}