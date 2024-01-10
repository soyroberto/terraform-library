locals {
  # local variable to differentiate VM is windows
  vm_is_windows = length(regexall("window", lower(var.custom_image_name))) > 0 || length(regexall("window", lower(var.custom_image_id))) > 0 ? true : false
  # VM prefix from the App Service lookup module
  vm_prefix = var.prefix
  #
  instance_names = [
    for index in range(var.vm_nb_instances) :
    "${local.vm_prefix}${format("%00005d", tonumber(index) + 1)}"
  ]
  instances = [
    for instance_name in local.instance_names :
    {
      name = instance_name
      datadisks = [
        for vm_data_disk_name, vm_data_disk_size in var.vm_data_disks : {
          id   = format("%s_datadisk_%s_%d", instance_name, element(split("-", vm_data_disk_name), 1), vm_data_disk_size)
          name = format("%s_datadisk_%s", instance_name, element(split("-", vm_data_disk_name), 1))
          lun  = element(split("-", vm_data_disk_name), 1)
          size = vm_data_disk_size
        }
      ]
    }
  ]
}

resource "null_resource" "debug" {
  triggers = {
    //    instances           = jsonencode(local.instances)
    instance = jsonencode(flatten(local.instances.*.datadisks))
    //    vm_datadisk_lun_map = jsonencode(local.vm_datadisk_lun_map)
  }
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_shared_image_version" "sharedimage" {
  count               = var.custom_image_id != "" ? 0 : 1
  name                = var.custom_image_version
  image_name          = var.custom_image_name
  gallery_name        = var.custom_image_gallery_name
  resource_group_name = var.custom_image_resource_group_name
}

data "azurerm_storage_account_sas" "diag_sa_sas_token" {
  connection_string = data.azurerm_storage_account.diag_sa.primary_connection_string
  https_only        = true

  resource_types {
    service   = true
    container = false
    object    = false
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = "2018-03-21"
  expiry = "2021-03-21"

  permissions {
    read    = true
    write   = true
    delete  = false
    list    = false
    add     = true
    create  = true
    update  = false
    process = false
  }
}

data "azurerm_subnet" "subnet" {
  name                 = var.vnet_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg
}

data "azurerm_storage_account" "diag_sa" {
  name                = var.diag_name
  resource_group_name = var.diag_rg
}

data "azurerm_log_analytics_workspace" "loganalytics" {
  name                = var.log_analytics_workspace
  resource_group_name = var.log_analytics_rg_name
}

data "azurerm_recovery_services_vault" "vault_ae" {
  name                = var.rsv_resource_vault_name_ae
  resource_group_name = var.rsv_resource_group_ae
}

data "azurerm_recovery_services_vault" "vault_as" {
  name                = var.rsv_resource_vault_name_as
  resource_group_name = var.rsv_resource_group_as
}

data "azurerm_lb_backend_address_pool" "lb_bp" {
  count           = var.is_lb ? 1 : 0
  name            = "${local.vm_prefix}-lb-bepool"
  loadbalancer_id = var.lb_id
}
