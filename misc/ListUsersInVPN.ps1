<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2020 v5.7.177
	 Created on:   	05/26/2020 11:41 AM
	 Created by:   	admJustin
	 Organization: 	
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

Import-Module ActiveDirectory

#GET-ADUSER -filter * -properties ThumbnailPhoto | Where { $_.ThumbnailPhoto -eq $TRUE }
$FilePath = New-Object -Typename System.Windows.Forms.SaveFileDialog
$FilePath.ShowDialog()
Get-ADGroupMember -Identity "VPN_Access" | Select-Object -Property ThumbnailPhoto,GivenName,Surname #| Export-Csv -Path $FilePath -NoTypeInformation