##################
# resource group #
##################
module "resroucegroup" {
  source = "./modules/resroucegroup"
  APPID     = var.APPID
  LOB       = var.LOB
  environment = var.environment
  default_tags = var.default_tags
}


#############
# key vault #
#############

module "keyvault" {
  source              = "./modules/keyvault"
  APPID               = var.APPID
  LOB                 = var.LOB
  environment         = var.environment
  location            = module.resroucegroup.location
  resource_group_name = module.resroucegroup.name
  secrets             = local.kv-secrets
  purge_protection_enabled = var.purge_protection_enabled
  soft_delete_enabled = var.soft_delete_enabled
  soft_delete_retention_days = var.soft_delete_retention_days
  depends_on = [
    module.resroucegroup,
  ]
  default_tags = var.default_tags
}

resource "null_resource" "enable-rbac" {
  provisioner "local-exec" {
    command     = "az keyvault update --name ${module.keyvault.name} -g ${module.resroucegroup.name}  --enable-rbac-authorization true"
    interpreter = ["-Command"]
  }
}

############
### logs ###
############
    ##  workspace can be created one and we can share one workspace amo
    ## log_analytics_workspace_id = data.azurerm_log_analytics_workspace.main.id
/* data "azurerm_log_analytics_workspace" "main" {
  name                = local.loganalytics_name
  resource_group_name = module.resroucegroup.name
    depends_on = [
    module.resroucegroup,
  ]
} */
module "logs" {
  source              = "./modules/logs"
  APPID               = var.APPID
  LOB                 = var.LOB
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resroucegroup.id
  target_resource_id  = module.keyvault.key-vault-id
  default_tags        = var.default_tags
  depends_on = [
    module.resroucegroup,
    data.azurerm_log_analytics_workspace.main,
  ]
}



#####################
#####     SPN   #####
#####################
/* data "azurerm_resource_group" "main" {
  name = "${var.LOB}-${var.APPID}-${var.environment}-rg"
  depends_on = [
    module.resroucegroup,
  ]
} */
module "terraform-azure-spn" {
  APPID               = var.APPID
  LOB                 = var.LOB
  environment         = var.environment
  source     = "./modules/spn"
  default_spn_tags = var.default_spn_tags
}

data "azurerm_role_definition" "main" {
  for_each = toset(var.spn_permissions)
  name  =  format("%s", each.key) 
}

data "azurerm_subscription" "main" {}

resource "azurerm_role_assignment" "main" {
  for_each           = data.azurerm_role_definition.main
  scope              = module.resroucegroup.id 
  role_definition_id = format("%s%s", data.azurerm_subscription.main.id, data.azurerm_role_definition.main[each.key].id)
  principal_id       = module.terraform-azure-spn.spn_objectid
  depends_on = [
    module.resroucegroup,
  ]
}


#################
#### AWS EC2 ####
#################

provider "aws" {
  region     = "ap-southeast-1"
  access_key = ""
  secret_key = ""
}


/* resource "aws_instance" "myec2" {
   ami = "ami-0cd31be676780afa7"
   instance_type = "t2.nano"
} */

