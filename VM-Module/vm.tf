resource "azurerm_linux_virtual_machine" "vm_linux" {
  for_each                        = local.vm_is_windows ? [] : toset(local.instance_names)
  name                            = each.value
  resource_group_name             = data.azurerm_resource_group.rg.name
  location                        = data.azurerm_resource_group.rg.location
  availability_set_id             = var.availability_set_id != "" ? var.availability_set_id : null
  proximity_placement_group_id    = var.proximity_group_id != "" ? var.proximity_group_id : null
  size                            = var.vm_size
  source_image_id                 = var.custom_image_id != "" ? var.custom_image_id : data.azurerm_shared_image_version.sharedimage[0].id
  computer_name                   = each.value
  disable_password_authentication = false
  admin_username                  = var.vm_admin_username
  admin_password                  = var.vm_admin_password
  zone                            = var.availability_zones != null ? var.availability_zones[0] : null

  os_disk {
    name                 = "${each.value}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  boot_diagnostics {
    storage_account_uri = join(",", data.azurerm_storage_account.diag_sa.*.primary_blob_endpoint)
  }
  network_interface_ids = [
    azurerm_network_interface.nic[each.value].id
  ]
  tags = data.azurerm_resource_group.rg.tags
  depends_on = [
    azurerm_network_interface.nic
  ]
}


resource "azurerm_windows_virtual_machine" "vm_windows" {
  for_each                     = local.vm_is_windows ? toset(local.instance_names) : []
  name                         = each.value
  computer_name                = each.value
  location                     = data.azurerm_resource_group.rg.location
  resource_group_name          = data.azurerm_resource_group.rg.name
  size                         = var.vm_size
  source_image_id              = var.custom_image_id != "" ? var.custom_image_id : data.azurerm_shared_image_version.sharedimage[0].id
  availability_set_id          = var.availability_set_id != "" ? var.availability_set_id : null
  proximity_placement_group_id = var.proximity_group_id != "" ? var.proximity_group_id : null
  zone                         = var.availability_zones != null ? var.availability_zones[0] : null
  admin_username               = var.vm_admin_username
  admin_password               = var.vm_admin_password
  provision_vm_agent           = true
  os_disk {
    name                 = "${each.value}-osDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  boot_diagnostics {
    storage_account_uri = join(",", data.azurerm_storage_account.diag_sa.*.primary_blob_endpoint)
  }
  network_interface_ids = [
    azurerm_network_interface.nic[each.value].id
  ]
  tags = data.azurerm_resource_group.rg.tags
  depends_on = [
    azurerm_network_interface.nic
  ]
}