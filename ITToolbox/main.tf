/*
    Main Terraform configuration file for the ITToolbox project.
    This file sets up the Azure provider and creates a resource group.

*/

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "ae31db2c-385a-4e7b-ae58-69cad61f65df"
}


resource "azurerm_resource_group" "ITToolbox_rg" {
  name     = "ITToolbox-rg"
  location = "East US"
}

