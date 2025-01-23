# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create a Log Analytics workspace
resource "azurerm_log_analytics_workspace" "law" {
  name                = var.la_workspacename
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018" # Pricing tier
  retention_in_days   = 60          # Data retention period in days

  tags = var.tags
}

# Output the workspace ID
output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.law.id
}

#USE ENVIRONMENT VARIABLES works better for security

# sh variable setting
# export ARM_CLIENT_ID=
# export ARM_CLIENT_SECRET=
# export ARM_TENANT_ID=
# export ARM_SUBSCRIPTION_ID=
# export TF_VAR_client_secret=