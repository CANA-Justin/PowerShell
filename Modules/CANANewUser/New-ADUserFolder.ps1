<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.160
	 Created on:   	04/11/2019 12:07 PM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	New-ADUserFolder.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>


function New-ADUserFolder
{
	param
	(
		[Parameter(Mandatory = $true)]
		[String]$FolderName = $args[0]
	)
	Write-Debug "Creating home folder"
	Write-Verbose "Creating home folder and setting permissions"
	
	MKDir R:\"Home Drive"\$FolderName
	
	Write-Debug "Setting folder permissions for Administrators"
	
	& ICACLS R:\"Home Drive"\$FolderName /inheritance:r
	& ICACLS R:\"Home Drive"\$FolderName /T /Grant "administrator:(CI)(OI)(F)"
	
	Write-Debug "Creating My Documents and Scans folder"
	
	MKDir R:\"Home Drive"\$FolderName\"My Documents"
	MKDir R:\"Home Drive"\$Foldername\"My Documents\Scans"
	
	Write-Debug "Setting folder permissions for Scans user Ricoh"
	
	& ICACLS R:\"Home Drive"\$FolderName /T /Grant "Ricoh:(CI)(OI)(RX)"
	& ICACLS R:\"Home Drive"\$FolderName /T /Grant "svcHTIscan:(CI)(OI)(RX)"
	& ICACLS R:\"Home Drive"\$FolderName /T /Grant "Domain Admins:(CI)(OI)(F)"
	& ICACLS R:\"Home Drive"\$FolderName\"My Documents\Scans" /T /Grant "Ricoh:(CI)(OI)(RX,W,D)"
	
}
	