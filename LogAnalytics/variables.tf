# variables.tf
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rgloganalyticsaux"
}

variable "location" {
  description = "The Azure region to deploy the resource group"
  type        = string
  default     = "Australia East"
}

variable "sa_name" {
  description = "The Azure RG for the storage account"
  type        = string
  default     = "saterraformstx"
}

variable "sa_container" {
  description = "The Azure container for the TF state file"
  type        = string
  default     = "log-analytics"

}

variable "sa_tfstate_file" {
  description = "The Azure file name for the TF state file"
  type        = string
  default     = "terraform.tfstate"

}

variable "la_workspacename" {
  description = "The Azure file name for the TF state file"
  type        = string
  default     = "loganauexchix"

}

# variables.tf
variable "tags" {
  description = "A map of tags to assign to the Log Analytics Workspace"
  type        = map(string)
  default = {
    es           = "POC"
    Project      = "LogAnalytics"
    Owner        = "DevOps"
    subscription = "Chiclito"
    zone         = "aues"
  }
}