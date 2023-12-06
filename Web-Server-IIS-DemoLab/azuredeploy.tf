#Resource Groups
resource "azurerm_resource_group" "rg1" {
  name     = var.azure-rg-1
  location = var.loc1
  tags = {
    Environment = var.environment_tag
    Function    = "webdemo-resourcegroups"
  }
}
#Resource Groups
resource "azurerm_resource_group" "rg2" {
  name     = var.azure-rg-2
  location = var.loc1
  tags = {
    Environment = var.environment_tag
    Function    = "webdemo-resourcegroups"
  }
}
#VNETs and Subnets
#Hub VNET and Subnets
resource "azurerm_virtual_network" "region1-vnet1-hub1" {
  name                = var.region1-vnet1-name
  location            = var.loc1
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = [var.region1-vnet1-address-space]
  dns_servers         = ["10.10.1.4", "168.63.129.16", "8.8.8.8"]
  tags = {
    Environment = var.environment_tag
    Function    = "webdemo-network"
  }
}
resource "azurerm_subnet" "region1-vnet1-snet1" {
  name                 = var.region1-vnet1-snet1-name
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.region1-vnet1-hub1.name
  address_prefixes     = [var.region1-vnet1-snet1-range]
}
resource "azurerm_subnet" "region1-vnet1-snet2" {
  name                 = var.region1-vnet1-snet2-name
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.region1-vnet1-hub1.name
  address_prefixes     = [var.region1-vnet1-snet2-range]
}
resource "azurerm_subnet" "region1-vnet1-snet3" {
  name                 = var.region1-vnet1-snet3-name
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.region1-vnet1-hub1.name
  address_prefixes     = [var.region1-vnet1-snet3-range]
}
#Spoke VNET and Subnets 
resource "azurerm_virtual_network" "region1-vnet2-spoke1" {
  name                = var.region1-vnet2-name
  location            = var.loc1
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = [var.region1-vnet2-address-space]
  dns_servers         = ["10.10.1.4", "168.63.129.16", "8.8.8.8"]
  tags = {
    Environment = var.environment_tag
    Function    = "webdemo-network"
  }
}
resource "azurerm_subnet" "region1-vnet2-snet1" {
  name                 = var.region1-vnet2-snet1-name
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.region1-vnet2-spoke1.name
  address_prefixes     = [var.region1-vnet2-snet1-range]
}
resource "azurerm_subnet" "region1-vnet2-snet2" {
  name                 = var.region1-vnet2-snet2-name
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.region1-vnet2-spoke1.name
  address_prefixes     = [var.region1-vnet2-snet2-range]
}
resource "azurerm_subnet" "region1-vnet2-snet3" {
  name                 = var.region1-vnet2-snet3-name
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.region1-vnet2-spoke1.name
  address_prefixes     = [var.region1-vnet2-snet3-range]
  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.Netapp/volumes"
      actions = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}
#VNET Peering
resource "azurerm_virtual_network_peering" "peer1" {
  name                         = "region1-vnet1-to-region1-vnet2"
  resource_group_name          = azurerm_resource_group.rg1.name
  virtual_network_name         = azurerm_virtual_network.region1-vnet1-hub1.name
  remote_virtual_network_id    = azurerm_virtual_network.region1-vnet2-spoke1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
resource "azurerm_virtual_network_peering" "peer2" {
  name                         = "region1-vnet2-to-region1-vnet1"
  resource_group_name          = azurerm_resource_group.rg1.name
  virtual_network_name         = azurerm_virtual_network.region1-vnet2-spoke1.name
  remote_virtual_network_id    = azurerm_virtual_network.region1-vnet1-hub1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
#Lab NSG
resource "azurerm_network_security_group" "region1-nsg" {
  name                = "r1-nsg"
  location            = var.loc1
  resource_group_name = azurerm_resource_group.rg2.name

  security_rule {
    name                       = "Web-In"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "RDP-In"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = {
    Environment = var.environment_tag
    Function    = "webdemo-security"
  }
}
#NSG Association to all Lab Subnets
resource "azurerm_subnet_network_security_group_association" "vnet1-snet1" {
  subnet_id                 = azurerm_subnet.region1-vnet1-snet1.id
  network_security_group_id = azurerm_network_security_group.region1-nsg.id
}
resource "azurerm_subnet_network_security_group_association" "vnet1-snet2" {
  subnet_id                 = azurerm_subnet.region1-vnet1-snet2.id
  network_security_group_id = azurerm_network_security_group.region1-nsg.id
}
resource "azurerm_subnet_network_security_group_association" "vnet1-snet3" {
  subnet_id                 = azurerm_subnet.region1-vnet1-snet3.id
  network_security_group_id = azurerm_network_security_group.region1-nsg.id
}
resource "azurerm_subnet_network_security_group_association" "vnet2-snet1" {
  subnet_id                 = azurerm_subnet.region1-vnet2-snet1.id
  network_security_group_id = azurerm_network_security_group.region1-nsg.id
}
resource "azurerm_subnet_network_security_group_association" "vnet2-snet2" {
  subnet_id                 = azurerm_subnet.region1-vnet2-snet2.id
  network_security_group_id = azurerm_network_security_group.region1-nsg.id
}
#Create KeyVault ID
resource "random_id" "kvname" {
  byte_length = 5
  prefix      = "r1-kv-"
}
#Keyvault Creation
data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "kv1" {
  depends_on                  = [azurerm_resource_group.rg2]
  name                        = random_id.kvname.hex
  location                    = var.loc1
  resource_group_name         = var.azure-rg-2
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set",
    ]

    storage_permissions = [
      "Get",
    ]
  }
  tags = {
    Environment = var.environment_tag
    Function    = "webdemo-security"
  }
}
#Create KeyVault VM password
resource "random_password" "vmpassword" {
  length  = 20
  special = true
}
#Create Key Vault Secret
resource "azurerm_key_vault_secret" "vmpassword" {
  name         = "vmpassword"
  value        = random_password.vmpassword.result
  key_vault_id = azurerm_key_vault.kv1.id
  depends_on   = [azurerm_key_vault.kv1]
}
# Create Public IP Address for VM1
resource "azurerm_public_ip" "region1-web01-pip" {
  name                = "r1-web01-pip"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = var.loc1
  allocation_method   = "Static"
  sku                 = "Standard"
}
#Create NIC for VM1
resource "azurerm_network_interface" "region1-web01-nic" {
  name                = "r1-web01-nic"
  location            = var.loc1
  resource_group_name = azurerm_resource_group.rg1.name


  ip_configuration {
    name                          = "region1-web01-ipconfig"
    subnet_id                     = azurerm_subnet.region1-vnet1-snet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.region1-web01-pip.id
  }

  tags = {
    Environment = var.environment_tag
    Function    = "webdemo-activedirectory"
  }
}
#Create data disk for VM1
resource "azurerm_managed_disk" "region1-web01-data" {
  name                 = "r1-web01-data"
  location             = var.loc1
  resource_group_name  = azurerm_resource_group.rg1.name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = "20"
  max_shares           = "2"

  tags = {
    Environment = var.environment_tag
    Function    = "webdemo-activedirectory"
  }
}
#Create IIS VM
resource "azurerm_windows_virtual_machine" "region1-web01-vm" {
  name                = "r1-web01-vm"
  depends_on          = [azurerm_key_vault.kv1]
  resource_group_name = azurerm_resource_group.rg1.name
  location            = var.loc1
  size                = var.vmsize-domaincontroller
  admin_username      = var.adminusername
  admin_password      = azurerm_key_vault_secret.vmpassword.value
  network_interface_ids = [
    azurerm_network_interface.region1-web01-nic.id,
  ]

  tags = {
    Environment = var.environment_tag
    Function    = "webdemo-webserver"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}
#Attach Data Disk to VM1
resource "azurerm_virtual_machine_data_disk_attachment" "region1-web01-data" {
  managed_disk_id    = azurerm_managed_disk.region1-web01-data.id
  depends_on         = [azurerm_windows_virtual_machine.region1-web01-vm]
  virtual_machine_id = azurerm_windows_virtual_machine.region1-web01-vm.id
  lun                = "10"
  caching            = "None"
}
#Run setup script on VM1
resource "azurerm_virtual_machine_extension" "region1-web01-basesetup" {
  name                 = "r1-web01-basesetup"
  virtual_machine_id   = azurerm_windows_virtual_machine.region1-web01-vm.id
  depends_on           = [azurerm_virtual_machine_data_disk_attachment.region1-web01-data]
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<PROTECTED_SETTINGS
    {
      "commandToExecute": "powershell.exe -Command \"./webserver_VMSetup.ps1; exit 0;\""
    }
  PROTECTED_SETTINGS

  settings = <<SETTINGS
    {
        "fileUris": [
          "https://raw.githubusercontent.com/jakewalsh90/Terraform-Azure/main/PowerShell/webserver_VMSetup.ps1"
        ]
    }
  SETTINGS
}
