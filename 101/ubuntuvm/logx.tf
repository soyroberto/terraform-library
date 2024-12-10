resource "azurerm_log_analytics_workspace" "main" {
  name                = "logax-${var.prefix}"
  location            = var.location
  resource_group_name = var.rg_la
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    environment = "POC"
    customer    = "troncoso"
  }
}