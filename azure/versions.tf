terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0, < 5.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "izztfstate"
    container_name       = "tfstate"
    key                  = "aks/izz-pg.tfstate"

    use_azuread_auth     = true
  }
}
