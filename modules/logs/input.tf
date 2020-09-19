variable "LOB" {
  type        = string
  description = "The name of Resource Group"
}

variable "APPID" {
  type        = string
  description = "APplication ID of LOB"
}

variable "vault_name" {
  type        = string
  description = "The name of an vault"
  default  = ""
}
variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group"
}
variable "environment" {
  type        = string
  description = "The name of the Azure app environment" 
  default = "nonprod"
}

variable "target_resource_id" { }

variable "default_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
}


locals {
 resource_group_name = "${var.LOB}-${var.APPID}-${var.environment}-rg"
 monitor_name = "${var.LOB}-${var.APPID}-${var.environment}-kvmdgs"
 loganalytics_name = "${var.LOB}-${var.APPID}-${var.environment}-kvlog"
}

variable "log_analytics_workspace_id" {
    type = string
    default = "log analytics workspace id"
}

variable "location" {
  type        = string
  description = "Define the region the Azure Key Vault should be created, you should use the Resource Group location"
  default = "EastUS"
}