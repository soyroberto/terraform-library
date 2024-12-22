variable "username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "roberto"
}

variable "location" {
  type        = string
  default     = "Australia East"
  description = "Location of the resource group."
}

variable "vnet_rg" {
  description = "The name of the resource group where the VNet is located"
  type        = string
  default     = "rg-precious-molly"

}

variable "vnet_name" {
  description = "The name of the existing VNet"
  type        = string
  default     = "vneterrafx"
}

variable "subnet_name" {
  description = "The name of the existing subnet"
  type        = string
  default     = "computers"
}

variable "vm_size" {
  description = "The size of the VM"
  type        = string
  default     = "Standard_DS1_v2"
}
variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  type        = string
  default     = "aueaix"
}


variable "length" {
  description = "Prefix length"
  type        = number
  default     = 4
}

resource "random_string" "random" {
  length           = var.length
  numeric          = false
  upper            = true
  special          = false
  override_special = "a-zA-Z"

}

resource "random_pet" "pet" {
  length = 1
}
# variable "resource_group" {
#   description = "The name of the resource group in which the resources will be created"
#   type        = string
#   #default     = "rg-precious-molly"

# }

