
terraform {
  required_version = ">= 1.15.8"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}

  # subscription_id via ARM_SUBSCRIPTION_ID, som i øving 4:
  #   export ARM_SUBSCRIPTION_ID="$(az account show --query id -o tsv)"
}

locals {
  name_prefix = "${var.kortnavn}-${var.project}"

  common_tags = {
    owner      = var.kortnavn
    course     = "iac"
    module     = "modul6"
    managed_by = "terraform"
  }
}

resource "azurerm_resource_group" "main" {
  name     = "${local.name_prefix}-rg"
  location = var.location
  tags     = local.common_tags
}

module "network" {
  source = "./network"

  name_prefix         = local.name_prefix
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = local.common_tags
}