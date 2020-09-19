/* output "key-vault-id" {
  description = "Key Vault ID"
  value       = module.keyvault.key-vault-id
}

output "key-vault-url" {
  description = "Key Vault URI"
  value       = module.keyvault.key-vault-url
}

output "key-vault-secrets" {
  value = module.keyvault.key-vault-secrets
}

output "spn_passwordguid" {
  value = "${module.terraform-azure-spn.spn_passwordguid}"
} */

output "spn_objectid" {
  value = "${module.terraform-azure-spn.spn_objectid}"
}

output "client_id" {
  value = "${module.terraform-azure-spn.spn_applicationid}"
}

output "secret" {
  sensitive = true
  value = module.terraform-azure-spn.spn_pssword
}

output "tenant_id" {
  value = var.azure-tenant-id
}