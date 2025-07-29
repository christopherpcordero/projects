<#
Identify Entra Users that have expired passwords

Christopher Cordero
#>


Import-Module -Name Microsoft.Graph.Users
Connect-MgGraph -Identity
$allUsers = Get-MgUser -All -Property DisplayName, UserPrincipalName, LastPasswordChangeDateTime, AccountEnabled
	| Where-Object {$_.AccontEnabled -eq $true} 
	| Select-Object DisplayName, UserPrincipalName, LastPasswordChangeDateTime

$expiredUsers = @()
$maxDays = 90
$today = Get-Date

foreach ($user in $allUsers){
	$expirationDate = ($user.LastPasswordChangeDateTime).AddDays($maxDays)
	$daysLeft = ($expirationDate - $today).Days
	if($daysLeft -le 0){
		$expiredUsers += @{
			DisplayName = $user.DisplayName
			Email = $user.UserPrincipalName
			Expiration Date = $expirationDate
			Days Left = $daysLeft
		}
	}	
}
