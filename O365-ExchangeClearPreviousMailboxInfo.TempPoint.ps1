<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2020 v5.7.181
	 Created on:   	10/15/2020 10:32 AM
	 Created by:   	admJustin
	 Organization: 	
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

#Requires -RunAsAdministrator	
Import-Module "\\canagroup.cana-group\business\IT Storage\Scripts\CANA-Justin\PowerShell\Select-MenuItem.ps1"



if (Get-Module -ListAvailable -Name ExchangeOnlineManagement)
{
	Write-Verbose "Module ExchangeOnlineManagement exists on system"
}
else
{
	Write-Verbose "Module ExchangeOnlineManagement does not exist on system"
	
	
	Write-Host "Module" -nonewline
	Write-Host " ExchangeOnlineManagement" -NoNewline -ForegroundColor Red
	Write-Host " does not exist on this system"
	Write-Host "You NEED to install this module for this script to work"
	
	$Ans2 = select-menuitem -heading "Install Module" -prompt "Would you like to install the ExchangeOnlineManagement module?" -menutext 'yn' -default "no"
	
	if ($Ans2 -eq "Yes")
	{
		Write-Verbose "Installing ExchangeOnlineManagement"
		Write-Host "Installing ExchangeOnlineManagement"
		Install-Module -Name ExchangeOnlineManagement -Force -MinimumVersion 0.3582.0
		
		Write-Verbose "Done installing ExchangeOnlineManagement"
		Write-Host "Done installing ExchangeOnlineManagement"
	}
	else
	{
		
		Write-Host " " -BackgroundColor Yellow
		Write-Host " " -BackgroundColor Yellow -NoNewline
		Write-Host " You have choosen to not install ExchangeOnlineManagement module " -BackgroundColor Black
		Write-Host " " -BackgroundColor Yellow -NoNewline
		Write-Host " Operation aborted!                                              " -ForegroundColor Red -BackgroundColor Black
		Write-Host " " -BackgroundColor Yellow
		Pause
		exit
	}
	
}
Write-Host ""
Write-Host ""
$AdminUsername = Read-Host "Enter the username/email of your O365 Administrator"

Write-Verbose "Importing module ExchangeOnlineManagement"
Import-Module ExchangeOnlineManagement

Write-Verbose "Connecting to Office 365 with $AdminUsername"
Connect-ExchangeOnline -UserPrincipalName $AdminUsername -DelegatedOrganization canagroup.onmicrosoft.com


$ClientUsername = Read-Host "Enter the username/email of your f*ed user"

Write-Host ""
Write-Host ""

$Ans3 = select-menuitem -heading "DELETE MAILBOX" -prompt "Would you like to permanently delete $ClientUsername online mailbox and start the migration again?" -menutext 'yn' -default "no"


if ($Ans3 -eq "Yes")
{
	Set-User -Identity $ClientUsername -PermanentlyClearPreviousMailboxInfo
}
else
{
	
	Write-Host " " -BackgroundColor Yellow
	Write-Host " " -BackgroundColor Yellow -NoNewline
	Write-Host " You have choosen to not delete $ClientUsername online mailbox " -BackgroundColor Black
	Write-Host " " -BackgroundColor Yellow -NoNewline
	Write-Host " Operation aborted!                                              " -ForegroundColor Red -BackgroundColor Black
	Write-Host " " -BackgroundColor Yellow
	Pause
	exit
}



