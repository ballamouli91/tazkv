provider "azuread" {
  version = "~> 0.3"
}

data "azurerm_subscription" "main" {}
resource "azuread_application" "spn" {
  name     = local.spn_name
  homepage = local.spn_url
  available_to_other_tenants = false
  // list of Azure AD Object IDs that will be granted ownership of the application.if a list is specified the caller Object ID will no longer be included unless explicitly added to the list.
  owners   = var.ownerlist  
  // will return an error when an existing Application is found with the same name. 
  prevent_duplicate_names = false
}

resource "azuread_service_principal" "spn" {
  application_id = azuread_application.spn.application_id
  tags = var.default_spn_tags
}

// manual creation of spn will give password as outur where as with terrafrom we need to create password
resource "random_password" "spn_password" {
  count  = var.password == "" ? 1 : 0
  length = 32

 /*keepers = {
    rfc3339 = time_rotating.main.id
  } */
}

/* resource "time_rotating" "main" {
  rotation_rfc3339 = var.end_date
  rotation_years   = var.years

  triggers = {
    end_date = var.end_date
    years    = var.years
  }
} */


// One of end_date or end_date_relative must be set.
resource "azuread_service_principal_password" "spn" {
  service_principal_id = azuread_service_principal.spn.id
  value                = var.generate_password ? random_password.spn_password[0].result : var.spn_password
  end_date             = var.spn_expiry
}

