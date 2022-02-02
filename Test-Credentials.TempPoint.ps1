<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.170
	 Created on:   	12/16/2019 1:22 PM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	Test-Cre
	===========================================================================
	.DESCRIPTION
		Stolen from https://www.powershellbros.com/test-credentials-using-powershell-function/ and edited for CANA
#>

function Test-Credentials
{
	
	[CmdletBinding()]
	[OutputType([String])]
	Param (
		[Parameter(
				   Mandatory = $false,
				   ValueFromPipeLine = $true,
				   ValueFromPipelineByPropertyName = $true
				   )]
		[Alias(
			   'PSCredential'
			   )]
		[ValidateNotNull()]
		[System.Management.Automation.PSCredential][System.Management.Automation.Credential()]
		$Credentials
	)
	$Domain = $null
	$Root = $null
	$Username = $null
	$Password = $null
	
	If ($Credentials -eq $null)
	{
		Try
		{
			$Credentials = Get-Credential "domain\$env:username" -ErrorAction Stop
		}
		Catch
		{
			$ErrorMsg = $_.Exception.Message
			Write-Warning "Failed to validate credentials: $ErrorMsg "
			Pause
			Break
		}
	}
	
	# Checking module
	Try
	{
		# Split username and password
		$Username = $credentials.username
		$Password = $credentials.GetNetworkCredential().password
		
		# Get Domain
		$Root = "LDAP://" + ([ADSI]'').distinguishedName
		$Domain = New-Object System.DirectoryServices.DirectoryEntry($Root, $UserName, $Password)
	}
	Catch
	{
		$_.Exception.Message
		Continue
	}
	
	If (!$domain)
	{
		Write-Warning "Something went wrong"
	}
	Else
	{
		If ($domain.name -ne $null)
		{
			return "Authenticated"
		}
		Else
		{
			return "Not authenticated"
		}
	}
}
