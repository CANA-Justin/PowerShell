<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.163
	 Created on:   	05/29/2019 1:21 PM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	Get-AllMembersofSecurityGroups.ps1
	===========================================================================
	.DESCRIPTION
		This script will 
#>

Get-ADGroup -Filter {
	name -like "*READ"
} | Foreach-object {
	$group = $_
	Get-ADGroupMember $_ -Recursive | select-object saMAccountName, Name | Export-Csv -Path C:\Temp\$group.csv -NoTypeInformation #| format-table -autosize
}