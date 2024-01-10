#################################
# Mandatory variables
#################################
variable resource_group_name {
  type        = string
  description = "The name of the resource group in which the resource will be created (required)"
}

variable "prefix" {
  type        = string
  description = "The prefix for all resources (required)"
}

variable vm_admin_username {
  type        = string
  description = "VM administrator username"
}

variable vm_admin_password {
  type        = string
  description = "VM administrator password (recommended to disable password auth)"
}

variable "vnet_rg" {
  type        = string
  description = "Existing VNet Resource Group name"
}

variable "vnet_name" {
  type        = string
  description = "Existing VNet name"
}

variable "vnet_subnet_name" {
  type        = string
  description = "Existing Subnet name"
}

variable tags {
  type    = map(string)
  default = {}
}

#################################
# Optional variables
#################################
variable "proximity_group_id" {
  description = "Optional input, id of the proximity group to set to the VMs and loadbalancers"
  default     = null
  type        = string
}
variable "availability_set_id" {
  description = "Optional input, id of the proximity group to set to the VMs and loadbalancers"
  default     = null
  type        = string
}

variable "is_lb" {
  type    = bool
  default = false
}

variable "is_agw" {
  type    = bool
  default = false
}

variable "agw_pool_id" {
  type    = string
  default = ""
}

variable "lb_id" {
  type    = string
  default = null
}

variable "vm_nb_instances" {
  default = 1
}

variable "vm_is_publicip" {
  default = false
}

variable "ansible_callback_url" {
  type    = string
  default = ""
}
variable "ansible_host_config_key" {
  type    = string
  default = ""
}

variable "dns_servers" {
  type        = list(string)
  default     = null
  description = "List of DNS servers"
}

variable "asg_name" {
  type        = string
  description = "Existing Application Security Name"
  default     = ""
}
/*
variable "asg_resource_group_name" {
  type        = string
  description = "Existing ASG resource group name"
  default     = ""
}*/

variable "diag_name" {
  type        = string
  description = "Diagnostic name"
  default     = ""
}

variable "diag_rg" {
  type        = string
  description = "Diagnostic Resource Group"
  default     = ""
}

variable "patch_windows" {
  type        = string
  description = "Patch Windows tag"
  default     = ""
}

variable "log_analytics_rg_name" {
  type        = string
  description = "Log Analytics Resource Group Name"
  default     = ""
}

variable "log_analytics_workspace" {
  type        = string
  description = "Log Analytics Workspace Name"
  default     = ""
}

variable "rsv_backup_policy_name" {
  type        = string
  description = "Existing Subnet name"
  default     = ""
}

variable "rsv_resource_group_ae" {
  type        = string
  description = "RSV Resource Group name for Australia East"
  default     = ""
}

variable "rsv_resource_group_as" {
  type        = string
  description = "RSV Resource Group name for Australia Southeast"
  default     = ""
}

variable "rsv_resource_vault_name_ae" {
  type        = string
  description = "RSV Resource Vault name for Australia East"
  default     = ""
}

variable "rsv_resource_vault_name_as" {
  type        = string
  description = "RSV Resource Vault name for Australia Southeast"
  default     = ""
}


variable vm_size {
  type        = string
  description = "Specifies the instance type of the virtual machine."
  default     = "Standard_D2s_v3"
}

variable vm_is_domjoin {
  type        = bool
  description = "Whether this VM join the domain"
  default     = false
}

variable domjoin_url {
  type        = string
  description = "The OU path"
  default     = ""
}

variable domjoin_oupath {
  type        = string
  description = "The OU path"
  default     = ""
}

variable domjoin_sc_username {
  type        = string
  description = "The OU path"
  default     = ""
}

variable domjoin_sc_password {
  type        = string
  description = "The OU path"
  default     = ""
}

variable "vm_data_disks" {
  type = map
}

variable "vm_data_disk_type" {
  type        = string
  description = "Type of data disk"
  default     = "Premium_LRS"
}

variable custom_image_gallery_name {
  type        = string
  description = "Shared Image Gallery name"
  default     = ""
}

variable custom_image_resource_group_name {
  type        = string
  description = "Resource Group Name of Shared Image Gallery"
  default     = ""
}

variable custom_image_name {
  type        = string
  description = "Image name from Shared Image Gallery"
  default     = ""
}

variable custom_image_version {
  type        = string
  description = "Image version from Shared Image Gallery (recommended to use the extact version instead of latest)"
  default     = "latest"
}

variable custom_image_id {
  type        = string
  description = "Image ID from Shared Image Gallery (from other subscription)"
  default     = ""
}

variable availability_zones {
  type        = list(string)
  description = "Optional Availability Zone"
  default     = null
}