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

resource "azurerm_resource_group" "main" {
  name     = "${var.project}-rg"
  location = var.location
}

module "network" {
  source              = "../modules/network"
  project             = var.project
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  student_id          = var.student_id
}

resource "random_password" "demo" {
  length  = 24
  special = true
}