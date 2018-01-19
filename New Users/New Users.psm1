<#	
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2017 v5.4.145
	 Created on:   	01/03/2018 11:28 AM
	 Created by:   	admJustin
	 Organization: 	
	 Filename:     	New Users.psm1
	-------------------------------------------------------------------------
	 Module Name: New Users
	===========================================================================
#>



function Write-HelloWorld
{
	clear
	#Clearing the screen because
	
	$FirstName = $null
	$LastName = $null
	$ReportsTo = $null
	$CompanyNumber = $null
	$Username = $null
	$FullName = $null
	#Clearing varables for use
	
	Write-Host " /¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\"
	Write-Host "|" -nonewline
	Write-Host " CANA " -foreground Yellow -nonewline
	Write-Host "New User creation scrip v0.01  |"
	Write-Host " \___________________________________/"
	Write-Host
	
	$FirstName = Read-Host -Prompt 'Paste the First Name of the user'
	$LastName = Read-Host -Prompt 'Paste the Lastname of the user'
	$ReportsTo = Read-Host -Prompt 'Paste who the user Reports To'
	$CompanyNumber = Read-Host -Prompt 'Enter the Company Number the user belongs to'
	$JobRoll = Read-Host -Prompt 'Enter the Roll the user belongs to'
	$Username = $Lastname + $Firstname.substring(0, 1)
	$FullName = "$FirstName $LastName"
	$Username = $Username.ToLower()
	
	Write-Host You wrote $FullName, with a username of $Username reports to $ReportsTo in Company $CompanyNumber
	
	
	$InAD = Get-ADUser -Filter { sAMAccountName -eq $Username }
	If ($InAD -eq $Null) { "User does not exist in AD" }
	Else { "User found in AD" }
}

Export-ModuleMember -Function Write-HelloWorld



