# a Sample of using workspaces - a new workspace must be created prior for this to properly work
data "azuread_users" "users" {
  user_principal_names = terraform.workspace == "default" ? ["root@aad.rober.to"] : ["pim@aad.rober.to"]
}

output "user_principal_names" {
  value = data.azuread_users.users.*
}

