# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

## Terraform configuration

terraform {

  cloud {
    organization = "soyroberto"
    workspaces {
      name = "terraform"
    }
  }

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.1"
    }
  }
  required_version = ">= 1.1.0"
}

variable "name_length" {
  description = "The number of words in the pet name"
  default     = "7"
}

resource "random_pet" "pet_name" {
  length    = var.name_length
  separator = "*"
}

resource "random_pet" "server" {
  length    = var.name_length
  separator = "-"
}

resource "random_string" "random" {
  length           = 16
  special          = true
  override_special = "/@£$"
}

resource "random_uuid" "uux" {
}

output "t_uux" {
  value = random_uuid.uux.id
}

output "rs" {
  value = random_string.random.id
}

output "pet_name" {
  value = random_pet.pet_name.id
}
output "gatito_name" {
  value = random_pet.pet_name.id
}
output "quesito_name" {
  value = random_pet.pet_name.id
}

output "gatito_2" {
  value = random_pet.server.id
}
