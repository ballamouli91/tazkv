variable "LOB" {
  type        = string
  description = "The name of Resource Group"
}

variable "APPID" {
  type        = string
  description = "APplication ID of LOB"
}

variable "environment" {
  type        = string
  description = "The name of the Azure app environment"
}

variable "resourcegroup_name" {
  type        = string
  description = "The name of the Resource Group"
  default = "app"
}


locals {
 resourcegroup_name = "${var.LOB}-${var.APPID}-${var.environment}-rg"
 vault_name = "${var.LOB}-${var.APPID}-${var.environment}-vault"
}

variable "location" {
  description = "Location"
  default = "EastUS"
}

variable "default_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
}
