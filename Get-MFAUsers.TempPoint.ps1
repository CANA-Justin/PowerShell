<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2020 v5.7.180
	 Created on:   	08/19/2020 9:41 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>


Get-ADUser -Filter 'Name -like "holmesj"' | FT Name, SamAccountName
