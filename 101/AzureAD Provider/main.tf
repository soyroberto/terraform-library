terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
      version = "2.46.0"
    }
  }
}

#GET Domains from Tenant
provider "azuread" {
  # 
}

data "azuread_domains" "aad_domains" {}

output "domain_names" {
  value = data.azuread_domains.aad_domains.domains.*.domain_name
}


