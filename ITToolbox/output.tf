/*
Tf file for outputs of the ITToolbox project.
*/

output "resource_group_name" {
  value       = azurerm_resource_group.ITToolbox_rg.name
  description = "The name of the resource group where the ITToolbox."
}
output "resource_group_location" {
  value       = azurerm_resource_group.ITToolbox_rg.location
  description = "The location of the resource group where the ITToolbox is deployed."

}
output "automation_account_name" {
  value       = azurerm_automation_account.ITToolbox_automation_account.name
  description = "The name of the Azure Automation account for ITToolbox."
}
output "automation_account_id" {
  value       = azurerm_automation_account.ITToolbox_automation_account.id
  description = "The ID of the Azure Automation account for ITToolbox."
}

output "runbook_global_admins_id" {
  value       = azurerm_automation_runbook.ITToolbox_runbook.id
  description = "The ID of the runbook for getting Global Admins report."
}

output "runbook_users_pw_id" {
  value       = azurerm_automation_runbook.ITToolbox_runbook_pw.id
  description = "The ID of the runbook for getting Users Password report."
}

output "runbook_app_reg_secret_expiration_id" {
  value       = azurerm_automation_runbook.ITToolbox_runbook_app.id
  description = "The ID of the runbook for getting App Registrations Secret Expiration report."
}   