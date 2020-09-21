#####################
# Network variables #
#####################

# environment
variable "environment" {
  type        = string
  description = "This variable defines the environment to be built"
  default     = "nonprod"
}

# azure region
variable "location" {
  type        = string
  description = "Azure region where the resource group will be created"
  default     = "EastUS"
}

variable "LOB" {
  type        = string
  description = "The name of Resource Group"
  default     = "LOOB"
}

variable "APPID" {
  type        = string
  description = "APplication ID of LOB"
  default     = "APP"
}

variable "name" {
  type        = string
  description = "The name of the Resource Group"
  default = "app"
}

locals {
 name = "${var.LOB}-${var.APPID}-${var.environment}-rg"
 vault_name = "${var.LOB}-${var.APPID}-${var.environment}-vault"
 loganalytics_name = "${var.LOB}-${var.APPID}-${var.environment}-kvlog"
}

variable "kv-secrets" {
  type = map(object({
    value = string
  }))
  description = "Define Azure Key Vault secrets"
  default = {}
  } 

variable "secrets" {
  type = map(object({
    value = string
  }))
  description = "Define Azure Key Vault secrets"
  default = {}
}

variable "default_spn_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = list(string)
  default     = []
}

variable "default_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
variable "purge_protection_enabled" {
  description = " Is Purge Protection enabled for this Key Vault?"
  type        = bool
}
variable "soft_delete_enabled" {
  description = " Should Soft Delete be enabled for this Key Vault?"
  type        = bool
}
variable "soft_delete_retention_days" {
  description = "soft_delete_retention_days"
  type        = number
  default     = 90
}

################
variable "sqldb" {
  default = "Secret!"
}
variable "webadmin" {
  default = "mo@outlook.com"
}


locals {
  kv-secrets = {
     sqldb = {
       value = var.sqldb
           }
    webadmin = {
      value = var.webadmin
           } 
   }
}

variable "spn_objectid" {
  default = "61b3232e-df97-4d21-b8f6-462cb483eeec"
  }
