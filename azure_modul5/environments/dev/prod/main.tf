terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
provider "azurerm" {
  features {}
}
locals {
  name_prefix = "${var.student_id}-${var.project}"
}
resource "azurerm_resource_group" "main" {
  name     = "${local.name_prefix}-rg"
  location = var.location
}
module "stack" {
  source              = "../../stacks"
  project             = local.name_prefix
  location            = var.location
  student_id          = var.student_id
}
