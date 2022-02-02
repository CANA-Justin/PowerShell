<#	
	.NOTES
	===========================================================================
	 Created on:   	08/20/2019 8:11 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA
	 Filename:     	Energy-ProjectFolders.ps1
	===========================================================================
	.DESCRIPTION
		This file will setup a project folder in the requested Client directory.
#>



."\\canagroup.cana-group\SYSVOL\canagroup.cana-group\scripts\Powershell\Energy\IsMember.ps1"
<#
	.SYNOPSIS
		Bypass check for group membership.
	
	.DESCRIPTION
		Bypass check for group membership. Useful if you want to run the scrip as the logged on user to create the actual file scructure (ie. ADM account)
	
	.EXAMPLE
				PS C:\> Switch-NoElevate
	
	.OUTPUTS
		Switch
	
	.NOTES
		Additional information about the function.
#>
function Switch-NoElevate
{
	[CmdletBinding()]
	[OutputType([Switch], ParameterSetName = 'NoElevate')]
	[OutputType([switch])]
	param ()
	
	switch ($PsCmdlet.ParameterSetName)
	{
		'NoElevate' {
			#TODO: Place script here
			break
		}
	}
	
}

<#
	.SYNOPSIS
		Checks if user is part of security group
	
	.DESCRIPTION
		Checks if user is a part of the security group that is allowed to run the script.  If not a part of the group, script will terminate with error.
	
	.EXAMPLE
				PS C:\> Confirm-Authorized
	
	.NOTES
		Additional information about the function.
#>
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


function Start-MainScript
{
	[CmdletBinding()]
	param ()
	
	
	Write-Host "-------------------"
	Write-Host "|   Make Project  |"
	Write-Host "-------------------"
	Write-Host ""
	
	
	$ProjectName = Read-host "Please enter the projects name"
	$ClientName = @(Get-ChildItem \\canagroup.cana-group\business\Energy\Clients | Out-GridView -Title 'Choose a file' -PassThru)
	
	#-----
	# Setting path location so that this script can be run remotly
	#
	Set-Location -Path "\\canagroup.cana-group\business\Energy\Clients\$ClientName\Active Projects\"
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
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName with (CI)(OI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName /T /GRANT "tfa.Energy.RWED:(CI)(OI)(RX)"
	#-----
	
	#-----
	#
	Write-Verbose "Creating $ProjectName\Procurement"
	mkdir $ProjectName\Procurement
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
	
	
	Write-Verbose "Removing Inheritance from $ProjectName\Procurement\"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Procurement with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement /GRANT "tfa.Energy.RWED:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Procurement with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Removing Inheritance from $ProjectName\Procurement\Expediting"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement\Expediting /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Procurement\Expediting with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement\Expediting /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Procurement\Expediting with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement\Expediting /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Procurement\Purchase Orders\RFQ"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement\"Purchase Orders"\RFQ /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Procurement\Purchase Orders\RFQ with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement\"Purchase Orders"\RFQ /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Procurement\Purchase Orders\RFQ with (OI)(CI)(RM)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement\"Purchase Orders"\RFQ /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Procurement\Purchase Orders\RFPO"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement\"Purchase Orders"\RFPO /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Procurement\Purchase Orders\RFPO with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement\"Purchase Orders"\RFPO /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Procurement\Purchase Orders\RFPO with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement\"Purchase Orders"\RFPO /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Procurement\Subcontracts\RFQ"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement\Subcontracts\RFQ /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Procurement\Subcontracts\RFQ with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement\Subcontracts\RFQ /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Procurement\Subcontracts\RFQ with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement\Subcontracts\RFQ /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Procurement\Subcontracts\RFPO"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement\Subcontracts\RFPO /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Procurement\Subcontracts\RFPO with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement\Subcontracts\RFPO /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Procurement\Subcontracts\RFPO with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Procurement\Subcontracts\RFPO /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	
	#Write-Verbose "Copies MakeProposalProject shortcut to $ClientName\Proposals\Active"
	#Copy-Item -Path \\canagroup.cana-group\sysVOL\canagroup.cana-group\scripts\Powershell\Energy\MakeNewSubContract.lnk -Destination \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Active Projects"\$ProjectName\Procurement\Subcontracts
	#Write-Verbose "Copies MakeProposalProject shortcut to $ClientName\Proposals\Active"
	#Copy-Item -Path \\canagroup.cana-group\sysVOL\canagroup.cana-group\scripts\Powershell\Energy\MakeNewPO.lnk -Destination \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Active Projects"\$ProjectName\Procurement\"Purchase Orders"
	
	
	
	#-----
	
	#-----
	#
	Write-Verbose "Creating $ProjectName\Document Control"
	mkdir $ProjectName\"Document Control"
	Write-Verbose "Creating $ProjectName\Document Control\ICR"
	mkdir $ProjectName\"Document Control"\ICR
	Write-Verbose "Creating $ProjectName\Document Control\IFR"
	mkdir $ProjectName\"Document Control"\IFR
	Write-Verbose "Creating $ProjectName\Document Control\Transmittals"
	mkdir $ProjectName\"Document Control"\Transmittals
	Write-Verbose "Creating $ProjectName\Document Control\Site Inspection"
	mkdir $ProjectName\"Document Control\Site Inspection"
	Write-Verbose "Creating $ProjectName\Document Control\IFC"
	mkdir $ProjectName\"Document Control"\IFC
	Write-Verbose "Creating $ProjectName\Document Control\RFI"
	mkdir $ProjectName\"Document Control"\RFI
	Write-Verbose "Removing Inheritance from $ProjectName\Document Control"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Document Control\ICR with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control" /GRANT "tfa.Energy.RWED:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Document Control\ICR with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Removing Inheritance from $ProjectName\Document Control\ICR"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control"\ICR /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Document Control\ICR with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control"\ICR /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Document Control\ICR with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control"\ICR /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Document Control\IFR"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control"\IFR /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Document Control\IFR with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control"\IFR /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Document Control\IFR with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control"\IFR /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Document Control\Transmittals"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control"\Transmittals /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Document Control\Transmittals with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control"\Transmittals /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Document Control\Transmittals with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control"\Transmittals /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Document Control\Site Inspection"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control\Site Inspection" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Document Control\Site Inspection with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control\Site Inspection" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Document Control\Site Inspection with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control\Site Inspection" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Document Control\IFC"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control\IFC" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Document Control\IFC with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control\IFC" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Document Control\IFC with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control\IFC" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Document Control\Site Inspection with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control\Site Inspection" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Document Control\Site Inspection with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control\Site Inspection" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Document Control\RFI"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control\RFI" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Document Control\RFI with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control\RFI" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Document Control\RFI with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Document Control\RFI" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	#-----
	
	#-----
	Write-Verbose "Creating $ProjectName\Project Development"
	mkdir $ProjectName\"Project Development"
	Write-Verbose "Creating $ProjectName\Project Development\Contract"
	mkdir $ProjectName\"Project Development"\Contract
	Write-Verbose "Creating $ProjectName\Project Development\Final Bid Document"
	mkdir $ProjectName\"Project Development\Final Bid Document"
	Write-Verbose "Removing Inheritance from $ProjectName\Project Development\Contract"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Development" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Project Development\Contract with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Development" /GRANT "tfa.Energy.RWED:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Project Development\Contract with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Development" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Development"\Contract /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Project Development\Contract with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Development"\Contract /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Project Development\Contract with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Development"\Contract /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Project Development\Final Bid Document"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Development\Final Bid Document" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Project Development\Final Bid Document with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Development\Final Bid Document" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Project Development\Final Bid Document with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Development\Final Bid Document" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	#-----
	
	#-----
	Write-Verbose "Creating $ProjectName\Project Controls"
	mkdir $ProjectName\"Project Controls"
	Write-Verbose "Creating $ProjectName\Project Controls\Cost Control"
	mkdir $ProjectName\"Project Controls\Cost Control"
	Write-Verbose "Creating $ProjectName\Project Controls\Client Progress Reports"
	mkdir $ProjectName\"Project Controls\Client Progress Reports"
	Write-Verbose "Creating $ProjectName\Project Controls\Internal Progress Reports"
	mkdir $ProjectName\"Project Controls\Internal Progress Reports"
	Write-Verbose "Creating $ProjectName\Project Controls\Schedule"
	mkdir $ProjectName\"Project Controls\Schedule"
	Write-Verbose "Creating $ProjectName\Project Controls\Change Orders"
	mkdir $ProjectName\"Project Controls\Change Orders"
	Write-Verbose "Creating $ProjectName\Project Controls\Project Setup"
	mkdir $ProjectName\"Project Controls\Project Setup"
	Write-Verbose "Removing Inheritance from $ProjectName\Project Controls"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Project Controls with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls" /GRANT "tfa.Energy.RWED:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Project Controls with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Removing Inheritance from $ProjectName\Project Controls\Cost Control"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Cost Control" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Project Controls\Cost Control with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Cost Control" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Project Controls\Cost Control with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Cost Control" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Project Controls\Client Progress Reports"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Client Progress Reports" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Project Controls\Client Progress Reports with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Client Progress Reports" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Project Controls\Client Progress Reports with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Client Progress Reports" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Project Controls\Internal Progress Reports"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Internal Progress Reports" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Project Controls\Internal Progress Reports with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Internal Progress Reports" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Project Controls\Internal Progress Reports with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Internal Progress Reports" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Project Controls\Schedule"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Schedule" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Project Controls\Schedule with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Schedule" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Project Controls\Schedule with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Schedule" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Project Controls\Change Orders"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Change Orders" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Project Controls\Change Orders with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Change Orders" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Project Controls\Change Orders with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Change Orders" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Project Controls\Project Setup"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Project Setup" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Project Controls\Project Setup with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Project Setup" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Project Controls\Project Setup with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Project Controls\Project Setup" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	#-----
	
	#-----
	Write-Verbose "Creating $ProjectName\Accounting"
	mkdir $ProjectName\Accounting
	Write-Verbose "Creating $ProjectName\Accounting\Progress Billing"
	mkdir $ProjectName\Accounting\"Progress Billing"
	Write-Verbose "Removing Inheritance from $ProjectName\Accounting\Progress Billing"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Accounting\"Progress Billing" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Accounting\Progress Billing with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Accounting\"Progress Billing" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Accounting\Progress Billing with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Accounting\"Progress Billing" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	#-----
	
	#-----
	Write-Verbose "Creating $ProjectName\Engineering"
	mkdir $ProjectName\Engineering
	Write-Verbose "Creating $ProjectName\Engineering\Project Specifications"
	mkdir $ProjectName\Engineering\"Project Specifications"
	Write-Verbose "Creating $ProjectName\Engineering\Geotech and Survey"
	mkdir $ProjectName\Engineering\"Geotech and Survey"
	Write-Verbose "Creating $ProjectName\Engineering\Client Data"
	mkdir $ProjectName\Engineering\"Client Data"
	Write-Verbose "Creating $ProjectName\Engineering\Equipment Data"
	mkdir $ProjectName\Engineering\"Equipment Data"
	Write-Verbose "Creating $ProjectName\Engineering\Bill of Materials"
	mkdir $ProjectName\Engineering\"Bill of Materials"
	Write-Verbose "Creating $ProjectName\Engineering\Disciplines"
	mkdir $ProjectName\Engineering\Disciplines
	Write-Verbose "Creating $ProjectName\Engineering\Disciplines\Scada"
	mkdir $ProjectName\Engineering\Disciplines\Scada
	Write-Verbose "Creating $ProjectName\Engineering\Disciplines\Primary"
	mkdir $ProjectName\Engineering\Disciplines\Primary
	Write-Verbose "Creating $ProjectName\Engineering\Disciplines\Civil"
	mkdir $ProjectName\Engineering\Disciplines\Civil
	Write-Verbose "Creating $ProjectName\Engineering\Disciplines\Protection and Control"
	mkdir $ProjectName\Engineering\Disciplines\"Protection and Control"
	Write-Verbose "Creating $ProjectName\Engineering\Disciplines\CATV"
	mkdir $ProjectName\Engineering\Disciplines\CATV
	Write-Verbose "Creating $ProjectName\Engineering\Disciplines\Structural"
	mkdir $ProjectName\Engineering\Disciplines\Structural
	Write-Verbose "Creating $ProjectName\Engineering\Disciplines\Fiber"
	mkdir $ProjectName\Engineering\Disciplines\Fiber
	Write-Verbose "Creating $ProjectName\Engineering\Disciplines\Telecom"
	mkdir $ProjectName\Engineering\Disciplines\Telecom
	Write-Verbose "Creating $ProjectName\Engineering\Disciplines\Lighting"
	mkdir $ProjectName\Engineering\Disciplines\Lighting
	Write-Verbose "Creating $ProjectName\Engineering\Disciplines\AC and DC"
	mkdir $ProjectName\Engineering\Disciplines\AC-DC
	Write-Verbose "Creating $ProjectName\Engineering\Disciplines\Gas"
	mkdir $ProjectName\Engineering\Disciplines\Gas
	Write-Verbose "Creating $ProjectName\Engineering\Disciplines\Building"
	mkdir $ProjectName\Engineering\Disciplines\Building
	Write-Verbose "Creating $ProjectName\Engineering\Disciplines\Municpality"
	mkdir $ProjectName\Engineering\Disciplines\Municpality
	Write-Verbose "Creating $ProjectName\Engineering\Disciplines\Transmission"
	mkdir $ProjectName\Engineering\Disciplines\Transmission
	Write-Verbose "Creating $ProjectName\Engineering\Studies"
	mkdir $ProjectName\Engineering\Studies
	Write-Verbose "Creating $ProjectName\Engineering\Studies\Grounding"
	mkdir $ProjectName\Engineering\Studies\Grounding
	Write-Verbose "Creating $ProjectName\Engineering\Studies\Lightning Protection"
	mkdir $ProjectName\Engineering\Studies\"Lightning Protection"
	Write-Verbose "Creating $ProjectName\Engineering\Studies\AC and DC"
	mkdir $ProjectName\Engineering\Studies\"AC and DC"
	Write-Verbose "Creating $ProjectName\Engineering\Studies\Insulation Coordination"
	mkdir $ProjectName\Engineering\Studies\"Insulation Coordination"
	Write-Verbose "Creating $ProjectName\Engineering\Studies\ARC Flash"
	mkdir $ProjectName\Engineering\Studies\"ARC Flash"
	Write-Verbose "Creating $ProjectName\Engineering\Studies\Ridgid Bus"
	mkdir $ProjectName\Engineering\Studies\"Ridgid Bus"
	Write-Verbose "Creating $ProjectName\Engineering\Studies\Transmission"
	mkdir $ProjectName\Engineering\Studies\Transmission
	Write-Verbose "Creating $ProjectName\Engineering\Studies\Other"
	mkdir $ProjectName\Engineering\Studies\Other
	Write-Verbose "Creating $ProjectName\Engineering\Drawings"
	mkdir $ProjectName\Engineering\Drawings
	Write-Verbose "Creating $ProjectName\Engineering\Drawings\Drawing list"
	mkdir $ProjectName\Engineering\Drawings\"Drawing list"
	Write-Verbose "Creating $ProjectName\Engineering\Drawings\Markups"
	mkdir $ProjectName\Engineering\Drawings\Markups
	Write-Verbose "Creating $ProjectName\Engineering\Drawings\IFC Original"
	mkdir $ProjectName\Engineering\Drawings\"IFC Original"
	Write-Verbose "Creating $ProjectName\Engineering\Drawings\As-Built Drawings"
	mkdir $ProjectName\Engineering\Drawings\"AS-Build Drawings"
	Write-Verbose "Creating $ProjectName\Engineering\Drawings\Internal Reviews"
	mkdir $ProjectName\Engineering\Drawings\"Internal Reviews"
	
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Project Specifications"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering /GRANT "tfa.Energy.RWED:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering /GRANT "tfa.Energy.RWED:(OI)(CI)(RX)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Project Specifications"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\"Project Specifications" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Project Specifications with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\"Project Specifications" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Project Specifications with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\"Project Specifications" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Geotech and Survey"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\"Geotech and Survey" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Geotech and Survey with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\"Geotech and Survey" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Geotech and Survey with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\"Geotech and Survey" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Client Data"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\"Client Data" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Client Data with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\"Client Data" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Client Data with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\"Client Data" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Equipment Data"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\"Equipment Data" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Equipment Data with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\"Equipment Data" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Equipment Data with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\"Equipment Data" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Bill of Materials"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\"Bill of Materials" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Bill of Materials with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\"Bill of Materials" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Bill of Materials with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\"Bill of Materials" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Disciplines"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Disciplines with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines /GRANT "tfa.Energy.RWED:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Disciplines with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Disciplines\Scada"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Scada /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Disciplines\Scada with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Scada /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Disciplines\Scada with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Scada /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Disciplines\Primary"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Primary /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Disciplines\Primary with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Primary /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Disciplines\Primary with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Primary /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Disciplines\Civil"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Civil /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Disciplines\Civil with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Civil /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Disciplines\Civil with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Civil /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Disciplines\Protection and Control"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\"Protection and Control" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Disciplines\Protection and Control with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\"Protection and Control" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Disciplines\Protection and Control with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\"Protection and Control" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Disciplines\CATV"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\CATV /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Disciplines\CATV with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\CATV /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Disciplines\CATV with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\CATV /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Disciplines\Structural"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Structural /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Disciplines\Structural with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Structural /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Disciplines\Structural with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Structural /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Disciplines\Fiber"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Fiber /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Disciplines\Fiber with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Fiber /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Disciplines\Fiber with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Fiber /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Disciplines\Telecom"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Telecom /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Disciplines\Telecom with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Telecom /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Disciplines\Telecom with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Telecom /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Disciplines\Lighting"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Lighting /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Disciplines\Lighting with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Lighting /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Disciplines\Lighting with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Lighting /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Disciplines\AC and DC"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\"AC and DC" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Disciplines\AC and DC with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\"AC and DC" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Disciplines\AC and DC with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\"AC and DC" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Disciplines\Gas"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Gas /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Disciplines\Gas with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Gas /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Disciplines\Gas with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Gas /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Disciplines\Building"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Building /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Disciplines\Building with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Building /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Disciplines\Building with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Building /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Disciplines\Municpality"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Municpality /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Disciplines\Municpality with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Municpality /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Disciplines\Municpality with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Municpality /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Disciplines\Transmission"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Transmission /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Disciplines\Transmission with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Transmission /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Disciplines\Transmission with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Disciplines\Transmission /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Studies"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Studies with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies /GRANT "tfa.Energy.RWED:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Studies with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Studies\Grounding"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\Grounding /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Studies\Grounding with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\Grounding /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Studies\Grounding with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\Grounding /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Studies\Lightning Protection"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\"Lightning Protection" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Studies\Lightning Protection with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\"Lightning Protection" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Studies\Lightning Protection with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\"Lightning Protection" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Studies\AC-DC"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\AC-DC /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Studies\AC-DC with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\AC-DC /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Studies\AC-DC with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\AC-DC /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Studies\Insulation Coordination"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\"Insulation Coordination" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Studies\Insulation Coordination with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\"Insulation Coordination" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Studies\Insulation Coordination with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\"Insulation Coordination" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Studies\ARC Flash"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\"ARC Flash" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Studies\ARC Flash with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\"ARC Flash" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Studies\ARC Flash with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\"ARC Flash" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Studies\Ridgid Bus"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\"Ridgid Bus" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Studies\Ridgid Bus with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\"Ridgid Bus" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Studies\Ridgid Bus with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\"Ridgid Bus" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Studies\Transmission"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\Transmission /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Studies\Transmission with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\Transmission /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Studies\Transmission with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\Transmission /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Studies\Other"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\Other /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Studies\Other with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\Other /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Studies\Other with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Studies\Other /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Drawings"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Studies\Other with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Studies\Other with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings /GRANT "tfa.Energy.RWED:(OI)(CI)(RX)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Drawings\Drawing List"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings\"Drawing List" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Drawings\Drawing List with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings\"Drawing List" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Drawings\Drawing List with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings\"Drawing List" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Drawings\IFC Original"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings\"IFC Original" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Drawings\IFC Original with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings\"IFC Original" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Drawings\IFC Original with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings\"IFC Original" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Drawings\AS-Built Drawings"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings\"AS-Built Drawings" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Drawings\AS-Built Drawings with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings\"AS-Built Drawings" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Drawings\AS-Built Drawings with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings\"AS-Built Drawings" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Drawings\Internal Reviews"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings\"Internal Reviews" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Drawings\Internal Reviews with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings\"Internal Reviews" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Drawings\Internal Reviews with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings\"Internal Reviews" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Engineering\Drawings\Markups"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings\Markups /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Engineering\Drawings\Markups with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings\Markups /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Engineering\Drawings\Markups with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Engineering\Drawings\Markups /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	
	
	#-----
	
	#-----
	Write-Verbose "Creating $ProjectName\Drafting"
	mkdir $ProjectName\Drafting
	Write-Verbose "Creating $ProjectName\Drafting\Customer In"
	mkdir $ProjectName\Drafting\"Customer In"
	Write-Verbose "Creating $ProjectName\Drafting\WIP"
	mkdir $ProjectName\Drafting\WIP
	Write-Verbose "Creating $ProjectName\Drafting\Review 1"
	mkdir $ProjectName\Drafting\"Review 1"
	Write-Verbose "Creating $ProjectName\Drafting\Review 2"
	mkdir $ProjectName\Drafting\"Review 2"
	Write-Verbose "Creating $ProjectName\Drafting\Review 3"
	mkdir $ProjectName\Drafting\"Review 3"
	Write-Verbose "Creating $ProjectName\Drafting\As Recorded"
	mkdir $ProjectName\Drafting\"As Recorded"
	Write-Verbose "Creating $ProjectName\Drafting\IFC"
	mkdir $ProjectName\Drafting\IFC
	Write-Verbose "Removing Inheritance from $ProjectName\Drafting"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Drafting with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Drafting.READ to $ProjectName\Drafting with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting /GRANT "stfa.Energy.Drafting.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Drafting.RWED to $ProjectName\Drafting with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting /GRANT "stfa.Energy.Drafting.RWED:(OI)(CI)(RX)"
		Write-Verbose "Removing Inheritance from $ProjectName\Drafting\Customer In"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"Customer In" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Drafting\Customer In with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"Customer In" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Drafting.READ to $ProjectName\Drafting\Customer In with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"Customer In" /GRANT "stfa.Energy.Drafting.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Drafting.RWED to $ProjectName\Drafting\Customer In with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"Customer In" /GRANT "stfa.Energy.Drafting.RWED:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Drafting\WIP"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\WIP /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Drafting\WIP with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\WIP /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Drafting.READ to $ProjectName\Drafting\WIP with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\WIP /GRANT "stfa.Energy.Drafting.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Drafting.RWED to $ProjectName\Drafting\WIP with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\WIP /GRANT "stfa.Energy.Drafting.RWED:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Drafting\Review 1"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"Review 1" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Drafting\Review 1 with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"Review 1" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Drafting.READ to $ProjectName\Drafting\Review 1 with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"Review 1" /GRANT "stfa.Energy.Drafting.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Drafting.RWED to $ProjectName\Drafting\Review 1 with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"Review 1" /GRANT "stfa.Energy.Drafting.RWED:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Drafting\Review 2"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"Review 2" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Drafting\Review 2 with (OI)(CI)((RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"Review 2" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Drafting.READ to $ProjectName\Drafting\Review 2 with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"Review 2" /GRANT "stfa.Energy.Drafting.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Drafting.RWED to $ProjectName\Drafting\Review 2 with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"Review 2" /GRANT "stfa.Energy.Drafting.RWED:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Drafting\Review 3"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"Review 3" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Drafting\Review 3 with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"Review 3" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Drafting.READ to $ProjectName\Drafting\Review 3 with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"Review 3" /GRANT "stfa.Energy.Drafting.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Drafting.RWED to $ProjectName\Drafting\Review 3 with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"Review 3" /GRANT "stfa.Energy.Drafting.RWED:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Drafting\As Recorded"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"As Recorded" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Drafting\As Recorded with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"As Recorded" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Drafting.READ to $ProjectName\Drafting\As Recorded with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"As Recorded" /GRANT "stfa.Energy.Drafting.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Drafting.RWED to $ProjectName\Drafting\As Recorded with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\"As Recorded" /GRANT "stfa.Energy.Drafting.RWED:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Drafting\IFC"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\IFC /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Drafting\IFC with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\IFC /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Drafting.READ to $ProjectName\Drafting\IFC with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\IFC /GRANT "stfa.Energy.Drafting.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Drafting.RWED to $ProjectName\Drafting\IFC with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Drafting\IFC /GRANT "stfa.Energy.Drafting.RWED:(OI)(CI)(M)"
	#-----
	
	#-----
	Write-Verbose "Creating $ProjectName\Field Services"
	mkdir $ProjectName\"Field Services"
	Write-Verbose "Creating $ProjectName\Field Services\Safety"
	mkdir $ProjectName\"Field Services"\Safety
	Write-Verbose "Creating $ProjectName\Field Services\Photos"
	mkdir $ProjectName\"Field Services"\Photos
	Write-Verbose "Creating $ProjectName\Field Services\Locates"
	mkdir $ProjectName\"Field Services"\Locates
	Write-Verbose "Creating $ProjectName\Field Services\Reporting"
	mkdir $ProjectName\"Field Services"\Reporting
	Write-Verbose "Creating $ProjectName\Field Services\Environment"
	mkdir $ProjectName\"Field Services"\Environment
	Write-Verbose "Creating $ProjectName\Field Services\Quality"
	mkdir $ProjectName\"Field Services"\Quality
	Write-Verbose "Creating $ProjectName\Field Services\Quality\Dificiency List"
	mkdir $ProjectName\"Field Services"\Quality\"Dificiency List"
	Write-Verbose "Creating $ProjectName\Field Services\Quality\ITP"
	mkdir $ProjectName\"Field Services"\Quality\ITP
	Write-Verbose "Creating $ProjectName\Field Services\Quality\QC"
	mkdir $ProjectName\"Field Services"\Quality\QC
	Write-Verbose "Creating $ProjectName\Field Services\Work Package"
	mkdir $ProjectName\"Field Services"\"Work Package"
	Write-Verbose "Creating $ProjectName\Field Services\Work Package\Execution Plan"
	mkdir $ProjectName\"Field Services"\"Work Package\Execution Plan"
	Write-Verbose "Creating $ProjectName\Field Services\Work Package\Outage Request"
	mkdir $ProjectName\"Field Services"\"Work Package\Outage Request"
	Write-Verbose "Creating $ProjectName\Field Services\Work Package\Bill of Materials"
	mkdir $ProjectName\"Field Services"\"Work Package"\"Bill of Materials"
	Write-Verbose "Creating $ProjectName\Field Services\Work Package\IFC Drawings"
	mkdir $ProjectName\"Field Services"\"Work Package"\"IFC Drawings"
	Write-Verbose "Creating $ProjectName\Field Services\Work Package\DBM"
	mkdir $ProjectName\"Field Services"\"Work Package"\DBM
	Write-Verbose "Creating $ProjectName\Field Services\Work Package\Work Summaries"
	mkdir $ProjectName\"Field Services"\"Work Package"\"Work Summaries"
	Write-Verbose "Creating $ProjectName\Field Services\Work Package\Vender Drawings"
	mkdir $ProjectName\"Field Services"\"Work Package"\"Vender Drawings"
	Write-Verbose "Creating $ProjectName\Field Services\Work Package\Acceptance Forms"
	mkdir $ProjectName\"Field Services"\"Work Package"\"Acceptance Forms"
	Write-Verbose "Creating $ProjectName\Field Services\Work Package\Grounding Evaluation"
	mkdir $ProjectName\"Field Services"\"Work Package"\"Grounding Evaluation"
	
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Safety"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Safety /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Safety with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Safety /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Safety with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Safety /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Photos"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Photos /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Photos with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Photos /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Photos with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Photos /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Locates"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Locates /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Locates with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Locates /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Locates with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Locates /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Reporting"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Reporting /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Reporting with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Reporting /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Reporting with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Reporting /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Environment"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Environment /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Environment with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Environment /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Environment with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Environment /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Quality\Dificiency List"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Quality\"Dificiency List" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Quality\Dificiency List with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Quality\"Dificiency List" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Quality\Dificiency List with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Quality\"Dificiency List" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Quality\ITP"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Quality\ITP /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Quality\ITP with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Quality\ITP /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Quality\ITP with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Quality\ITP /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Quality\QC"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Quality\QC /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Quality\QC with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Quality\QC /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Quality\QC with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\Quality\QC /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Work Package\Execution Plan"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package\Execution Plan" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Work Package\Execution Plan with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package\Execution Plan" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Work Package\Execution Plan with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package\Execution Plan" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Work Package\Outage Request"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package\Outage Request" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Work Package\Outage Request with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package\Outage Request" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Work Package\Outage Request with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package\Outage Request" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Work Package\Outage Request"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package\Outage Request" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Work Package\Outage Request with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package\Outage Request" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Work Package\Outage Request with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package\Outage Request" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Work Package\Bill of Materials"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"Bill of Materials" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Work Package\Bill of Materials with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"Bill of Materials" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Work Package\Bill of Materials with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"Bill of Materials" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Work Package\IFC Drawings"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"IFC Drawings" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Work Package\IFC Drawings with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"IFC Drawings" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Work Package\IFC Drawings with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"IFC Drawings" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Work Package\DBM"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\DBM /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Work Package\DBM with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\DBM /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Work Package\DBM with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\DBM /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Work Package\Work Summaries"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"Work Summaries" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Work Package\Work Summaries with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"Work Summaries" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Work Package\Work Summaries with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"Work Summaries" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Work Package\Vender Drawings"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"Vender Drawings" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Work Package\Vender Drawings with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"Vender Drawings" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Work Package\Vender Drawings with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"Vender Drawings" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Work Package\Acceptance Forms"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"Acceptance Forms" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Work Package\Acceptance Forms with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"Acceptance Forms" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Work Package\Acceptance Forms with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"Acceptance Forms" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Field Services\Work Package\Grounding Evaluation"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"Grounding Evaluation" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Field Services\Work Package\Grounding Evaluation with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"Grounding Evaluation" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Field Services\Work Package\Grounding Evaluation with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Field Services"\"Work Package"\"Grounding Evaluation" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	
	#-----
	
	#-----
	Write-Verbose "Creating $ProjectName\Close Out"
	mkdir $ProjectName\"Close Out"
	Write-Verbose "Creating $ProjectName\Close Out\External Close"
	mkdir $ProjectName\"Close Out\External Close"
	Write-Verbose "Creating$ProjectName\Close Out\As-Builts"
	mkdir $ProjectName\"Close Out"\As-Builts
	Write-Verbose "Creating $ProjectName\Close Out\Warranty"
	mkdir $ProjectName\"Close Out"\Warranty
	Write-Verbose "Creating $ProjectName\Close Out\Return Data"
	mkdir $ProjectName\"Close Out\Return Data"
	Write-Verbose "Creating $ProjectName\Close Out\Lessons Learnt"
	mkdir $ProjectName\"Close Out\Lessons Learnt"
	Write-Verbose "Creating $ProjectName\Close Out\Internal Close"
	mkdir $ProjectName\"Close Out\Internal Close"
	Write-Verbose "Removing Inheritance from $ProjectName\Close Out"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out\" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Close Out with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out\" /GRANT "tfa.Energy.RWED:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Close Out with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out\" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Removing Inheritance from $ProjectName\Close Out\External Close"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out\External Close" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Close Out\External Close with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out\External Close" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Close Out\External Close with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out\External Close" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Close Out\As-Builts"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out"\As-Builts /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Close Out\As-Builts with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out"\As-Builts /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Close Out\As-Builts with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out"\As-Builts /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Close Out\Warranty"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out"\Warranty /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Close Out\Warranty with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out"\Warranty /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Close Out\Warranty with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out"\Warranty /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Close Out\Return Data"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out\Return Data" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Close Out\Return Data with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out\Return Data" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Close Out\Return Data with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out\Return Data" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Close Out\Lessons Learnt"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out\Lessons Learnt" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Close Out\Lessons Learnt with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out\Lessons Learnt" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Close Out\Lessons Learnt with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out\Lessons Learnt" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Close Out\Internal Close"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out\Internal Close" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Close Out\Internal Close with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out\Internal Close" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Close Out\Internal Close with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Close Out\Internal Close" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	
	#-----
	
	#-----
	Write-Verbose "Creating $ProjectName\Meeting Minutes"
	mkdir $ProjectName\"Meeting Minutes"
	Write-Verbose "Creating $ProjectName\Meeting Minutes\Internal"
	mkdir $ProjectName\"Meeting Minutes"\Internal
	Write-Verbose "Creating $ProjectName\Meeting Minutes\External"
	mkdir $ProjectName\"Meeting Minutes"\External
	Write-Verbose "Removing Inheritance from $ProjectName\Meeting Minutes"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Meeting Minutes" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Meeting Minutes with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Meeting Minutes" /GRANT "tfa.Energy.RWED:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Meeting Minutes with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Meeting Minutes" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Removing Inheritance from $ProjectName\Meeting Minutes\Internal"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Meeting Minutes"\Internal /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Meeting Minutes\Internal with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Meeting Minutes"\Internal /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Meeting Minutes\Internal with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Meeting Minutes"\Internal /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Meeting Minutes\External"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Meeting Minutes"\External /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Meeting Minutes\External with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Meeting Minutes"\External /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Meeting Minutes\External with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Meeting Minutes"\External /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	#-----
	
	#-----
	Write-Verbose "Creating $ProjectName\Correspondence"
	mkdir $ProjectName\Correspondence
	Write-Verbose "Removing Inheritance from $ProjectName\Correspondence"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Correspondence /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Correspondence with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Correspondence /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Correspondence with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Correspondence /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	#-----
	
	#-----
	Write-Verbose "Creating $ProjectName\Regulatory"
	mkdir $ProjectName\Regulatory
	Write-Verbose "Removing Inheritance from $ProjectName\Regulatory"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Regulatory /inheritance:r
	Write-Verbose "Granting permission for stfa.Energy.Regulatory.READ to $ProjectName\Regulatory with (CI)(OI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Regulatory /T /GRANT "stfa.Energy.Regulatory.READ:(CI)(OI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Regulatory.RWED to $ProjectName\Regulatory with (CI)(OI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\Regulatory /T /GRANT "stfa.Energy.Regulatory.RWED:(CI)(OI)(M)"
	#-----
	
	#-----
	Write-Verbose "Creating $ProjectName\Testing and Commissioning"
	mkdir $ProjectName\"Testing and Commissioning"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Working"
	mkdir $ProjectName\"Testing and Commissioning"\Working
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Working\Equitment Testing"
	mkdir $ProjectName\"Testing and Commissioning"\Working\"Equitment Testing"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Working\Equitment Testing\CT Tests"
	mkdir $ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\CT Tests"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Working\Equitment Testing\IR Scans"
	mkdir $ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\IR Scans"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Working\Equitment Testing\LA Tests"
	mkdir $ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\LA Tests"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Working\Equitment Testing\NGR Nameplates"
	mkdir $ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\NGR Nameplates"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Working\Equitment Testing\PT Tests"
	mkdir $ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\PT Tests"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Working\Equitment Testing\Transformer Tests"
	mkdir $ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\Transformer Tests"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Working\Protection and Control"
	mkdir $ProjectName\"Testing and Commissioning"\Working\"Protection and Control"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Working\Protection and Control\SCADA Documents"
	mkdir $ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"SCADA Documents"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Working\Protection and Control\Module Pictures"
	mkdir $ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"Module Pictures"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Working\Protection and Control\Load Readings and Voltage Checks"
	mkdir $ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"Load Readings and Voltage Checks"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Working\Protection and Control\QA QC and Record Sheets"
	mkdir $ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"QA QC and Record Sheets"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Working\Protection and Control\Functional Data"
	mkdir $ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"Functional Data"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Working\Protection and Control\CT LO OHMS"
	mkdir $ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"CT LO OHMS"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Final"
	mkdir $ProjectName\"Testing and Commissioning"\Final
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Final\Protection and Control"
	mkdir $ProjectName\"Testing and Commissioning"\Final\"Protection and Control"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Final\Protection and Control\CT LO OHMS"
	mkdir $ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"CT LO OHMS"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Final\Protection and Control\Element Test"
	mkdir $ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"Element Test"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Final\Protection and Control\Functional Data"
	mkdir $ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"Functional Data"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Final\Protection and Control\Load Readings Voltage Checks"
	mkdir $ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"Load Readings Voltage Checks"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Final\Protection and Control\SCADA Documents"
	mkdir $ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"SCADA Documents"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Final\Protection and Control\Scanned QA-QC Documentation"
	mkdir $ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"Scanned QA-QC Documentation"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Final\Equitment Testing"
	mkdir $ProjectName\"Testing and Commissioning"\Final\"Equitment Testing"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Final\Equitment Testing\CT Tests"
	mkdir $ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\CT Tests"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Final\Equitment Testing\IR Scans"
	mkdir $ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\IR Scans"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Final\Equitment Testing\LA Tests"
	mkdir $ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\LA Tests"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Final\Equitment Testing\PT Tests"
	mkdir $ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\PT Tests"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Final\Equitment Testing\Scanned QA-QC Documentation"
	mkdir $ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\Scanned QA-QC Documentation"
	Write-Verbose "Creating $ProjectName\Testing and Commissioning\Final\Equitment Testing\Transformer Tests"
	mkdir $ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\Transformer Tests"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Working\"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working /GRANT "tfa.Energy.RWED:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Working\"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing" /GRANT "tfa.Energy.RWED:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Working\Equitment Testing\CT Tests"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\CT Tests" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working\Equitment Testing\CT Tests with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\CT Tests" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working\Equitment Testing\CT Tests with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\CT Tests" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Working\Equitment Testing\IR Scans"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\IR Scans" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working\Equitment Testing\IR Scans with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\IR Scans" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Working\Equitment Testing\IR Scans with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\IR Scans" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Working\Equitment Testing\LA Tests"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\LA Tests" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working\Equitment Testing\LA Tests with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\LA Tests" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Working\Equitment Testing\LA Tests with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\LA Tests" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Working\Equitment Testing\NGR Nameplates"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\NGR Nameplates" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working\Equitment Testing\NGR Nameplates with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\NGR Nameplates" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Working\Equitment Testing\NGR Nameplates with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\NGR Nameplates" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Working\Equitment Testing\PT Tests"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\PT Tests" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working\Equitment Testing\PT Tests with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\PT Tests" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Working\Equitment Testing\PT Tests with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\PT Tests" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Working\Equitment Testing\Transformer Tests"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\Transformer Tests" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working\Equitment Testing\Transformer Tests with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\Transformer Tests" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Working\Equitment Testing\Transformer Tests with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Equitment Testing\Transformer Tests" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Working\Protection and Control\SCADA Documents"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"SCADA Documents" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working\Protection and Control\SCADA Documents with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"SCADA Documents" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Working\Protection and Control\SCADA Documents with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"SCADA Documents" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Working\Protection and Control\Module Pictures"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"Module Pictures" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working\Protection and Control\Module Pictures with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"Module Pictures" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Working\Protection and Control\Module Pictures with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"Module Pictures" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Working\Protection and Control\Load Readings Voltage Checks"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"Load Readings Voltage Checks" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working\Protection and Control\Load Readings Voltage Checks with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"Load Readings Voltage Checks" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Working\Protection and Control\Load Readings Voltage Checks with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"Load Readings Voltage Checks" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Working\Protection and Control\QA-QC Record Sheets"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"QA-QC Record Sheets" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working\Protection and Control\QA-QC Record Sheets with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"QA-QC Record Sheets" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Working\Protection and Control\QA-QC Record Sheets with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"QA-QC Record Sheets" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Working\Protection and Control\Functional Data"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"Functional Data" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working\Protection and Control\Functional Data with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"Functional Data" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Working\Protection and Control\Functional Data with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"Functional Data" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Working\Protection and Control\CT LO OHMS"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"CT LO OHMS" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Working\Protection and Control\CT LO OHMS with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"CT LO OHMS" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Working\Protection and Control\CT LO OHMS with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Working\"Protection and Control"\"CT LO OHMS" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Final"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Final with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final /GRANT "tfa.Energy.RWED:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Final with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Final\Protection and Control"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Final\Protection and Control with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control" /GRANT "tfa.Energy.RWED:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Final\Protection and Control with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Final\Protection and Control\Element Test"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"Element Test" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Final\Protection and Control\Element Test with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"Element Test" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Final\Protection and Control\Element Test with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"Element Test" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Final\Protection and Control\Functional Data"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"Functional Data" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Final\Protection and Control\Functional Data with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"Functional Data" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Final\Protection and Control\Functional Data with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"Functional Data" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Final\Protection and Control\Load Readings and Voltage Checks"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"Load Readings and Voltage Checks" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Final\Protection and Control\Load Readings and Voltage Checks with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"Load Readings and Voltage Checks" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Final\Protection and Control\Load Readings and Voltage Checks with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"Load Readings and Voltage Checks" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Final\Protection and Control\SCADA Documents"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"SCADA Documents" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Final\Protection and Control\SCADA Documents with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"SCADA Documents" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Final\Protection and Control\SCADA Documents with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"SCADA Documents" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Final\Protection and Control\Scanned QA QC Documentation"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"Scanned QA QC Documentation" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Final\Protection and Control\Scanned QA QC Documentation with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"Scanned QA QC Documentation" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Final\Protection and Control\Scanned QA QC Documentation with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Protection and Control"\"Scanned QA QC Documentation" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Final\Equitment Testing"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Final\Equitment Testing with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing" /GRANT "tfa.Energy.RWED:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Final\Equitment Testing with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Final\Equitment Testing\CT Tests"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\CT Tests" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Final\Equitment Testing\CT Tests with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\CT Tests" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Final\Equitment Testing\CT Tests with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\CT Tests" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Final\Equitment Testing\IR Scans"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\IR Scans" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Final\Equitment Testing\IR Scans with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\IR Scans" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Final\Equitment Testing\IR Scans with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\IR Scans" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Final\Equitment Testing\LA Tests"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\LA Tests" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Final\Equitment Testing\LA Tests with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\LA Tests" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Final\Equitment Testing\LA Tests with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\LA Tests" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Final\Equitment Testing\PT Tests"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\PT Tests" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Final\Equitment Testing\PT Tests with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\PT Tests" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Final\Equitment Testing\PT Tests with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\PT Tests" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Final\Equitment Testing\Scanned QA QC Documentation"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\Scanned QA QC Documentation" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Final\Equitment Testing\Scanned QA QC Documentation with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\Scanned QA QC Documentation" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Final\Equitment Testing\Scanned QA QC Documentation with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\Scanned QA QC Documentation" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	Write-Verbose "Removing Inheritance from $ProjectName\Testing and Commissioning\Final\Equitment Testing\Transformer Tests"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\Transformer Tests" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Testing and Commissioning\Final\Equitment Testing\Transformer Tests with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\Transformer Tests" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Testing and Commissioning\Final\Equitment Testing\Transformer Tests with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Testing and Commissioning"\Final\"Equitment Testing\Transformer Tests" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	#-----
	
	#-----
	Write-Verbose "Creating $ProjectName\CIP"
	mkdir $ProjectName\CIP
	Write-Verbose "Removing Inheritance from $ProjectName\CIP"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\CIP /inheritance:r
	Write-Verbose "Granting permission for stfa.Energy.CIP.READ to $ProjectName\Regulatory with (CI)(OI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\CIP /T /GRANT "stfa.Energy.CIP.READ:(CI)(OI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.CIP.READ to $ProjectName\Regulatory with (CI)(OI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\CIP /T /GRANT "stfa.Energy.CIP.RWED:(CI)(OI)(M)"
	#-----
	
	#-----
	Write-Verbose "Creating $ProjectName\Panel Shop"
	mkdir $ProjectName\"Panel Shop"
	Write-Verbose "Removing Inheritance from $ProjectName\Panel Shop"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Panel Shop" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ProjectName\Panel Shop with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Panel Shop" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ProjectName\Panel Shop with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName\"Panel Shop" /GRANT "tfa.Energy.READ:(OI)(CI)(M)"
	#-----
	
	#-----
	# This is to allow MFA access to all folders again after /inheritance:r on all end folders
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ProjectName with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName /T /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ProjectName with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName"\Active Projects\"$ProjectName /T /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	#-----
	
	Write-Verbose "Copies MakeProposalProject shortcut to $ClientName\Proposals\Active"
	Copy-Item -Path \\canagroup.cana-group\sysVOL\canagroup.cana-group\scripts\Powershell\Energy\MakeNewSubContract.lnk -Destination \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Active Projects"\$ProjectName\Procurement\Subcontracts
	Write-Verbose "Copies MakeProposalProject shortcut to $ClientName\Proposals\Active"
	Copy-Item -Path \\canagroup.cana-group\sysVOL\canagroup.cana-group\scripts\Powershell\Energy\MakeNewPO.lnk -Destination \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Active Projects"\$ProjectName\Procurement\"Purchase Orders"
	
}

Confirm-Authorized

# SIG # Begin signature block
# MIIbwAYJKoZIhvcNAQcCoIIbsTCCG60CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDc4ICg7olnXWpP
# AgKgjU7/AqANFYp6R9C7Y4Ir9lh+G6CCFvEwggOwMIICmKADAgECAhBz0HdolQdJ
# oki8RRr2J0/sMA0GCSqGSIb3DQEBCwUAMBgxFjAUBgNVBAMTDVZDQU5BQ0EtMDEt
# Q0EwHhcNMTQwNjA1MjAzNTU3WhcNNDAwMjIyMTUwNDU1WjAYMRYwFAYDVQQDEw1W
# Q0FOQUNBLTAxLUNBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAl8bY
# qRoITo9oA5hAh6NMfF80ur408wGvPSaMCNW7lpsRdtvtkkrahACkEsgwSd+9lR7D
# f9gvXrrTFNS6dmYia0KrwlEWNCWVi3IZMB4LEW+dg75O2Dv5zyAWyI41S8mAXr1a
# uexdiQrQ1sXsK/bOgfSsa6QMuoEz5ygBgsASpDnJrkAfytpb9FusJItqOse9twcR
# hx8TUxAcMXFknRqTTIGVsI5EiW+Hz9IE7wlSKI64OWGgbA5CBPS9nQrNX03tjNvK
# X9fYnGc/M5AGQzX77lZEe+JFKP9xiagyp/U6NXzHkNGP3MI4HhcCKa22/WiKU8J3
# jBcMxXdYakAHohKrJwIDAQABo4H1MIHyMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8E
# BTADAQH/MB0GA1UdDgQWBBRf3xmx13bZF/B33p006A7YobZKMDAQBgkrBgEEAYI3
# FQEEAwIBATAjBgkrBgEEAYI3FQIEFgQUxdeKfYHC0kzdgNNR9c3hnA6RPMowfAYD
# VR0gBHUwczBxBggqAwSLL0NZBTBlMDoGCCsGAQUFBwICMC4eLABMAGUAZwBhAGwA
# IABQAG8AbABpAGMAeQAgAFMAdABhAHQAZQBtAGUAbgB0MCcGCCsGAQUFBwIBFhto
# dHRwOi8vcGtpLmNhbmEuY2EvY3BzLnR4dAAwDQYJKoZIhvcNAQELBQADggEBADqs
# oXnS6AFVBoLccnE/PQdUkFRhGcCJGgpktJKXVmBqXzzGRIXBaEwErFpi10jR5tiU
# 5JonWJiZkSUoiXnNN64oemUZh6OB1TBoMau+6U/IXwa8tlju4MvjZBR5MQCnwRSc
# OUS6YgjZFe2DJfMfBlzU1VBBcS2v7iaWGInt93cotOPqORYWp9OpTg7CU/09kdIt
# 3GLwbRxqOmz77OirEGliAT8+D2sqw7S99mjxPHQQNRjGVIzXxdu1hE9WaY15fJZK
# 8+W+FCrpxOc+t63aFh6qoa3kYkIjswG7plpXTOM5LYJfxRbQWwvMsNvMLAt7D7CH
# dVTSjfwnZ7aHbVtI7o0wggQVMIIC/aADAgECAgsEAAAAAAExicZQBDANBgkqhkiG
# 9w0BAQsFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEG
# A1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjAeFw0xMTA4MDIx
# MDAwMDBaFw0yOTAzMjkxMDAwMDBaMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
# bG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIFRpbWVzdGFtcGlu
# ZyBDQSAtIFNIQTI1NiAtIEcyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
# AQEAqpuOw6sRUSUBtpaU4k/YwQj2RiPZRcWVl1urGr/SbFfJMwYfoA/GPH5TSHq/
# nYeer+7DjEfhQuzj46FKbAwXxKbBuc1b8R5EiY7+C94hWBPuTcjFZwscsrPxNHaR
# ossHbTfFoEcmAhWkkJGpeZ7X61edK3wi2BTX8QceeCI2a3d5r6/5f45O4bUIMf3q
# 7UtxYowj8QM5j0R5tnYDV56tLwhG3NKMvPSOdM7IaGlRdhGLD10kWxlUPSbMQI2C
# JxtZIH1Z9pOAjvgqOP1roEBlH1d2zFuOBE8sqNuEUBNPxtyLufjdaUyI65x7MCb8
# eli7WbwUcpKBV7d2ydiACoBuCQIDAQABo4HoMIHlMA4GA1UdDwEB/wQEAwIBBjAS
# BgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBSSIadKlV1ksJu0HuYAN0fmnUEr
# TDBHBgNVHSAEQDA+MDwGBFUdIAAwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cu
# Z2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wNgYDVR0fBC8wLTAroCmgJ4YlaHR0
# cDovL2NybC5nbG9iYWxzaWduLm5ldC9yb290LXIzLmNybDAfBgNVHSMEGDAWgBSP
# 8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEABFaCSnzQzsm/
# NmbRvjWek2yX6AbOMRhZ+WxBX4AuwEIluBjH/NSxN8RooM8oagN0S2OXhXdhO9cv
# 4/W9M6KSfREfnops7yyw9GKNNnPRFjbxvF7stICYePzSdnno4SGU4B/EouGqZ9uz
# nHPlQCLPOc7b5neVp7uyy/YZhp2fyNSYBbJxb051rvE9ZGo7Xk5GpipdCJLxo/Md
# dL9iDSOMXCo4ldLA1c3PiNofKLW6gWlkKrWmotVzr9xG2wSukdduxZi61EfEVnSA
# R3hYjL7vK/3sbL/RlPe/UOB74JD9IBh4GCJdCC6MHKCX8x2ZfaOdkdMGRE4Ebnoc
# IOM28LZQuTCCBFEwggM5oAMCAQICExMAAAAIUoL4lh5OGNwAAQAAAAgwDQYJKoZI
# hvcNAQELBQAwGDEWMBQGA1UEAxMNVkNBTkFDQS0wMS1DQTAeFw0yMDAyMjIxNTM4
# MDJaFw0zMDAyMjIxNTQ4MDJaMFkxGjAYBgoJkiaJk/IsZAEZFgpjYW5hLWdyb3Vw
# MRkwFwYKCZImiZPyLGQBGRYJY2FuYWdyb3VwMSAwHgYDVQQDExdjYW5hZ3JvdXAt
# VkNBTkFDQS0wMi1DQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAM34
# 2odTsuRkbznCc0lm/DH9h7eq0NwnMP7WRBEwPcm7oF27WaDHNnaTf5wVfON9Vm9H
# BEKmsCUlv3ktLeCIHDwsBWGKK6THWPM+PEIQsXvIMDep3wJZDclLnzhtIExtPobb
# 6aB6bxJQDUX8m8evYaETqXQ8Uk8lHFIbVwneYjHC6PkkN2o4ZojIe580/5ivIWjP
# GVYcZahYFKN98SvLyZCZBeQW/jszt0LUBUzr6OveW4ytMhW7ZgZJuQWwcLF8Po0H
# q6yVWQmnOcDQWipzrF5L9Vu/LVRHzCWq6g1kGpz9miK/9sfLspg+qP3Vaoe1DZ3c
# Z9efPr3pucvxAoiisNUCAwEAAaOCAVEwggFNMBIGCSsGAQQBgjcVAQQFAgMDAAMw
# IwYJKwYBBAGCNxUCBBYEFEN5BJkRd5hylM3r0cAMrDi9xpJIMB0GA1UdDgQWBBQ3
# 6Wo/n+XRQ/jwU6/hzEEnFc66PzAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTAL
# BgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRf3xmx13bZ
# F/B33p006A7YobZKMDA/BgNVHR8EODA2MDSgMqAwhi5odHRwOi8vdmNhbmFjYS0w
# Mi9DZXJ0RW5yb2xsL1ZDQU5BQ0EtMDEtQ0EuY3JsMFgGCCsGAQUFBwEBBEwwSjBI
# BggrBgEFBQcwAoY8aHR0cDovL3ZjYW5hY2EtMDIvQ2VydEVucm9sbC9WQ0FOQUNB
# LTAxX1ZDQU5BQ0EtMDEtQ0EoMSkuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBV0bbX
# 7DX2d4R7Ss6ONwPNLjG3HjdzLji/ko/fmNKf3YQNASzrGFjaastXx2Lvy2zRd4fe
# IAgjIiE5XxR7DISbC1VeCIFLmBN1tUn0h7Os2Ck8mKMlchKGz3wDkeV6aM8i2RNt
# oAPXfQrtUxfSq/Sosic5f89ugsfzz3Ml4NQdcRu5dTzMbo9VbVBaQvGYODPUTSxs
# 0RJi1Ne8b8AkM8aKbTkrOhuAnKrFdgCC56Rq+6Wg4maBa0T15ixkE/OQ6GKHIdhV
# jWHfCEwk5jhY8j4y4Ssa8vEh/fsvhNTHI7+zYa9xdwjtqDB7zKEw+q7GHFa+pGhs
# tBLn99EBf1fmeshPMIIExjCCA66gAwIBAgIMJFS4fx4UU603+qF4MA0GCSqGSIb3
# DQEBCwUAMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
# MTEwLwYDVQQDEyhHbG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAtIFNIQTI1NiAt
# IEcyMB4XDTE4MDIxOTAwMDAwMFoXDTI5MDMxODEwMDAwMFowOzE5MDcGA1UEAwww
# R2xvYmFsU2lnbiBUU0EgZm9yIE1TIEF1dGhlbnRpY29kZSBhZHZhbmNlZCAtIEcy
# MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2XhhoZauEv+j/yf2RGB7
# alYtZ+NfnzGSKkjt+QWEDm1OIlbK2JmXjmnKn3sPCMgqK2jRKGErn+Qm7rq497Ds
# Xmob4li1tL0dCe3N6D3UZv++IiJtNibPEXiX6VUAKMPpN069GeUXhEiyHCGt7HPS
# 86in6V/oNc6FE6cim6yC6f7xX8QSWrH3DEDm0qDgTWjQ7QwMEB2PBV9kVfm7KEcG
# DNgGPzfDJjYljHsPJ4hcODGlAfZeZN6DwBRc4OfSXsyN6iOAGSqzYi5gx6pn1rNA
# 7lJ/Vgzv2QXXlSBdhRVAz16RlVGeRhoXkb7BwAd1skv3NrrFVGxfihv7DShhyInw
# FQIDAQABo4IBqDCCAaQwDgYDVR0PAQH/BAQDAgeAMEwGA1UdIARFMEMwQQYJKwYB
# BAGgMgEeMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29t
# L3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgw
# RgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
# c3RpbWVzdGFtcGluZ3NoYTJnMi5jcmwwgZgGCCsGAQUFBwEBBIGLMIGIMEgGCCsG
# AQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3Rp
# bWVzdGFtcGluZ3NoYTJnMi5jcnQwPAYIKwYBBQUHMAGGMGh0dHA6Ly9vY3NwMi5n
# bG9iYWxzaWduLmNvbS9nc3RpbWVzdGFtcGluZ3NoYTJnMjAdBgNVHQ4EFgQU1Ie4
# jeblQDydWgZjxkWE2d27HMMwHwYDVR0jBBgwFoAUkiGnSpVdZLCbtB7mADdH5p1B
# K0wwDQYJKoZIhvcNAQELBQADggEBACRyUKUMvEAJpsH01YJqTkFfzseIOdPkfPki
# bDh4uPS692vhJOudfM1IrIvstXZMj9yCaQiW57rhZ7bwpr8YCELh680ZWDmlEWEj
# 1hnXAOm70vlfQfsEPv6KIGAM0U8jWhkaGO/Yxt7WX1ShepPhtneFwPuxRsQJri9T
# +5WcjibiSuTE5jw177rG2bnFzc0Hm2O7PQ9hvFV8IxC1jIqj0mhFsUC6oN08GxVA
# uEl4b+WUwG1WSzz2EirUhfNIEwXhuzBFCkG3fJJuvk6SYILKW2TmVdPSB96dX5uh
# Ae2b8MNduxnwGAyaoBzpaggLPelml6d1Hg+/KNcJIw3iFvq68zQwggYBMIIE6aAD
# AgECAhNOAAAS3Vhn78FO1nAyAAMAABLdMA0GCSqGSIb3DQEBCwUAMFkxGjAYBgoJ
# kiaJk/IsZAEZFgpjYW5hLWdyb3VwMRkwFwYKCZImiZPyLGQBGRYJY2FuYWdyb3Vw
# MSAwHgYDVQQDExdjYW5hZ3JvdXAtVkNBTkFDQS0wMi1DQTAeFw0yMDEyMTgyMjMx
# MTFaFw0yMTEyMTgyMjMxMTFaMIGUMRowGAYKCZImiZPyLGQBGRYKY2FuYS1ncm91
# cDEZMBcGCgmSJomT8ixkARkWCWNhbmFncm91cDEZMBcGA1UECxMQQ0FOQSBHcm91
# cCBVc2VyczEbMBkGA1UECxMSQ0FOQSBMaW1pdGVkIFVzZXJzMQswCQYDVQQLEwJJ
# VDEWMBQGA1UEAxMNSnVzdGluIEhvbG1lczCBnzANBgkqhkiG9w0BAQEFAAOBjQAw
# gYkCgYEAs4NLXD+FeIP6jeE2OxIfZYEOGpm7ES0+h8Tlhp9oRQtAHgTOc59iKYex
# qiH+Rm6QVx87ft90OkgEcFvuWWfDCDtduKamtgL+mJ2X5sg+O8izkPB7xccPNr/Y
# d0PPZ31PsSDE7YtUABpHFQ+AUSqiy006U4PuF5SD3v4aMWVC1Z0CAwEAAaOCAwgw
# ggMEMD0GCSsGAQQBgjcVBwQwMC4GJisGAQQBgjcVCIKUh3yC2MMbgt2PJ4S84xCH
# gd1XgVWE9cMVu+NcAgFkAgEGMBMGA1UdJQQMMAoGCCsGAQUFBwMDMAsGA1UdDwQE
# AwIHgDAbBgkrBgEEAYI3FQoEDjAMMAoGCCsGAQUFBwMDMB0GA1UdDgQWBBTbGTOS
# egPuMwpWtt2XPRJw+FdeeDAfBgNVHSMEGDAWgBQ36Wo/n+XRQ/jwU6/hzEEnFc66
# PzCCATsGA1UdHwSCATIwggEuMIIBKqCCASagggEihoHNbGRhcDovLy9DTj1jYW5h
# Z3JvdXAtVkNBTkFDQS0wMi1DQSgzKSxDTj12Q0FOQUNBLTAyLENOPUNEUCxDTj1Q
# dWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0
# aW9uLERDPWNhbmFncm91cCxEQz1jYW5hLWdyb3VwP2NlcnRpZmljYXRlUmV2b2Nh
# dGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2ludIZQ
# aHR0cDovL3ZDQU5BQ0EtMDIuY2FuYWdyb3VwLmNhbmEtZ3JvdXAvQ2VydEVucm9s
# bC9jYW5hZ3JvdXAtVkNBTkFDQS0wMi1DQSgzKS5jcmwwgdIGCCsGAQUFBwEBBIHF
# MIHCMIG/BggrBgEFBQcwAoaBsmxkYXA6Ly8vQ049Y2FuYWdyb3VwLVZDQU5BQ0Et
# MDItQ0EsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZp
# Y2VzLENOPUNvbmZpZ3VyYXRpb24sREM9Y2FuYWdyb3VwLERDPWNhbmEtZ3JvdXA/
# Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRo
# b3JpdHkwMAYDVR0RBCkwJ6AlBgorBgEEAYI3FAIDoBcMFUp1c3Rpbi5Ib2xtZXNA
# Y2FuYS5jYTANBgkqhkiG9w0BAQsFAAOCAQEAJAn2MwQFuNjgrpCehzlRxTzO1N9+
# 3R0xY3IrYzZsbp8Bgj6NDqIx+okH/A3595XPAf+LqJjBn7Lepf8F9GCQ4GMsLynr
# dDIBA2WYxyWVQcro716nFMNVbqnTC7ifgL13flB8XD03epk5OpETfcNqCjwo89gj
# xRTA7LnlotoKCw4YX0kX06DhIm+9cgOVn1CDB9fTb7wPLaVredCnO5qxQImHiKRw
# 9TRdq7qIGtTamGd9csHtHiNqhu7gVbMBgdGPDxYUBVvK6URrB+v7p9mG3aSO5nTb
# tm/tLMohxuHjLxU/75Srd6BTYpsVs/QiFf0UZCRfBDps6XAikAgnBCIbxDGCBCUw
# ggQhAgEBMHAwWTEaMBgGCgmSJomT8ixkARkWCmNhbmEtZ3JvdXAxGTAXBgoJkiaJ
# k/IsZAEZFgljYW5hZ3JvdXAxIDAeBgNVBAMTF2NhbmFncm91cC1WQ0FOQUNBLTAy
# LUNBAhNOAAAS3Vhn78FO1nAyAAMAABLdMA0GCWCGSAFlAwQCAQUAoEwwGQYJKoZI
# hvcNAQkDMQwGCisGAQQBgjcCAQQwLwYJKoZIhvcNAQkEMSIEIIkIK8n0t4wcyGZH
# ItsUdy+DkMHvLK8Vdp+FwOcElB1vMA0GCSqGSIb3DQEBAQUABIGAYM5sI5r87COH
# T5rb/MOa0clK3+++Wf01i1MhgwwdvjI79Ts7EUoLPhT5lKtKKDo39MMImxzeagXw
# 4I2S8H7J3rsvdPIcAG8YUPF+Gj2nwAZ9lnbZ+TmIxW5bYaKOj6TOfzDdc/gZ2u7S
# aiG0Qq4xB2PviA/gdgQb4vtcWsuA9AahggK5MIICtQYJKoZIhvcNAQkGMYICpjCC
# AqICAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
# YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0EgLSBTSEEyNTYg
# LSBHMgIMJFS4fx4UU603+qF4MA0GCWCGSAFlAwQCAQUAoIIBDDAYBgkqhkiG9w0B
# CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTAxMjIyMjA0NDNaMC8G
# CSqGSIb3DQEJBDEiBCA/m/xuZKgJac9wDHmjPTcOapwURfv1GACKD57nca4OGTCB
# oAYLKoZIhvcNAQkQAgwxgZAwgY0wgYowgYcEFD7HZtXU1HLiGx8hQ1IcMbeQ2Uto
# MG8wX6RdMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
# MTEwLwYDVQQDEyhHbG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAtIFNIQTI1NiAt
# IEcyAgwkVLh/HhRTrTf6oXgwDQYJKoZIhvcNAQEBBQAEggEAs3DhTvclxmZTHZxc
# mce/1skfbgtkFR5Hpm86u7Y0M1i4wXnYjLc4ZvmYaWqOnXFGfA7jdScC+dANV0vy
# jpzmz08hcT4hHf+KjubiG8LokH35mGaU/Z3f2/R8+HHNv8OhHCMImr/mee01ABj2
# /XCfmlYUj4eDpwj60T8p4Ukt6VZbwdzuZTINuVlDF3AE1mKCnDmDmZfzUQPf2d5d
# 36E1/3hP+2gOmJz/h1fOZ69ud8DlYXcsFIdRfsFvUrdkONdok+zBh+NLxM0yhcAr
# YRdzrVHpr+saxcxiKJF2gxHAmaPsoWxaswfGzkLTt/BQ6bVJVOvEdjZiB162bYh+
# Acn4Ig==
# SIG # End signature block
