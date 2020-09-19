# Create storage account for boot diagnostics
resource "azurerm_storage_account" "mystorageaccount" {
    name                = "app-${var.environment}-stgacc"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"
    account_type        = "Standard_LRS"
    # required by new version of azurerm
    account_tier          = "Standard"
    account_replication_type = "GRS"
    tags {
        environment = "app"
    }
}

resource "azurerm_storage_container" "mystoragecontainer" {
  name                  = "app-${var.environment}-stgacc-cont"
  resource_group_name   = "${var.resource_group_name}"
  storage_account_name  = "${azurerm_storage_account.mystorageaccount.name}"
  container_access_type = "private"
}

resource "azurerm_storage_blob" "mystorageblob" {
  name = "app-${var.environment}-stgacc-blob"
  resource_group_name    = "${var.resource_group_name}"
  storage_account_name   = "${azurerm_storage_account.mystorageaccount.name}"
  storage_container_name = "${azurerm_storage_container.mystoragecontainer.name}"

  type = "page"
  size = 5120
}
