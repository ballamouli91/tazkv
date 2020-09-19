
####################
# common variables #
####################
location    = "EastUS"
environment = "nonprod"
APPID       = "GPS"
LOB = "VAE"
purge_protection_enabled = "true"
soft_delete_enabled = "true"
soft_delete_retention_days = 90

##################
# Authentication #
##################
azure-subscription-id = ""
azure-client-id       = ""
// fetch this from azure Devops
azure-client-secret = ""
azure-tenant-id     = "

#############
# key vault secrets #
#############
"" will auto-generate the password
sqldb = ""
webadmin = ""
roles-test = ""
test-key = "" 
test1=""


spn_permissions =  [
    "Key Vault Reader (preview)",
    "Key Vault Secrets User (preview)",
     ]

##################
#### default tags ###
########################3
// Tagging standards
default_tags = {
  "Application ID"             = ""
  "Created By"                 = "IAC"
}

default_spn_tags = [ "Application ID", "Created By" ]
