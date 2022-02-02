<#	
	.NOTES
	===========================================================================
	 Created on:   	08/20/2019 8:13 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA
	 Filename:     	Energy-MakeClient.ps1
	===========================================================================
	.DESCRIPTION
		This file will setup a new client folder.  I would recommend that this script be limited to admin.
#>

."\\canagroup.cana-group\SYSVOL\canagroup.cana-group\scripts\Powershell\Energy\IsMember.ps1"
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
	
	Write-Verbose "Starting main script."
	Write-Debug "Starting main script"
	$ClientName = Read-host "Please enter the Client's name"
	
	Set-Location -Path "\\canagroup.cana-group\business\Energy\Clients"
	
	#-----
	#
	#
	Write-Verbose "Creating $ClientName"
	mkdir $ClientName
	Write-Verbose "Removing Inheritance from $ClientName"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName /T /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName /T /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	#-----
	
	#-----
	#
	Write-Verbose "Creating $ClientName\Proposals"
	mkdir $ClientName\Proposals
	Write-Verbose "Removing Inheritance from $ClientName\Proposals"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Proposals with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Proposals with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Proposals with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Proposals with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	#
	
	#-----
	#
	Write-Verbose "Creating $ClientName\Proposals\Resource Center"
	mkdir $ClientName\Proposals\"Resource Center"
	Write-Verbose "Creating $ClientName\Proposals\Archived"
	mkdir $ClientName\Proposals\Archived
	Write-Verbose "Creating $ClientName\Proposals\Active"
	mkdir $ClientName\Proposals\Active
	
	Write-Verbose "Copies MakeProposalProject shortcut to $ClientName\Proposals\Active"
	Copy-Item -Path \\canagroup.cana-group\sysVOL\canagroup.cana-group\scripts\Powershell\Energy\MakeProposalProject.lnk -Destination $ClientName\Proposals\Active
	Write-Verbose "Copies MakeProposalProject shortcut to $ClientName\Proposals\Active"
	Copy-Item -Path \\canagroup.cana-group\sysVOL\canagroup.cana-group\scripts\Powershell\Energy\ArchiveProposalProject.lnk -Destination $ClientName\Proposals\Active
	Write-Verbose "Copies MakeProposalProject shortcut to $ClientName\Proposals\Active"
	Copy-Item -Path \\canagroup.cana-group\sysVOL\canagroup.cana-group\scripts\Powershell\Energy\SOMETHINGProposalProject.lnk -Destination $ClientName\Proposals\Active
	
	
	Write-Verbose "Removing Inheritance from $ClientName\Proposals\Resource Center"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals\"Resource Center" /inheritance:r
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Proposals\Resource Center with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals\"Resource Center" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Proposals\Resource Center with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals\"Resource Center" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Proposals\Resource Center with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals\"Resource Center" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Proposals\Resource Center with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals\"Resource Center" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Removing Inheritance from $ClientName\Proposals\Archived"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals\Archived /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Proposals\Archived with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals\Archived /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Proposals\Archived with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals\Archived /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Proposals\Archived with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals\Archived /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Proposals\Active"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals\Active /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Proposals\Active with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals\Active /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Proposals\Active with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals\Active /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Proposals\Active with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Proposals\Active /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	#
	
	#-----
	#
	Write-Verbose "Creating $ClientName\Active Projects"
	mkdir $ClientName\"Active Projects"
	
	Write-Verbose "Copies MakeProposalProject shortcut to $ClientName\Proposals\Active"
	Copy-Item -Path \\canagroup.cana-group\sysVOL\canagroup.cana-group\scripts\Powershell\Energy\MakeProjectFolder.lnk -Destination $ClientName\"Active Projects"
	
	Write-Verbose "Removing Inheritance from $ClientName\Active Projects"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Active Projects" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Active Projects with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Active Projects" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Active Projects with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Active Projects" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Active Projects with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Active Projects" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Active Projects with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Active Projects" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	#
	
	#-----
	#
	Write-Verbose "Creating $ClientName\Archived Projects"
	mkdir $ClientName\"Archived Projects"
	Write-Verbose "Removing Inheritance from $ClientName\Archived Projects"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Archived Projects" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.Archive.RWED to $ClientName\Archived Projects with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Archived Projects" /GRANT "stfa.Energy.Archive.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.Archive.READ to $ClientName\Archived Projects with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Archived Projects" /GRANT "stfa.Energy.Archive.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Archived Projects with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Archived Projects" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Archived Projects with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Archived Projects" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	#
	
	#-----
	#
	Write-Verbose "Creating $ClientName\Administrative"
	mkdir $ClientName\Administrative
	Write-Verbose "Creating $ClientName\Administrative\Client Procedures"
	mkdir $ClientName\Administrative\"Client Procedures"
	Write-Verbose "Creating $ClientName\Administrative\Client Procedures\Active"
	mkdir $ClientName\Administrative\"Client Procedures"\Active
	Write-Verbose "Creating $ClientName\Administrative\Client Procedures\Archived"
	mkdir $ClientName\Administrative\"Client Procedures"\Archived
	Write-Verbose "Creating $ClientName\Administrative\Client Procedures\Information"
	mkdir $ClientName\Administrative\"Client Procedures"\Information
	Write-Verbose "Creating $ClientName\Administrative\Client Procedures\Pending"
	mkdir $ClientName\Administrative\"Client Procedures"\Pending
	Write-Verbose "Creating $ClientName\Administrative\Client Templates"
	mkdir $ClientName\Administrative\"Client Templates"
	Write-Verbose "Creating $ClientName\Administrative\Client Templates\Active"
	mkdir $ClientName\Administrative\"Client Templates"\Active
	Write-Verbose "Creating $ClientName\Administrative\Client Templates\Archived"
	mkdir $ClientName\Administrative\"Client Templates"\Archived
	Write-Verbose "Creating $ClientName\Administrative\Client Templates\Information"
	mkdir $ClientName\Administrative\"Client Templates"\Information
	Write-Verbose "Creating $ClientName\Administrative\Client Templates\Pending"
	mkdir $ClientName\Administrative\"Client Templates"\Pending
	Write-Verbose "Creating $ClientName\Administrative\Client Marketing"
	mkdir $ClientName\Administrative\"Client Marketing"
	Write-Verbose "Creating $ClientName\Administrative\Client Marketing\Active"
	mkdir $ClientName\Administrative\"Client Marketing"\Active
	Write-Verbose "Creating $ClientName\Administrative\Client Marketing\Archived"
	mkdir $ClientName\Administrative\"Client Marketing"\Archived
	Write-Verbose "Creating $ClientName\Administrative\Client Marketing\Information"
	mkdir $ClientName\Administrative\"Client Marketing"\Information
	Write-Verbose "Creating $ClientName\Administrative\Client Marketing\Pending"
	mkdir $ClientName\Administrative\"Client Marketing"\Pending
	Write-Verbose "Creating $ClientName\Administrative\Client Policies"
	mkdir $ClientName\Administrative\"Client Policies"
	Write-Verbose "Creating $ClientName\Administrative\Client Policies\Active"
	mkdir $ClientName\Administrative\"Client Policies"\Active
	Write-Verbose "Creating $ClientName\Administrative\Client Policies\Archived"
	mkdir $ClientName\Administrative\"Client Policies"\Archived
	Write-Verbose "Creating $ClientName\Administrative\Client Policies\Information"
	mkdir $ClientName\Administrative\"Client Policies"\Information
	Write-Verbose "Creating $ClientName\Administrative\Client Policies\Pending"
	mkdir $ClientName\Administrative\"Client Policies"\Pending
	Write-Verbose "Creating $ClientName\Administrative\Standards"
	mkdir $ClientName\Administrative\"Standards"
	Write-Verbose "Creating $ClientName\Administrative\Standards\Active"
	mkdir $ClientName\Administrative\"Standards"\Active
	Write-Verbose "Creating $ClientName\Administrative\Standards\Archived"
	mkdir $ClientName\Administrative\"Standards"\Archived
	Write-Verbose "Creating $ClientName\Administrative\Standards\Information"
	mkdir $ClientName\Administrative\"Standards"\Information
	Write-Verbose "Creating $ClientName\Administrative\Standards\Pending"
	mkdir $ClientName\Administrative\"Standards"\Pending
	Write-Verbose "Removing Inheritance from $ClientName\Administrative"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Administrative /inheritance:r /T
	Write-Verbose "Granting permission for tfa.Energy.Administrative.RWED to $ClientName\Administrative with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Administrative /T /GRANT "tfa.Energy.Administrative.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.Administrative.READ to $ClientName\Administrative with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Administrative /T /GRANT "tfa.Energy.Administrative.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Administrative with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Administrative /T /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Administrative with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Administrative /T /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	#
	
	#----
	#
	Write-Verbose "Creating $ClientName\Master Contracts"
	mkdir $ClientName\"Master Contracts"
	Write-Verbose "Creating $ClientName\Master Contracts\Pending"
	mkdir $ClientName\"Master Contracts\Pending"
	Write-Verbose "Creating $ClientName\Master Contracts\Information"
	mkdir $ClientName\"Master Contracts\Information"
	Write-Verbose "Creating $ClientName\Master Contracts\Archived"
	mkdir $ClientName\"Master Contracts\Archived"
	Write-Verbose "Creating $ClientName\Master Contracts\Active"
	mkdir $ClientName\"Master Contracts\Active"
	
	Write-Verbose "Removing Inheritance from $ClientName\Master Contracts"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Master Contracts with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Master Contracts with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Master Contracts with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Master Contracts\Active"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Active" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Master Contracts\Active with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Active" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Master Contracts\Active with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Active" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Master Contracts\Active with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Active" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Master Contracts\Active with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Active" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Master Contracts\Archived"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Archived" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Master Contracts\Archived with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Archived" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Master Contracts\Archived with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Archived" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Master Contracts\Archived with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Archived" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Master Contracts\Archived with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Archived" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Master Contracts\Information"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Information" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Master Contracts\Information with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Information" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Master Contracts\Information with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Information" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Master Contracts\Information with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Information" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Master Contracts\Information with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Information" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Master Contracts\Pending"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Pending" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Master Contracts\Pending with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Pending" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Master Contracts\Pending with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Pending" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Master Contracts\Pending with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Pending" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Master Contracts\Pending with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Master Contracts\Pending" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	#
	
	#-----
	#
	Write-Verbose "Creating $ClientName\Engineering"
	mkdir $ClientName\Engineering
	Write-Verbose "Creating $ClientName\Engineering\Client Specification"
	mkdir $ClientName\Engineering\"Client Specification"
	Write-Verbose "Creating $ClientName\Engineering\Client Specification\Active"
	mkdir $ClientName\Engineering\"Client Specification\Active"
	Write-Verbose "Creating $ClientName\Engineering\Client Specification\Archived"
	mkdir $ClientName\Engineering\"Client Specification\Archived"
	Write-Verbose "Creating $ClientName\Engineering\Client Specification\Pending"
	mkdir $ClientName\Engineering\"Client Specification\Pending"
	Write-Verbose "Creating $ClientName\Engineering\Client Specification\Information"
	mkdir $ClientName\Engineering\"Client Specification\Information"
	Write-Verbose "Creating $ClientName\Engineering\Technical Bulletins"
	mkdir $ClientName\Engineering\"Technical Bulletins"
	Write-Verbose "Removing Inheritance from $ClientName\Engineering"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering /inheritance:r
	Write-Verbose "Granting permission for stfa.Energy.Engineering.READ to $ClientName\Engineering with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering /GRANT "stfa.Energy.Engineering.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Engineering with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Engineering with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Engineering\Client Specification"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification" /inheritance:r
	Write-Verbose "Granting permission for stfa.Energy.Engineering.READ to $ClientName\Engineering\Client Specification with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification" /GRANT "stfa.Energy.Engineering.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Engineering\Client Specification with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Engineering\Client Specification with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Engineering\Client Specification\Active"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Active" /inheritance:r
	Write-Verbose "Granting permission for stfa.Energy.Engineering.READ to $ClientName\Engineering\Client Specification\Active with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Active" /GRANT "stfa.Energy.Engineering.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Engineering.RWED to $ClientName\Engineering\Client Specification\Active with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Active" /GRANT "stfa.Energy.Engineering.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Engineering\Client Specification\Active with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Active" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Engineering\Client Specification\Active with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Active" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Engineering\Client Specification\Archived"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Archived" /inheritance:r
	Write-Verbose "Granting permission for stfa.Energy.Engineering.READ to $ClientName\Engineering\Client Specification\Archived with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Archived" /GRANT "stfa.Energy.Engineering.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Engineering.RWED to $ClientName\Engineering\Client Specification\Archived with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Archived" /GRANT "stfa.Energy.Engineering.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Engineering\Client Specification\Archived with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Archived" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Engineering\Client Specification\Archived with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Archived" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Engineering\Client Specification\Pending"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Pending" /inheritance:r
	Write-Verbose "Granting permission for stfa.Energy.Engineering.READ to $ClientName\Engineering\Client Specification\Pending with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Pending" /GRANT "stfa.Energy.Engineering.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Engineering.RWED to $ClientName\Engineering\Client Specification\Pending with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Pending" /GRANT "stfa.Energy.Engineering.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Engineering\Client Specification\Pending with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Pending" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Engineering\Client Specification\Pending with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Pending" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Engineering\Client Specification\Information"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Information" /inheritance:r
	Write-Verbose "Granting permission for stfa.Energy.Engineering.READ to $ClientName\Engineering\Client Specification\Information with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Information" /GRANT "stfa.Energy.Engineering.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Engineering.RWED to $ClientName\Engineering\Client Specification\Information with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Information" /GRANT "stfa.Energy.Engineering.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Engineering\Client Specification\Information with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Information" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Engineering\Client Specification\Information with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Client Specification\Information" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Engineering\Technical Bulletins"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Technical Bulletins" /inheritance:r
	Write-Verbose "Granting permission for stfa.Energy.Engineering.READ to $ClientName\Engineering\Technical Bulletins with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Technical Bulletins" /GRANT "stfa.Energy.Engineering.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for stfa.Energy.Engineering.RWED to $ClientName\Engineering\Technical Bulletins with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Technical Bulletins" /GRANT "stfa.Energy.Engineering.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Engineering\Technical Bulletins with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Technical Bulletins" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Engineering\Technical Bulletins with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\Engineering\"Technical Bulletins" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	#
	
	#----
	#
	Write-Verbose "Creating $ClientName\Field Services"
	mkdir $ClientName\"Field Services"
	Write-Verbose "Creating $ClientName\Field Services\Energy Services"
	mkdir $ClientName\"Field Services"\"Energy Services"
	Write-Verbose "Creating $ClientName\Field Services\Infrastructure"
	mkdir $ClientName\"Field Services"\Infrastructure
	Write-Verbose "Removing Inheritance from $ClientName\Field Services"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Field Services" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Field Services with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Field Services" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Field Services with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Field Services" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Field Services with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Field Services" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Field Services\Energy Services"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Field Services"\"Energy Services" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Field Services\Energy Services with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Field Services"\"Energy Services" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Field Services\Energy Services with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Field Services"\"Energy Services" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Field Services\Energy Services with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Field Services"\"Energy Services" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Field Services\Energy Services with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Field Services"\"Energy Services" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Field Services\Infrastructure"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Field Services"\Infrastructure /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Field Services\Infrastructure with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Field Services"\Infrastructure /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Field Services\Infrastructure with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Field Services"\Infrastructure /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Field Services\Infrastructure with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Field Services"\Infrastructure /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Field Services\Infrastructure with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Field Services"\Infrastructure /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	#
	
	#----
	#
	Write-Verbose "Creating $ClientName\HSE"
	mkdir $ClientName\HSE
	Write-Verbose "Removing Inheritance from $ClientName\HSE"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\HSE /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\HSE with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\HSE /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\HSE with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\HSE /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\HSE with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\HSE /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\HSE with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\HSE /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	#
	
	#-----
	#
	Write-Verbose "Creating $ClientName\Panel Shop"
	mkdir $ClientName\"Panel Shop"
	Write-Verbose "Removing Inheritance from $ClientName\Panel Shop"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Panel Shop" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Panel Shop with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Panel Shop" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Panel Shop with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Panel Shop" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Panel Shop with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Panel Shop" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Panel Shop with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Panel Shop" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	#
	
	#-----
	#
	Write-Verbose "Creating $ClientName\Project Services"
	mkdir $ClientName\"Project Services"
	Write-Verbose "Creating $ClientName\Project Services\Procurement"
	mkdir $ClientName\"Project Services\Procurement"
	Write-Verbose "Creating $ClientName\Project Services\Project Controls"
	mkdir $ClientName\"Project Services\Project Controls"
	Write-Verbose "Creating $ClientName\Project Services\Project Controls\Client Reports"
	mkdir $ClientName\"Project Services\Project Controls\Client Reports"
	Write-Verbose "Removing Inheritance from $ClientName\Project Services"
	Write-Verbose "Creating $ClientName\Project Services\Project Controls\Cost Control"
	mkdir $ClientName\"Project Services\Project Controls\Cost Control"
	Write-Verbose "Creating $ClientName\Project Services\Project Controls\Accruals"
	mkdir $ClientName\"Project Services\Project Controls\Accruals"
	Write-Verbose "Creating $ClientName\Project Services\Quality"
	mkdir $ClientName\"Project Services\Quality"
	Write-Verbose "Creating $ClientName\Project Services\Quality\Archived"
	mkdir $ClientName\"Project Services\Quality\Archived"
	Write-Verbose "Creating $ClientName\Project Services\Quality\Quality Policies"
	mkdir $ClientName\"Project Services\Quality\Quality Policies"
	Write-Verbose "Creating $ClientName\Project Services\Quality\Quality Manual"
	mkdir $ClientName\"Project Services\Quality\Quality Manual"
	Write-Verbose "Creating $ClientName\Project Services\Quality\Quality Procedures"
	mkdir $ClientName\"Project Services\Quality\Quality Procedures"
	Write-Verbose "Creating $ClientName\Project Services\Quality\Quality Forms"
	mkdir $ClientName\"Project Services\Quality\Quality Forms"
	Write-Verbose "Creating $ClientName\Project Services\Quality\Quality Records"
	mkdir $ClientName\"Project Services\Quality\Quality Records"
	Write-Verbose "Creating $ClientName\Project Services\Quality\Work Instructions"
	mkdir $ClientName\"Project Services\Quality\Work Instructions"
	Write-Verbose "Creating $ClientName\Project Services\Quality\ISO Standards"
	mkdir $ClientName\"Project Services\Quality\ISO Standards"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Project Services with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Project Services with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Project Services with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Project Services\Procurement"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Procurement" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Project Services\Procurement with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Procurement" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Project Services\Procurement with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Procurement" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Project Services\Procurement with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Procurement" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Project Services\Procurement with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Procurement" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Project Services\Project Controls"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Project Controls with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Project Services\Project Controls with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Project Services\Project Controls with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Project Services\Project Controls\Client Reports"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls\Client Reports" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Project Controls\Client Reports with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls\Client Reports" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Project Controls\Client Reports with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls\Client Reports" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Project Services\Project Controls\Client Reports with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls\Client Reports" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Project Services\Project Controls\Client Reports with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls\Client Reports" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Project Services\Project Controls\Cost Control"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls\Cost Control" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Project Controls\Cost Control with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls\Cost Control" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Project Controls\Cost Control with (OI)(CI)M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls\Cost Control" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Project Controls\Cost Control with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls\Cost Control" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Project Controls\Cost Control with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls\Cost Control" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Project Services\Project Controls\Accruals"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls\Accruals" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Project Controls\Accruals with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls\Accruals" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Project Controls\Accruals with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls\Accruals" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Project Controls\Accruals with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls\Accruals" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Project Controls\Accruals with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Project Controls\Accruals" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Project Services\Quality"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Project Services\Quality with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Project Services\Quality with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Project Services\Quality with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Project Services\Quality\Archived"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Archived" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Project Services\Quality\Archived with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Archived" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Project Services\Quality\Archived with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Archived" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Project Services\Quality\Archived with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Archived" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Project Services\Quality\Archived with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Archived" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Project Services\Quality\Quality Policies"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Policies" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Project Services\Quality\Quality Policies with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Policies" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Project Services\Quality\Quality Policies with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Policies" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Project Services\Quality\Quality Policies with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Policies" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Project Services\Quality\Quality Policies with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Policies" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Project Services\Quality\Quality Manual"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Manual" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Project Services\Quality\Quality Manual with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Manual" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Project Services\Quality\Quality Manual with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Manual" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Project Services\Quality\Quality Manual with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Manual" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Project Services\Quality\Quality Manual with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Manual" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Project Services\Quality\Quality Procedures"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Procedures" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Project Services\Quality\Quality Procedures with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Procedures" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Project Services\Quality\Quality Procedures with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Procedures" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Project Services\Quality\Quality Procedures with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Procedures" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Project Services\Quality\Quality Procedures with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Procedures" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Project Services\Quality\Quality Forms"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Forms" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Project Services\Quality\Quality Forms with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Forms" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Project Services\Quality\Quality Forms with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Forms" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Project Services\Quality\Quality Forms with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Forms" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Project Services\Quality\Quality Forms with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Forms" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Project Services\Quality\Quality Records"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Records" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Quality\Quality Records with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Records" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Project Services\Quality\Quality Records with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Records" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Project Services\Quality\Quality Records with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Records" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Project Services\Quality\Quality Records with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Quality Records" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Project Services\Quality\Work Instructions"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Work Instructions" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Project Services\Quality\Work Instructions with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Work Instructions" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Project Services\Quality\Work Instructions with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Work Instructions" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Project Services\Quality\Work Instructions with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Work Instructions" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Project Services\Quality\Work Instructions with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\Work Instructions" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	Write-Verbose "Removing Inheritance from $ClientName\Project Services\Quality\ISO Standards"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\ISO Standards" /inheritance:r
	Write-Verbose "Granting permission for tfa.Energy.READ to $ClientName\Project Services\Quality\ISO Standards with (OI)(CI)(RX)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\ISO Standards" /GRANT "tfa.Energy.READ:(OI)(CI)(RX)"
	Write-Verbose "Granting permission for tfa.Energy.RWED to $ClientName\Project Services\Quality\ISO Standards with (OI)(CI)(M)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\ISO Standards" /GRANT "tfa.Energy.RWED:(OI)(CI)(M)"
	Write-Verbose "Granting permission for mfa.AllFolders.Full to $ClientName\Project Services\Quality\ISO Standards with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\ISO Standards" /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
	Write-Verbose "Granting permission for mfa.Energy.Full to $ClientName\Project Services\Quality\ISO Standards with (CI)(OI)(F)"
	& icacls.exe \\canagroup.cana-group\business\Energy\Clients\$ClientName\"Project Services\Quality\ISO Standards" /GRANT "mfa.Energy.Full:(CI)(OI)(F)"
	
	
}


#
# SIG # Begin signature block
# MIIcFQYJKoZIhvcNAQcCoIIcBjCCHAICAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCApuJ9p6a5kq5VY
# +a7paaJAM0WN908hU77TjriZ0pmk7aCCFsUwggMLMIIB86ADAgECAhAdBzYmM16G
# g06JYzHUiBhJMA0GCSqGSIb3DQEBBQUAMBgxFjAUBgNVBAMTDVZDQU5BQ0EtMDEt
# Q0EwHhcNMTQwNjA1MjAzNTU3WhcNMzkwNjA1MjA0NTU3WjAYMRYwFAYDVQQDEw1W
# Q0FOQUNBLTAxLUNBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAl8bY
# qRoITo9oA5hAh6NMfF80ur408wGvPSaMCNW7lpsRdtvtkkrahACkEsgwSd+9lR7D
# f9gvXrrTFNS6dmYia0KrwlEWNCWVi3IZMB4LEW+dg75O2Dv5zyAWyI41S8mAXr1a
# uexdiQrQ1sXsK/bOgfSsa6QMuoEz5ygBgsASpDnJrkAfytpb9FusJItqOse9twcR
# hx8TUxAcMXFknRqTTIGVsI5EiW+Hz9IE7wlSKI64OWGgbA5CBPS9nQrNX03tjNvK
# X9fYnGc/M5AGQzX77lZEe+JFKP9xiagyp/U6NXzHkNGP3MI4HhcCKa22/WiKU8J3
# jBcMxXdYakAHohKrJwIDAQABo1EwTzALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUw
# AwEB/zAdBgNVHQ4EFgQUX98Zsdd22Rfwd96dNOgO2KG2SjAwEAYJKwYBBAGCNxUB
# BAMCAQAwDQYJKoZIhvcNAQEFBQADggEBAHFJx/l0oL0KlISxzlj4cgxzuTEmEfAC
# UZWDA18gEjWkGcmAIaO/5scnwIbHQhI7R7b3geyOQ+5UmvSuWZ+cyXpWUjpzqUbb
# XnGp0Jh1rEsS2IlXO1PN3dzZGfYlYjzCgsv14v4VRXaAy8ZjccC6/Hjz+F0l2Fwk
# ah6P8U1y2ieFJedEPhJG6Fo47B673b6aBnnyHBfQXzc0SvZ7ASQG+reBBq75hJ2q
# YeJ39Vgjr27qT8gfaaY2Ei5TDHO/tgnkrnZc+C1OGVyLpPljhtoItSRTACngxm2n
# TWpE1d4P9WQrzM6YrmnCWSz+a1qEYdU0EDCLgioHlcKNGjSh/UwBGsUwggQVMIIC
# /aADAgECAgsEAAAAAAExicZQBDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQLExdH
# bG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEG
# A1UEAxMKR2xvYmFsU2lnbjAeFw0xMTA4MDIxMDAwMDBaFw0yOTAzMjkxMDAwMDBa
# MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
# VQQDEyhHbG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAtIFNIQTI1NiAtIEcyMIIB
# IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqpuOw6sRUSUBtpaU4k/YwQj2
# RiPZRcWVl1urGr/SbFfJMwYfoA/GPH5TSHq/nYeer+7DjEfhQuzj46FKbAwXxKbB
# uc1b8R5EiY7+C94hWBPuTcjFZwscsrPxNHaRossHbTfFoEcmAhWkkJGpeZ7X61ed
# K3wi2BTX8QceeCI2a3d5r6/5f45O4bUIMf3q7UtxYowj8QM5j0R5tnYDV56tLwhG
# 3NKMvPSOdM7IaGlRdhGLD10kWxlUPSbMQI2CJxtZIH1Z9pOAjvgqOP1roEBlH1d2
# zFuOBE8sqNuEUBNPxtyLufjdaUyI65x7MCb8eli7WbwUcpKBV7d2ydiACoBuCQID
# AQABo4HoMIHlMA4GA1UdDwEB/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
# A1UdDgQWBBSSIadKlV1ksJu0HuYAN0fmnUErTDBHBgNVHSAEQDA+MDwGBFUdIAAw
# NDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
# dG9yeS8wNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLm5l
# dC9yb290LXIzLmNybDAfBgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDAN
# BgkqhkiG9w0BAQsFAAOCAQEABFaCSnzQzsm/NmbRvjWek2yX6AbOMRhZ+WxBX4Au
# wEIluBjH/NSxN8RooM8oagN0S2OXhXdhO9cv4/W9M6KSfREfnops7yyw9GKNNnPR
# FjbxvF7stICYePzSdnno4SGU4B/EouGqZ9uznHPlQCLPOc7b5neVp7uyy/YZhp2f
# yNSYBbJxb051rvE9ZGo7Xk5GpipdCJLxo/MddL9iDSOMXCo4ldLA1c3PiNofKLW6
# gWlkKrWmotVzr9xG2wSukdduxZi61EfEVnSAR3hYjL7vK/3sbL/RlPe/UOB74JD9
# IBh4GCJdCC6MHKCX8x2ZfaOdkdMGRE4EbnocIOM28LZQuTCCBEwwggM0oAMCAQIC
# ExMAAAAGLUYVgdAHJfgAAAAAAAYwDQYJKoZIhvcNAQEFBQAwGDEWMBQGA1UEAxMN
# VkNBTkFDQS0wMS1DQTAeFw0xNDA2MDYxOTEyMjJaFw0yNDA2MDYxOTIyMjJaMFkx
# GjAYBgoJkiaJk/IsZAEZFgpjYW5hLWdyb3VwMRkwFwYKCZImiZPyLGQBGRYJY2Fu
# YWdyb3VwMSAwHgYDVQQDExdjYW5hZ3JvdXAtVkNBTkFDQS0wMi1DQTCCASIwDQYJ
# KoZIhvcNAQEBBQADggEPADCCAQoCggEBALYAghcYHT1OPm+SA2FEWnnNNBltH4ix
# xES3za6BUIg9buOh4+NyUShKNwsWZtrL1SjA//SSMtyIqhwOSyz6Nfl3MaEd9BzS
# ME5TkPLey+EBHsDUEjhjhSLOS2HX/eRu10WATUB7QfJZgf/3K9C8GNSxe9KeIUvs
# 2liP5UfOrj60mseXyzKOAEXGT74IN58Czr3PQZfuRf1Vm6JH1DW1Mpbdvi5ZGr4F
# 0MLEhMQ01VxLPFKSlp4Kmt6MyPtkub9OJISvU3JDqxVisI7KKs87RW1wT/Og/TEc
# QWOsbUJm/SwjDIfvZlv5AiNGL91X05aXqFarIEma2pPp2QwdU85YCZsCAwEAAaOC
# AUwwggFIMBAGCSsGAQQBgjcVAQQDAgECMCMGCSsGAQQBgjcVAgQWBBRyijiHXgfL
# 88D1K7XaFeWY6OQiqDAdBgNVHQ4EFgQU05cxXe0i3fcSHG3Pg6X7qM5MzscwGQYJ
# KwYBBAGCNxQCBAweCgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQF
# MAMBAf8wHwYDVR0jBBgwFoAUX98Zsdd22Rfwd96dNOgO2KG2SjAwPwYDVR0fBDgw
# NjA0oDKgMIYuaHR0cDovL3ZjYW5hY2EtMDIvQ2VydEVucm9sbC9WQ0FOQUNBLTAx
# LUNBLmNybDBVBggrBgEFBQcBAQRJMEcwRQYIKwYBBQUHMAKGOWh0dHA6Ly92Y2Fu
# YWNhLTAyL0NlcnRFbnJvbGwvVkNBTkFDQS0wMV9WQ0FOQUNBLTAxLUNBLmNydDAN
# BgkqhkiG9w0BAQUFAAOCAQEAHV8j8+9DW2T5VsORwO2dJyRlp3ae0YYEkKKdgEB0
# IClWqOoUd0pGVXLlNWUEfTr3mbigzeNmtMWs7SsqlGuWech929GJJvHCJpx/gIWR
# OF0fE5WPS6+F400krI9DNToB8GBNkc/SBLGUcq8YlsqTvOp969MrhzaD0Ga7qUpL
# lIG7OJU59da5ckkvbq/05z2OZ/IO/3O6u9juAv82INd8z/WxZ5daEOOqH0DopDKE
# wg0jKzIaomqXi6JRO9EYsT1hEJazgVSzK1Zbe0SatL73Z2ORoVL+fBUL0UPrFp2N
# 4oBDmXK3YRO0b/czZE6vhPL0LcJcvmYEylcNxYiXQuNheDCCBMYwggOuoAMCAQIC
# DCRUuH8eFFOtN/qheDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJCRTEZMBcG
# A1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBUaW1l
# c3RhbXBpbmcgQ0EgLSBTSEEyNTYgLSBHMjAeFw0xODAyMTkwMDAwMDBaFw0yOTAz
# MTgxMDAwMDBaMDsxOTA3BgNVBAMMMEdsb2JhbFNpZ24gVFNBIGZvciBNUyBBdXRo
# ZW50aWNvZGUgYWR2YW5jZWQgLSBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
# AQoCggEBANl4YaGWrhL/o/8n9kRge2pWLWfjX58xkipI7fkFhA5tTiJWytiZl45p
# yp97DwjIKito0ShhK5/kJu66uPew7F5qG+JYtbS9HQntzeg91Gb/viIibTYmzxF4
# l+lVACjD6TdOvRnlF4RIshwhrexz0vOop+lf6DXOhROnIpusgun+8V/EElqx9wxA
# 5tKg4E1o0O0MDBAdjwVfZFX5uyhHBgzYBj83wyY2JYx7DyeIXDgxpQH2XmTeg8AU
# XODn0l7MjeojgBkqs2IuYMeqZ9azQO5Sf1YM79kF15UgXYUVQM9ekZVRnkYaF5G+
# wcAHdbJL9za6xVRsX4ob+w0oYciJ8BUCAwEAAaOCAagwggGkMA4GA1UdDwEB/wQE
# AwIHgDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBHjA0MDIGCCsGAQUFBwIBFiZodHRw
# czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMBYG
# A1UdJQEB/wQMMAoGCCsGAQUFBwMIMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9j
# cmwuZ2xvYmFsc2lnbi5jb20vZ3MvZ3N0aW1lc3RhbXBpbmdzaGEyZzIuY3JsMIGY
# BggrBgEFBQcBAQSBizCBiDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9i
# YWxzaWduLmNvbS9jYWNlcnQvZ3N0aW1lc3RhbXBpbmdzaGEyZzIuY3J0MDwGCCsG
# AQUFBzABhjBodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3N0aW1lc3RhbXBp
# bmdzaGEyZzIwHQYDVR0OBBYEFNSHuI3m5UA8nVoGY8ZFhNnduxzDMB8GA1UdIwQY
# MBaAFJIhp0qVXWSwm7Qe5gA3R+adQStMMA0GCSqGSIb3DQEBCwUAA4IBAQAkclCl
# DLxACabB9NWCak5BX87HiDnT5Hz5Imw4eLj0uvdr4STrnXzNSKyL7LV2TI/cgmkI
# lue64We28Ka/GAhC4evNGVg5pRFhI9YZ1wDpu9L5X0H7BD7+iiBgDNFPI1oZGhjv
# 2Mbe1l9UoXqT4bZ3hcD7sUbECa4vU/uVnI4m4krkxOY8Ne+6xtm5xc3NB5tjuz0P
# YbxVfCMQtYyKo9JoRbFAuqDdPBsVQLhJeG/llMBtVks89hIq1IXzSBMF4bswRQpB
# t3ySbr5OkmCCyltk5lXT0gfenV+boQHtm/DDXbsZ8BgMmqAc6WoICz3pZpendR4P
# vyjXCSMN4hb6uvM0MIIGfzCCBWegAwIBAgITTgAACW3cM1+/ejCSQAACAAAJbTAN
# BgkqhkiG9w0BAQUFADBZMRowGAYKCZImiZPyLGQBGRYKY2FuYS1ncm91cDEZMBcG
# CgmSJomT8ixkARkWCWNhbmFncm91cDEgMB4GA1UEAxMXY2FuYWdyb3VwLVZDQU5B
# Q0EtMDItQ0EwHhcNMTkwOTEwMTcxMzExWhcNMjAwOTA5MTcxMzExWjCBlDEaMBgG
# CgmSJomT8ixkARkWCmNhbmEtZ3JvdXAxGTAXBgoJkiaJk/IsZAEZFgljYW5hZ3Jv
# dXAxGTAXBgNVBAsTEENBTkEgR3JvdXAgVXNlcnMxGzAZBgNVBAsTEkNBTkEgTGlt
# aXRlZCBVc2VyczELMAkGA1UECxMCSVQxFjAUBgNVBAMTDUp1c3RpbiBIb2xtZXMw
# ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCnBfU4e3OaJ2884NQae573
# X08fTJlAp+9UkPQgtQcapVUgh++m5Gjsf0D9LEWfIyNioHzPXpPcimpwX/MQqyI5
# qThmAgzJlhG9GONGMd3yhwOqr1GnPeEgu47jpX/W/Dyz9ooqj4CYH6/KGebiEP9u
# 27xRtG3P279OoGXfaqWlZw1uDKRJQrkzJST432fD/36V3hJWGgtU6B6x2Ni5jlmN
# e9IJtNzSCtCn7b1UN8nxfsl2XbqARDVH6lpLA7MT76xI4Z4fRCJu9nR8dmKKrQji
# oM9aBaMPWIo8PCd8dnxeFPFmq3cVcQRPM8ZS2MnsIoZUhsFlLcuNR0BjkVLhBgrR
# AgMBAAGjggMCMIIC/jALBgNVHQ8EBAMCB4AwPQYJKwYBBAGCNxUHBDAwLgYmKwYB
# BAGCNxUIgpSHfILYwxuC3Y8nhLzjEIeB3VeBVYT1wxW741wCAWQCAQUwHQYDVR0O
# BBYEFAHEyQIMrcHjAnBPvzmW8+MzdwpMMB8GA1UdIwQYMBaAFNOXMV3tIt33Ehxt
# z4Ol+6jOTM7HMIIBNQYDVR0fBIIBLDCCASgwggEkoIIBIKCCARyGgcpsZGFwOi8v
# L0NOPWNhbmFncm91cC1WQ0FOQUNBLTAyLUNBLENOPXZDQU5BQ0EtMDIsQ049Q0RQ
# LENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZp
# Z3VyYXRpb24sREM9Y2FuYWdyb3VwLERDPWNhbmEtZ3JvdXA/Y2VydGlmaWNhdGVS
# ZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBv
# aW50hk1odHRwOi8vdkNBTkFDQS0wMi5jYW5hZ3JvdXAuY2FuYS1ncm91cC9DZXJ0
# RW5yb2xsL2NhbmFncm91cC1WQ0FOQUNBLTAyLUNBLmNybDCB0gYIKwYBBQUHAQEE
# gcUwgcIwgb8GCCsGAQUFBzAChoGybGRhcDovLy9DTj1jYW5hZ3JvdXAtVkNBTkFD
# QS0wMi1DQSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2Vy
# dmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1jYW5hZ3JvdXAsREM9Y2FuYS1ncm91
# cD9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1
# dGhvcml0eTATBgNVHSUEDDAKBggrBgEFBQcDAzAbBgkrBgEEAYI3FQoEDjAMMAoG
# CCsGAQUFBwMDMDAGA1UdEQQpMCegJQYKKwYBBAGCNxQCA6AXDBVKdXN0aW4uSG9s
# bWVzQGNhbmEuY2EwDQYJKoZIhvcNAQEFBQADggEBAK/51/vESFjme4tgkr8wOoNJ
# QRX2j+q90c9tPNjsdad8cAM+EzqGFuhe9WjA/1vG7oY8mXHkxm9Xr9HgCUSyuZcs
# OhzHXv+NbmLPbH6UB3g5pTR3ALzze/AqDYgtLhVtI7O4r4LWi6VMk9dZBC9LLD9Q
# RHIBjGfY0Jzxty+PEjFxZ60PyJl7sLYxgYZYT9N40//jVT+SnLgj98SQ8yeiWcBZ
# Jds9WyqzvgthmMt1SXD+99dra1ifDOs5wXV3JRApujDfRiLjxWsnEKi6xOuq8u3i
# gVMwWgHTOaC1fkOVyxaeuI3ewnEz0I35Ec4D3c3Tcd0w6TCx2pe/5JsPLfsHg5gx
# ggSmMIIEogIBATBwMFkxGjAYBgoJkiaJk/IsZAEZFgpjYW5hLWdyb3VwMRkwFwYK
# CZImiZPyLGQBGRYJY2FuYWdyb3VwMSAwHgYDVQQDExdjYW5hZ3JvdXAtVkNBTkFD
# QS0wMi1DQQITTgAACW3cM1+/ejCSQAACAAAJbTANBglghkgBZQMEAgEFAKBMMBkG
# CSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMC8GCSqGSIb3DQEJBDEiBCB9jKGPZLtb
# RF7GJvEUJDxQVZyQg7ellqumIHyY3SLXcjANBgkqhkiG9w0BAQEFAASCAQCkfE9n
# 2D+tOTZbYub/TOYoBm7qzgB8freao/3M4Pbw3+nmTZd/3JlZo3zzXczVP0mavzdk
# vpSQ/CeK26WaaVuSIdA9zuCtpSpHxwyF/OmM03g99oxoWrg3FKjC/NWUEGVQalqR
# lsrWXEAZPofi1vbhwlhz0DIpcJHnbcT/Boz0zjWJaRQqTE5zrEvaiBpffAnRM2qe
# GJULRzT3g5YmiGUFYouo/LBPR6SyvIMvTacdl7RIyJCXHMnSXPEcMxleegZqgUIX
# Hyp+e32HgsS2d7EBliM5lm1SKJJjFm+d1MqLnoaWXzsbXrAMABhT9hHVjVJtLFVG
# 6qfTjxt5IQDfjSdIoYICuTCCArUGCSqGSIb3DQEJBjGCAqYwggKiAgEBMGswWzEL
# MAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMT
# KEdsb2JhbFNpZ24gVGltZXN0YW1waW5nIENBIC0gU0hBMjU2IC0gRzICDCRUuH8e
# FFOtN/qheDANBglghkgBZQMEAgEFAKCCAQwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
# DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkxMTEyMjI1NjQyWjAvBgkqhkiG9w0BCQQx
# IgQgZ21OgrZdvtssCPF7pAaMABqekSkm+FYOgKwGuAlZjIQwgaAGCyqGSIb3DQEJ
# EAIMMYGQMIGNMIGKMIGHBBQ+x2bV1NRy4hsfIUNSHDG3kNlLaDBvMF+kXTBbMQsw
# CQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMo
# R2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0EgLSBTSEEyNTYgLSBHMgIMJFS4fx4U
# U603+qF4MA0GCSqGSIb3DQEBAQUABIIBAAiPzQNvLrbeQKwszgmsHzEFyuZwhSw5
# eoVLWWhUHqja109gvwEsKHFnaDstJOZgN/0U86bbhulWdopxnQ8TWhhMq+7nPYVQ
# rWUdNen9ehPJtD2pwbcYFIVe1P0RxwTUaGhbANi+QwkLUluLT2EjEny4rwuRlHNb
# T0hIBGcaK/WLEFFNnlw/BZcVyBxWaTWfMQxN6vbgCIbCTJc07EqOAwWglaGRVa5K
# tEXeGqUhiGT4F+YPfvwJpyuWrsUW4GOBQ2yxuTGpoo2hhrMbSNu4WYuyuiSXF4AB
# jIHBGd6UbmM2TcIuKfPTbObTNn528HZGXbXEoIpIiWXPOT8dw6q5SYQ=
# SIG # End signature block
