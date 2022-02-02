<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.159
	 Created on:   	01/03/2016
	 Created by:   	Kevin George
	 Organization: 	CANA IT
	 Filename:     	
	===========================================================================
	.SYNOPSIS
		This is run before the User Account is created to make the needed directories for the user and scans folder.

	.DESCRIPTION
		
		Modified Feb 22, 2019 - MP - updated paths from E: to R:
		Modified March 07, 2019 by Justin Holmes: Updated script to check for running user and cleaned up script.

	.PARAMETER Username
		Add the username in lower case.  Our username standard is lastnameFirstInitial (smithj) for John Smith.
		
	.EXAMPLE
		1_HomedriveFolder.ps1

	.EXAMPLE
		1_HomedriveFolder.ps1 -Username smithj
#>



function Test-Administrator
{
	[CmdletBinding()]
	$user = [Security.Principal.WindowsIdentity]::GetCurrent();
	(New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
	
	
	## If PASSED administrator privileges check
	If (Test-Administrator -eq $True)
	{
		If ($verbose -eq $True)
		{
			Write-host "Running user" -NoNewline
			Write-host " Does " -ForegroundColor Green -NoNewline
			Write-host "have administrator privileges!"
		}
		
	Create-UserDirectories
	}
	## If FAILED administrator privileges check
	Else
	{
		Write-host "Running user" -NoNewline
		Write-host " Does Not " -ForegroundColor Red -NoNewline
		Write-host "have administrator privileges!"
		Write-host "Operation is aborting!"
		
	Exit
		
	}
}

function Create-UserDirectories 
{
	
	
	[CmdletBinding()]
	param
	(	[Parameter(Mandatory = $true, position = 0)]
		[String]$FolderName = $(Read-host "Username"))
	#$name = "canagroup\admkevin"
	Write-Verbose **** Creating Directories for the new user ****

	# Creating User Folder Folder
	MKDir R:\"Home Drive"\$FolderName
	Write-Debug -Message "Creating folder R:\Home Drive\"$FolderName""
	
	Write-Verbose  **** Disable inheritance and Remove Permission on the top user folder ****
	& ICACLS R:\"Home Drive"\$FolderName /inheritance:r
	Write-Debug -Message "Removing folder inheritance on R:\Home Drive\"$FolderName""
	# setup basic permissions for all folders.
	
	& ICACLS R:\"Home Drive"\$FolderName /T /Grant "administrator:(CI)(OI)(F)"
	Write-Debug -Message "Granting folder permission to LOCAL\Administrator on R:\Home Drive\"$FolderName""
	
	MKDir R:\"Home Drive"\$FolderName\"My Documents"
	Write-Debug -Message "Creating folder R:\Home Drive\"$FolderName"\My Documents"
	MKDir R:\"Home Drive"\$Foldername\"My Documents\Scans"
	Write-Debug -Message "Creating folder R:\Home Drive\"$FolderName"\My Documents\Scans"
	
	& ICACLS R:\"Home Drive"\$FolderName /T /Grant "Ricoh:(CI)(OI)(RX)"
	Write-Debug -Message "Granting folder permissions to canagroup\Richo to R:\Home Drive\"$FolderName""
	& ICACLS R:\"Home Drive"\$FolderName /T /Grant "svcHTIscan:(CI)(OI)(RX)"
	Write-Debug -Message "Granting folder permissions to canagroup\svcHTIscan to  R:\Home Drive\"$FolderName""
	& ICACLS R:\"Home Drive"\$FolderName /T /Grant "Domain Admins:(CI)(OI)(F)"
	Write-Debug -Message "Granting folder permissions to canagroup\Domain Admins to  R:\Home Drive\"$FolderName""
	& ICACLS R:\"Home Drive"\$FolderName\"My Documents\Scans" /T /Grant "Ricoh:(CI)(OI)(RX,W,D)"
	Write-Debug -Message "Granting folder permissions to canagroup\Richo to R:\Home Drive\"$FolderName"\My Documents\Scans"
	
	
	
	Write-Host "Copy this to user profile in AD"
	Write-Host -BackgroundColor Black"                                                              "
	Write-Host -ForegroundColor Red -BackgroundColor Black "\\canagroup.cana-group\homedrive\users\%username%\My Documents"
	Write-Host -BackgroundColor Black"                                                              "
	Write-Host "Press Any key to grant newly created user permission to R:\Home Drive\"$FolderName""
	
	# Run this after the User Account is created.
	
	Pause
	
	Start-Sleep -Seconds 5
	
	& ICACLS R:\"Home Drive"\$FolderName /T /Grant $Foldername":(CI)(OI)(F)"
	Write-Debug -Message "Granting folder permissions to canagroup\"$Username" to R:\Home Drive\"$FolderName""
	
	
	
}

Test-Administrator
