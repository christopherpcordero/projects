<#
.AUTHOR
    Christopher Cordero
.DATE
    24JUL2025
.VERSION
    1.0.0

.SYNOPSIS
    This script retrieves report of all secrets and their expiration dates in Microsoft 365.
.DESCRIPTION
    This PowerShell script retrieves all application secrets in Microsoft 365 and generates a report of their expiration dates.
    It connects to Microsoft Graph, fetches the application secrets, and formats the output for easy review.
    This script is intended to run as a runbook in Azure Automation.


.PREREQUISITES
    Modules: 
        Microsoft.Graph
        Microsoft.Graph.Applications
        Microsoft.Graph.Authentication


#>

Connect-MgGraph -Identity
$applications = Get-MgApplication -All -Property DisplayName, AppId, PasswordCredentials
$report = @()
foreach ($app in $applications) {
    foreach ($secret in $app.PasswordCredentials) {
        $report += [PSCustomObject]@{
            DisplayName       = $app.DisplayName
            AppId             = $app.AppId
            SecretId          = $secret.KeyId
            StartDate         = $secret.StartDateTime
            ExpirationDate    = $secret.EndDateTime
            DaysUntilExpiration = ($secret.EndDateTime - (Get-Date)).Days
        }
    }
}
$report | Sort-Object ExpirationDate | Format-Table -AutoSize