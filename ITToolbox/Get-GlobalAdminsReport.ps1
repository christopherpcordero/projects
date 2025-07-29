<#

.AUTHOR
Christopher Cordero
.DATE
24JUL2025
.VERSION
1.0.0


.SYNOPSIS
This script gets all users with Global Admin role in Microsoft 365.
.DESCRIPTION
This PowerShell script retrieves all users who have the Global Administrator role in Microsoft 365. Using Microsoft Graph, 
it fetches the role assignments and filters for those with the Global Admin role.It also retrieves the user details for each Global Admin such as last sign-in time and display name.
This script is inteded to run as a runbook in Azure Automation.


.PREREQUISITES
Module: 
    Microsoft.Graph
    Microsoft.Graph.Identity.DirectoryManagement
    Microsoft.Graph.Users
    Microsoft.Graph.Authentication



#>

Connect-MgGraph -Identity
$globalAdminRoleId = (Get-MgDirectoryRole | Where-Object { $_.DisplayName -eq "Global Administrator" }).Id
$globalAdmins = Get-MgDirectoryRoleMember -DirectoryRoleId $globalAdminRoleId -All | ForEach-Object {
    Get-MgUser -UserId $_.Id -Property DisplayName, UserPrincipalName, SignInActivity
}

$report = @()
foreach ($admin in $globalAdmins) {
    $report += [PSCustomObject]@{
        DisplayName          = $admin.DisplayName
        UserPrincipalName    = $admin.UserPrincipalName
        LastSignInDateTime   = $admin.SignInActivity.LastSignInDateTime
    }
}   

