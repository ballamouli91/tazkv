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

variable "spn_name" {
  default = ""
}

variable "spn_url" {
  default = "https://portal.azure.com"
}
locals {
 spn_name = "${var.LOB}-${var.APPID}-${var.environment}-spn"
 spn_url = "https://${var.LOB}-${var.APPID}-${var.environment}-spn.azure.com"
}



variable "spn_expiry" {
  default = "2099-01-01T01:02:03Z"
}

variable "generate_password" {
  default = true
  type = bool
}

variable "spn_password" {
  default = ""
}

// raja, masood,Kevin,john,Joshua,Mouli,Devops APP 
// default = ["1abd7ded-f4ec-4749-b060-a442fd2bf188", "b46babaa-5b7e-4e03-9a30-8c22f22e969d", "1b8a2790-406d-435f-b65b-c06981e65f50", "d69debf1-af1f-493f-8837-35747e55ea0f", "e74e7fe7-767d-4bcd-97a3-7291f48dff7e", "01777676-a496-41c1-9c6d-92f4e06a9aa1", "bd50069c-41f6-4dbf-8833-27afafb3f4a1"]
// required
variable "ownerlist" {
  default = ["fd60afc3-60c0-4b65-a2ee-e19027146e85"] 
  
  // "64ddaae6-6c32-4e79-b9cc-620fc69eb312"
  // mouli,terrafrom-user
  type = list
}


variable "password" {
  type        = string
  default     = ""
  description = "A password for the service principal."
}

variable "scopes" {
  type        = list(string)
  default     = []
  description = "A list of scopes the role assignment applies to."
}

locals {
  scopes = length(var.scopes) > 0 ? var.scopes : [data.azurerm_subscription.main.id]
}

//Key Vault Administrator (preview)
variable "spn_permissions" {
  type = list
  default = [
    "Key Vault Administrator (preview)",
    "Key Vault Reader (preview)",
    "Key Vault Secrets User (preview)",
    "Key Vault Secrets Officer (preview)",
     ]
}
 // below are the built in admin roles for key vault
   /*  "00482a5a-887f-4fb3-b363-3b7fe8e74483",
    "21090545-7ca7-4776-b22c-e363652d74d2",
    "4633458b-17de-408a-b874-0445c86b69e6",
    "b86a8fe4-44ce-4948-aee5-eccb2c155cd7",
  */

variable "default_spn_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = list(string)
}