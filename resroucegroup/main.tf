
data "azurerm_client_config" "current" {}

# Create a resource group for security
resource "azurerm_resource_group" "app" {
  name     = local.resourcegroup_name
  location = var.location
  tags = var.default_tags
}
