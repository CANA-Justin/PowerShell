<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2017 v5.4.145
	 Created on:   	01/03/2018 3:01 PM
	 Created by:   	admJustin
	 Organization: 	
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
Import-Module ActiveDirectory
Get-ADUser -filter { Enabled -eq $True -and PasswordNeverExpires -eq $False } –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed" |
Select-Object -Property samAccountName, @{ Name = "ExpiryDate"; Expression = { [datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed") } }