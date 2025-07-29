/*
    This file is part of the ITToolbox project.

    This file creates the Azure automation account that will host runbooks and other automation tasks.
    It is used to manage automation tasks in Azure.

    The Automation Account will also be used to run PowerShell scripts to be used in the ITToolbox project.
    The scripts will query Entra environment using Microsoft Graph API and Azure PowerShell modules.
    The automation account will used managed identities to authenticate to Azure resources.
*/

# Terraform configuration for the ITToolbox Automation Account
# Use managed identity for authentication to use Connect-MgGraph -Identity
resource "azurerm_automation_account" "ITToolbox_automation_account" {
  name                = "ITToolboxAutomationAccount"
  location            = azurerm_resource_group.ITToolbox_rg.location
  resource_group_name = azurerm_resource_group.ITToolbox_rg.name
  sku_name            = "Basic"

  identity {
    type = "SystemAssigned"
  }
}

data "local_file" "Get_GlobalAdminsReport" {
  filename = "${path.module}/Get-GlobalAdminsReport.ps1"
}
data "local_file" "Get_UsersPWReport" {
  filename = "${path.module}/Get-UsersPWReport.ps1"
}
data "local_file" "Get_AppRegistrationsReport" {
  filename = "${path.module}/Get-AppRegSecretExpirationsReport.ps1"
}

# Create a runbook for the Get-GlobalAdminsReport script
resource "azurerm_automation_runbook" "ITToolbox_runbook" {
  name                    = "Get-GlobalAdminsReport"
  resource_group_name     = azurerm_resource_group.ITToolbox_rg.name
  automation_account_name = azurerm_automation_account.ITToolbox_automation_account.name
  location                = azurerm_resource_group.ITToolbox_rg.location
  log_verbose             = true
  log_progress            = true

  runbook_type = "PowerShell"
  content      = data.local_file.Get_GlobalAdminsReport.content
  description  = "Runbook to get Global Admins report from Microsoft Entra ID"

}

# Create a runbook for the Get-UsersPWReport script
resource "azurerm_automation_runbook" "ITToolbox_runbook_pw" {
  name                    = "Get-UsersPWReport"
  resource_group_name     = azurerm_resource_group.ITToolbox_rg.name
  automation_account_name = azurerm_automation_account.ITToolbox_automation_account.name
  location                = azurerm_resource_group.ITToolbox_rg.location
  log_verbose             = true
  log_progress            = true

  runbook_type = "PowerShell"
  content      = data.local_file.Get_UsersPWReport.content
  description  = "Runbook to get Users Password report from Microsoft Entra ID"

}

# Create a runbook for the Get-AppRegSecretExpirationReport script
resource "azurerm_automation_runbook" "ITToolbox_runbook_app" {
  name                    = "Get-AppRegSecretExpirationReport"
  resource_group_name     = azurerm_resource_group.ITToolbox_rg.name
  automation_account_name = azurerm_automation_account.ITToolbox_automation_account.name
  location                = azurerm_resource_group.ITToolbox_rg.location
  log_verbose             = true
  log_progress            = true

  runbook_type = "PowerShell"
  content      = data.local_file.Get_AppRegistrationsReport.content
  description  = "Runbook to get App Registrations Secret Expiration report from Microsoft Entra ID"

}

