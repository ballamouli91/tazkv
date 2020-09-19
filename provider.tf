# define terraform provider
/* terraform {
  backend "azurerm" {}
} */


terraform {
  required_version = ">= 0.12"
}

# configure the azure provider
provider "azurerm" {
  environment     = "public"
  subscription_id = var.azure-subscription-id
  client_id       = var.azure-client-id
  client_secret   = var.azure-client-secret
  tenant_id       = var.azure-tenant-id
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}
