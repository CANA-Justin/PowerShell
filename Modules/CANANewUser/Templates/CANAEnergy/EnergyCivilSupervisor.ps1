<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.159
	 Created on:   	03/28/2019 1:10 PM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	EnergySupervisorForeman.ps1
	===========================================================================
	.SYNOPSIS
		Adds the user to the groups defined in this function Add-EnergySupervisorForeman
	
	.DESCRIPTION
		Adds the user to the groups defined in this function Add-EnergySupervisorForeman
#>


function Add-EnergySupervisorForeman
{
<#
	.SYNOPSIS
		Adds the user to the groups defined in this function
	
	.DESCRIPTION
		Adds the user to the groups defined in this function

		All CANA Energy Users
		CANA Energy - Infrastructure
		CANA Energy Approved Drivers
		CANA Energy Foreman - Infrastructure
		CANA Energy Supervisors - Infrastructure
		All Users
		FWC52TimeKeeper
		SP_Energy_Staff
		SP_Energy_Supervisors
		stfa.Energy.Archive.READ
		stfa.Energy.Engineering.READ
		tfa.Energy.Administrative.READ
		tfa.Energy.Procurement.READ
		VPN_Access
		Drive J - Business
		Password.Policy.NonExpire
	
	.EXAMPLE
				PS C:\> Add-EnergyCivilForeman $Username
	
.NOTES
		Using an array and a foreach loop, the listed AD groups are added to the users group membership.  This file is expected to be imported in to the overall module to allow flexibility for adding new rolls, or modifying existing ones without having to modify the core script or module.
#>	
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $true)]
		[string]$Username
	)
	Write-Debug "The username is $Username"
	Write-Debug "Creating empty array"
	$ADGroups = [System.Collections.ArrayList]@()
	
	Write-Debug "Adding groups to the Array"
	Write-Verbose "Adding groups to the Array"
	
	
	$ADGroups.add('All CANA Energy Users') | Out-Null
	$ADGroups.add('All Users') | Out-Null
	$ADGroups.add('CANA Energy - Infrastructure') | Out-Null
	$ADGroups.add('CANA Energy Approved Drivers') | Out-Null
	$ADGroups.add('CANA Energy Foreman - Infrastructure') | Out-Null
	$ADGroups.add('CANA Energy Supervisors - Infrastructure') | Out-Null
	$ADGroups.add('Drive J - Business') | Out-Null
	$ADGroups.add('FWC52TimeKeeper') | Out-Null
	$ADGroups.add('Password.Policy.NonExpire') | Out-Null
	$ADGroups.add('portal.Procore') | Out-Null
	$ADGroups.add('SP_Energy_Staff') | Out-Null
	$ADGroups.add('SP_Energy_Supervisors') | Out-Null
	$ADGroups.add('SP_Managers_All') | Out-Null
	$ADGroups.add('stfa.Energy.Archive.READ') | Out-Null
	$ADGroups.add('stfa.Energy.Engineering.READ') | Out-Null
	$ADGroups.add('stfa.Utilities.Project.02RegulatoryExternalAgencies.READ') | Out-Null
	$ADGroups.add('stfa.Utilities.Project.07Drawings.READ') | Out-Null
	$ADGroups.add('stfa.Utilities.Project.08Construction.READ') | Out-Null
	$ADGroups.add('stfa.Utilities.Project.09TestingCommissioning.READ') | Out-Null
	$ADGroups.add('SW_Viewpoint_Users') | Out-Null
	$ADGroups.add('tfa.Energy.Administrative.READ') | Out-Null
	$ADGroups.add('tfa.Energy.Procurement.READ') | Out-Null
	$ADGroups.add('tfa.Utilities.Crew&ProjectResources.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.Divisions.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.Divisions.READ') | Out-Null
	$ADGroups.add('tfa.Utilities.EmployeeCertificates.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.EmployeeFieldAssessment.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.EquipmentCertificates.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.Estimate.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.Project.RWED') | Out-Null
	$ADGroups.add('tfa.Utilities.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.Scans.RWED') | Out-Null
	$ADGroups.add('tfa.Utilities.StructureandStandardsManualPlusMaps.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.Training.Read') | Out-Null
	$ADGroups.add('VPN_Access') | Out-Null
	$ADGroups.add('SP.Energy.Safety.Notifications') | Out-Null
	
	#$ADGroups.add('NAME') | Out-Null
	
	Write-Debug "Array contains $ADGroups"
	Write-Verbose "Added list of groups to array"
	
	Write-Debug "Starting Foreach"
	foreach ($ADGroup in $ADGroups)
	{
		Add-ADGroupMember -Identity $ADGroup -Members $Username
		Write-Debug "Adding $Username to the group $ADGroup"
		Write-Verbose "Adding $Username to the group $ADGroup"
	}
	
}