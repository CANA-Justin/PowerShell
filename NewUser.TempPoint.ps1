<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.159
	 Created on:   	02/19/2019 11:58 AM
	 Created by:   	admJustin
	 Organization: 	
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

$GivenName
$FirstName="Justin"
$SirName="Van Holmes"
$UserName



function MakeUsername () {
	$UserName = $SirName + $FirstName.substring(0, 1)
	$UserName = $UserName.ToLower()
	if ($UserName -match "\s") { Write-host "This UserName contains a white space" }
	if ($UserName -match "-") { Write-host "This UserName contains a dash" }
	Write-Host $UserName
	
	$UserName = $UserName -replace '(\s)', ''
	
	Write-Host $UserName
	
	CheckUserName
}

function CheckUserName ()
{
	
	$user = Get-ADUser -filter { sAMAccountName -eq $UserName }
	
	if (!$user)
	{
		Write-Error "This username does not exist"
		exit # or return, whatever is appropriate
	}
	
	
}

MakeUsername


