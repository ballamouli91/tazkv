output "key-vault-diganostic-id" {
  description = "key-vault-diganostic-id"
  value       = azurerm_monitor_diagnostic_setting.vault_monitor.id
}

output "vault_loganalytics-id" {
  description = "vault_loganalytics-id"
  value       = azurerm_log_analytics_workspace.vault_loganalytics.id
}

output "vault_loganalytics-primary_shared_key" {
  description = "vault_loganalytics-primary_shared_key"
  value       = azurerm_log_analytics_workspace.vault_loganalytics.primary_shared_key
}

output "vault_loganalytics-secondary_shared_key" {
  description = "vault_loganalytics-secondary_shared_key"
  value       = azurerm_log_analytics_workspace.vault_loganalytics.secondary_shared_key
}