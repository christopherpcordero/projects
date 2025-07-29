/*
This Terraform configuration file sets up an Azure environment with a resource group and a budget for the subscription.
It includes the following components:
- A resource group named "lab-rg-1" in the "East US" region.
- A budget for the subscription with a monthly amount of $100

REF: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs


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

# This Terraform configuration file creates an Azure resource group named "lab-rg-1" in the "East US" region
resource "azurerm_resource_group" "rg-1" {
  name     = "lab-rg-1"
  location = "East US"
}


data "azurerm_subscription" "current" {
  # This data source retrieves information about the current Azure subscription
  # It can be used to reference the subscription ID in other resources
}


#budget for the lab
# This configuration creates a budget for the subscription with a monthly amount of $100
resource "azurerm_consumption_budget_subscription" "budget-1" {
  name            = "lab-budget-1"
  subscription_id = data.azurerm_subscription.current.id

  amount     = 100
  time_grain = "Monthly"

  time_period {
    # The budget will be active from October 1, 2023, to September 30, 2026
    start_date = "2025-06-01T00:00:00Z"
    end_date   = "2026-09-30T23:59:59Z"
  }
  # The budget will be applied to the resource group "lab-rg-1"
  filter {
    dimension {
      name   = "ResourceGroupName"
      values = [azurerm_resource_group.rg-1.name]
    }
  }
  notification {
    enabled   = true
    operator  = "GreaterThan"
    threshold = 75.0

    contact_emails = ["christopher.p.cordero@outlook.com"]
  }



}



