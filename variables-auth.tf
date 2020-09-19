
##################
# Authentication #
##################

# azure authentication variables
variable "azure-subscription-id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "azure-client-id" {
  type        = string
  description = "Azure Client ID"
}

variable "azure-client-secret" {
  type        = string
  description = "Azure Client Secret"
}

variable "azure-tenant-id" {
  type        = string
  description = "Azure Tenant ID"
}


variable "spn_permissions" {
  type = list
  default = [
    "Key Vault Administrator (preview)",
    "Key Vault Reader (preview)",
    "Key Vault Secrets User (preview)",
    "Key Vault Secrets Officer (preview)",
     ]
}
