<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.168
	 Created on:   	11/05/2019 10:43 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	Energy-MakeProposalProject.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>


."\\canagroup.cana-group\SYSVOL\canagroup.cana-group\scripts\Powershell\Energy\IsMember.ps1"

function Confirm-Authorized
{
	[CmdletBinding()]
	[OutputType([switch])]
	param ()
	
	Write-Debug "Checking if a member of Energy.Script.Authority"
	If (IsMember("Energy.Script.Authority"))
	{
		Write-Verbose "User is a member of Energy.Script.Authority"
		Write-Debug "User is a member of Energy.Script.Authority"
		Write-Host "Another window should have popped up to create the script"
		Write-Host "You may close this window."
		Start-MainScript
	}
	Else
	{
		Write-Verbose "User is NOT a member of Energy.Script.Authority"
		Write-Debug "User is NOT a member of Energy.Script.Authority"
		Write-Host "You do not appear to have access to run this script."
		Write-Host "If you were givin access recently, you **NEED** to logoff and back on again, or reboot."
		Write-Host "Please contact CANA Helpdesk.  (587) 291-4000, helpdesk@cana.ca, or make an IT Ticket."
		Pause
		Exit
	}
	
}

<#
	.SYNOPSIS
		This is the main part of the script
	
	.DESCRIPTION
		This is the main part of the script.  Opening a new powershell
	
	.EXAMPLE
				PS C:\> Start-MainScript
	
	.NOTES
		Additional information about the function.
#>
function Start-MainScript
{
	[CmdletBinding()]
	param ()
	
	
	$ProjectNumber = Read-host "Please enter the projects Number (6 Numbers)"
	$ProjectDiscription = Read-host "Please enter the projects Discription"
	$ProjectName
	$ClientName = @(Get-ChildItem \\canagroup.cana-group\business\Energy\Clients | Out-GridView -Title 'Choose a file' -PassThru)
	
	#-----
	# Setting path location so that this script can be run remotly
	#
	Set-Location -Path "\\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals\Active\"
	#
	#-----
	

	#-----
	#
	Write-host "Creating job folder $ProjectName"
	Write-Verbose "Creating $ProjectName"
	mkdir $ProjectName
	Write-Verbose "Removing Inheritance from $ProjectName"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName /inheritance:r
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ProjectName with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName /T /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ProjectName with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName /T /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName with (CI)(OI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName /T /GRANT "tfa.Energy.READ:(CI)(OI)(RX)"
	#-----
	
	#-----
	#
	Write-Verbose "Creating $ProjectName\Submission"
	mkdir $ProjectName\Submission
	Write-Verbose "Creating $ProjectName\Submission\Draft"
	mkdir $ProjectName\Submission\Draft
	Write-Verbose "Creating $ProjectName\Submission\Final"
	mkdir $ProjectName\Submission\Final
	Write-Verbose "Creating $ProjectName\Procurement\Expediting"
	mkdir $ProjectName\Procurement\Expediting
	Write-Verbose "Creating $ProjectName\Procurement\Purchase Orders"
	mkdir $ProjectName\Procurement\"Purchase Orders"
	Write-Verbose "Creating $ProjectName\Procurement\Purchase Orders\RFQ"
	mkdir $ProjectName\Procurement\"Purchase Orders"\RFQ
	Write-Verbose "Creating $ProjectName\Procurement\Purchase Orders\RFPO"
	mkdir $ProjectName\Procurement\"Purchase Orders"\RFPO
	Write-Verbose "Creating $ProjectName\Procurement\Subcontracts"
	mkdir $ProjectName\Procurement\Subcontracts
	Write-Verbose "Creating $ProjectName\Procurement\Subcontracts\RFQ"
	mkdir $ProjectName\Procurement\Subcontracts\RFQ
	Write-Verbose "Creating $ProjectName\Procurement\Subcontracts\RFPO"
	mkdir $ProjectName\Procurement\Subcontracts\RFPO
	
	
}




Confirm-Authorized
