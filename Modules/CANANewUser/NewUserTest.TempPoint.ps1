<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.159
	 Created on:   	02/22/2019 11:39 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	Test-Module.ps1
	===========================================================================
	.DESCRIPTION
	The Test-Module.ps1 script lets you test the functions and other features of
	your module in your PowerShell Studio module project. It's part of your project,
	but it is not included in your module.

	In this test script, import the module (be careful to import the correct version)
	and write commands that test the module features. You can include Pester
	tests, too.

	To run the script, click Run or Run in Console. Or, when working on any file
	in the project, click Home\Run or Home\Run in Console, or in the Project pane, 
	right-click the project name, and then click Run Project.
#>
#Requires -RunAsAdministrator
$versionMinimum = [Version]'5.1'

if ($versionMinimum -gt $PSVersionTable.PSVersion)
{ throw "This script requires PowerShell $versionMinimum" }
#Requires -Version 5.1
"Requires version $versionMinimum"
"Running PowerShell $($PSVersionTable.PSVersion)."

#Explicitly import the module for testing

Import-Module "\\canagroup.cana-group\business\IT Storage\Scripts\CANA-Justin\PowerShell\Modules\CANANewUser\CANANewUser.psm1" -force
Import-Module "\\canagroup.cana-group\business\IT Storage\Scripts\CANA-Justin\PowerShell\Modules\CANANewUser\CreateUser.ps1" -force

$AdminCredentials = Get-Credential -Message "Credential are required for access the Domain Controller, File server and Exchange server"


$GivenName = "Dan"
$FirstName = "Justin"
$MiddleInitial = "R"
$SirName = "Van Holmes"
#$UserName = "vanholmesj"
$Department = "120-Information Technology"
$Title = "IT Technical Analyst"
$Manager = "georgek"
$CompanyGroup = "95-CANA Limited"
$DomainController1 = "vcana-dc01"
$DomainController2 = "vcana-dc02"
$Exchange1 = "vCANAEXCH-01"
$Exchange2 = "vCANAEXCH-02"
#Write-Debug "Call module"
#Get-Command -Module CANANewUser 
Write-Debug "Call New-MakeUsername"
$UserName = New-MakeUsername $FirstName $SirName
Write-Debug "End MakeUsername"
Write-Debug "Call Check-ValidateUserName"
$UserName = Search-ValidateUserName $UserName
Write-Debug "End Check-ValidateUserName"

Write-Debug "Call Enter-DomainController"
$RemoteSession = Connect-DomainController $AdminCredentials $DomainController1 $DomainController2
Write-Debug "End Enter-DomainController"
Write-Debug "Call Submit-UserName"
Submit-UserName $UserName $RemoteSession
$SubmitUserName = $Username
Submit-UserName $SubmitUserName
Write-Debug "End Check-UserName"
New-HomeFolder $UserName
New-ADUserCreation $FirstName $SirName $MiddleInitial $UserName $CompanyGroup $Department $Manager $Title
New-HomeFolder2 $UserName
Add-CommissioningSupervisor $UserName

$RemoteEXCH = Connect-Exchange $AdminCredentials $Exchange1 $Exchange2

New-UserMailbox $UserName $RemoteEXCH

