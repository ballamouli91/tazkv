
data "azurerm_client_config" "current" {}

# Create the Azure Key Vault


resource "azurerm_key_vault" "key-vault" {
  name               = local.vault_name
  location            = var.location
  resource_group_name = local.resource_group_name
  // Once Soft Delete has been Enabled it's not possible to Disable it.
  soft_delete_enabled         = var.soft_delete_enabled
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = var.purge_protection_enabled
  
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment

  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name  = var.sku_name
  tags      = var.default_tags

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}

# Create an Azure Key Vault secrets
resource "azurerm_key_vault_secret" "secret" {
  for_each     = var.secrets
  key_vault_id = azurerm_key_vault.key-vault.id
  name         = each.key
  value        = lookup(each.value, "value") != "" ? lookup(each.value, "value") : random_password.password[each.key].result
  tags         = var.default_tags
  depends_on = [
    azurerm_key_vault.key-vault,
    // azurerm_key_vault_access_policy.default_policy,
  ]
 
} 



 # Generate a random password
resource "random_password" "password" {
  for_each    = var.secrets
  length      = 20
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
  min_special = 2

  keepers = {
    name = each.key
  }
}

