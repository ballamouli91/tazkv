
resource "azurerm_monitor_diagnostic_setting" "vault_monitor" {
  name               = local.monitor_name
  target_resource_id = var.target_resource_id
   # log destinations. Currently, we have only implemented log analytics.
  log_analytics_workspace_id = var.var.log_analytics_workspace_id
  # azurerm_log_analytics_workspace.vault_loganalytics.id
   # log destinations. to retain logs.
  // storage_account_id = local.vault_name
  // One of eventhub_authorization_rule_id, log_analytics_workspace_id and storage_account_id must be specified.
  log {
    category = "AuditEvent"
    enabled  = true

    retention_policy {
      enabled = true
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
    }
  }
}
