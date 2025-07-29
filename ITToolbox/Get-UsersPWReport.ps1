<#
    .AUTHOR
    Christopher Cordero

    .VERSION
    1.0.0
    
    .DATE
    24JUL2025

    .SYNOPSIS
    Generates a report of user passwords in the system.
    .DESCRIPTION
    This script retrieves user password information and generates a report.Intended to run as a runbook in Azure Automation.

    .PREREQUISITES
    Ensure you have the necessary permissions to access user password information.
    Modules:
    - Microsoft.Graph
    - Microsoft.Graph.authentication
    - micorsoft.graph.users
    - microsoft.graph.users.authentication


#>

Connect-MgGraph -Identity
$users = Get-MgUser -All -Property DisplayName, UserPrincipalName, SignInActivityDateTime, PasswordPolicies, PasswordProfile
$passwordAge = 90
$today = Get-Date

$report = @()

foreach ($user in $users) {
    $userExpirationDate = $user.PasswordProfile.PasswordExpirationDateTime.AddDays($passwordAge)
    $daysUntilExpiration = ($userExpirationDate - $today).Days

    $report += [PSCustomObject]@{
        DisplayName          = $user.DisplayName
        UserPrincipalName    = $user.UserPrincipalName
        SignInActivityDateTime = $user.SignInActivityDateTime
        PasswordPolicies     = $user.PasswordPolicies
        PasswordExpirationDate = $userExpirationDate
        DaysUntilExpiration  = $daysUntilExpiration
    }

}

