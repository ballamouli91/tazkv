##################################
# Azure Resource Group variables #
##################################

variable "LOB" {
  type        = string
  description = "The name of Resource Group"
}

variable "APPID" {
  type        = string
  description = "APplication ID of LOB"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group"
}


variable "vault_name" {
  type        = string
  description = "The name of an vault"
  default  = ""
}

locals {
 resource_group_name = "${var.LOB}-${var.APPID}-${var.environment}-rg"
 vault_name = "${var.LOB}-${var.APPID}-${var.environment}-vault"
}

variable "location" {
  type        = string
  description = "Define the region the Azure Key Vault should be created, you should use the Resource Group location"
  default = "EastUS"
}

#############################
# Azure Key Vault variables #
#############################

variable "name" {
  type        = string
  description = "The name of the Azure APP Key Vault"
  default = "app"
}
variable "environment" {
  type        = string
  description = "The name of the Azure app environment" 
  default = "nonprod"
}
variable "sku_name" {
  type        = string
  description = "Select Standard or Premium SKU"
  default     = "standard"
}

variable "enabled_for_deployment" {
  type        = string
  description = "Allow Azure Virtual Machines to retrieve certificates stored as secrets from the Azure Key Vault"
  default     = "false"
}

variable "enabled_for_disk_encryption" {
  type        = string
  description = "Allow Azure Disk Encryption to retrieve secrets from the Azure Key Vault and unwrap keys" 
  default     = "false"
}

variable "enabled_for_template_deployment" {
  type        = string
  description = "Allow Azure Resource Manager to retrieve secrets from the Azure Key Vault"
  default     = "false"
}

variable "default_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
}

variable "secrets" {
  type = map(object({
    value = string
  }))
  description = "Define Azure Key Vault secrets"
  default = {}
}


variable "purge_protection_enabled" {
  type = bool  
}

variable "soft_delete_enabled" {
  type = bool  
}

variable "soft_delete_retention_days" {
  type = number
}