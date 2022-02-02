<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.159
	 Created on:   	03/27/2019 7:39 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	Get-GroupsOfUser.ps1
	===========================================================================
	.DESCRIPTION
		Enter the username and a list of the users group memberships will be printed to screen.
#>


$Username = Read-host "Enter username"
$Groups = (Get-ADUser $Username –Properties MemberOf | Select-Object MemberOf).MemberOf
$Groups | Get-ADGroup | Select-Object name | Sort-Object name