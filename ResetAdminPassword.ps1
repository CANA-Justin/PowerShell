<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.163
	 Created on:   	06/07/2019 9:12 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	ResetAdminPassword.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

$user = Administrator
$Password = P@ssw0rd
Set-ADAccountPassword -Identity $user -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$Password" -Force)
