<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2020 v5.7.174
	 Created on:   	04/29/2020 10:45 AM
	 Created by:   	admJustin
	 Organization: 	
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>


#Requires -RunAsAdministrator	
$Credentials = Get-Credential

$ErrorActionPreference = "Stop"

Try
{
	$Session = New-PSSession -ConfigurationName Microsoft.Exchange `
							 -ConnectionUri https://outlook.office365.com/powershell-liveid/ `
							 -Credential $Credentials `
							 -Authentication Basic `
							 -AllowRedirection
	
	Import-PSSession $Session -DisableNameChecking -AllowClobber
}
Catch
{
	$host.ui.WriteErrorLine("Failed to create O365 session: $_")
	Break
}

function Set-BCASJournaling($RuleName, $BarracudaDomain, $TenantID, $Session)
{
	$BarracudaAddress = "$TenantID@$BarracudaDomain"
	
	### Configure remote domain
	
	$RemoteDomains = Get-RemoteDomain
	$SetNewRemoteDomain = $true
	$RemoteDomainToUpdate = $RuleName
	
	foreach ($Domain in $RemoteDomains)
	{
		if ($Domain.DomainName -eq $BarracudaDomain)
		{
			$SetNewRemoteDomain = $false
			$RemoteDomainToUpdate = $Domain.Name
			Break
		}
	}
	
	if ($SetNewRemoteDomain)
	{
		Write-Host "Configuring new Barracuda remote domain."
		New-RemoteDomain -Name $RuleName -DomainName $BarracudaDomain
	}
	else
	{
		Write-Host "Updating configuration of current Barracuda remote domain."
	}
	
	Set-RemoteDomain $RemoteDomainToUpdate -AutoReplyEnabled $false
	Set-RemoteDomain $RemoteDomainToUpdate -AllowedOOFType None
	Set-RemoteDomain $RemoteDomainToUpdate -AutoForwardEnabled $true
	Set-RemoteDomain $RemoteDomainToUpdate -DeliveryReportEnabled $false
	Set-RemoteDomain $RemoteDomainToUpdate -DisplaySenderName $false
	Set-RemoteDomain $RemoteDomainToUpdate -NDREnabled $false
	Set-RemoteDomain $RemoteDomainToUpdate -TNEFEnabled $false
	
	### Configure outbound connector
	
	$OutboundConnectors = Get-OutboundConnector
	$SetNewConnector = $true
	
	foreach ($Connector in $OutboundConnectors)
	{
		if ($Connector.RecipientDomains -eq $BarracudaDomain -and $Connector.UseMXRecord -and $Connector.Enabled)
		{
			$SetNewConnector = $false
			Break
		}
	}
	
	if ($SetNewConnector)
	{
		Write-Host "Configuring new Barracuda outbound connector."
		
		New-OutboundConnector -Name $RuleName `
							  -RecipientDomains $BarracudaDomain  `
							  -Comment "This connector is used to send journaling messages to the Barracuda Cloud Archiving Service." `
							  -ConnectorType Partner `
							  -TlsSettings EncryptionOnly `
							  -Enabled $true
	}
	else
	{
		Write-Host "Using previously configured Barracuda outbound connector."
	}
	
	### Configure undeliverable journal reports address
	
	$Config = Get-TransportConfig
	$CurrentAddress = $Config.JournalingReportNdrTo
	
	if ($CurrentAddress -and $CurrentAddress -ne "<>")
	{
		Write-Host "Using previously configured undeliverable journal address."
	}
	else
	{
		### Create a shared mailbox, giving access to the specified user,
		### and set the shared mailbox as JournalingReportNdrTo
		
		$CustomerDomain = $Credentials.UserName.Split("@")[1]
		$NDRAlias = "BarracudaNDR"
		$NDRName = "Barracuda NDR"
		$NDREmail = "$NDRAlias@$CustomerDomain"
		
		New-Mailbox -Shared -Name $NDRName -Alias $NDRAlias -PrimarySmtpAddress $NDREmail
		
		Add-MailboxPermission -Identity $NDRName -User $Credentials.UserName -AccessRights FullAccess -InheritanceType All
		
		Set-TransportConfig -JournalingReportNdrTo $NDREmail
		
		Write-Host "Created shared mailbox user $NDREmail and set as JournalingReportNdrTo"
	}
	
	### Set up journal rule
	
	$JournalRules = Get-JournalRule
	$SetNewRule = $true
	
	foreach ($Rule in $JournalRules)
	{
		if ($Rule.JournalEmailAddress -eq $BarracudaAddress -and $Rule.Enabled)
		{
			$SetNewRule = $false
			Break
		}
	}
	
	if ($SetNewRule)
	{
		Write-Host "Configuring new Barracuda journal rule."
		New-JournalRule -Name $RuleName `
						-Scope Global `
						-JournalEmailAddress $BarracudaAddress `
						-Enabled $true
	}
	else
	{
		Write-Host "Using previously configured Barracuda journal rule."
	}
}



Try
{
	Set-BCASJournaling -BarracudaDomain "mas.ca.barracudanetworks.com" -RuleName "Barracuda Cloud Archiving Service - bma_82965cad" -TenantId "bma_82965cad-11da-4734-b561-c7630d435e3f"
}
Catch
{
	$host.ui.WriteErrorLine("Error caught in Set-BCASJournaling: $_")
}


Remove-PSSession $Session

