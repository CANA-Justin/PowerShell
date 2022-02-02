<#	
	.NOTES
	===========================================================================
	 Created on:   	02/19/2019 11:58 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	CANANewUser.pms1
	-------------------------------------------------------------------------
	 Module Name: CANANewUser
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>


Write-Verbose "Importing Scripts"
Write-Debug "Importing *.PS1 from \\canagroup.cana-group\business\IT Storage\Scripts\CANA-Justin\PowerShell\Modules\CANANewUser\Templates\"
$ImportTemplateModules = Get-ChildItem -Path "\\canagroup.cana-group\business\IT Storage\Scripts\CANA-Justin\PowerShell\Modules\CANANewUser\Templates\*.ps1" -Recurse -Force -exclude "*.TempPoint.ps1"
Write-Debug "Importing *.PS1 from \\canagroup.cana-group\business\IT Storage\Scripts\CANA-Justin\PowerShell\Modules\CANANewUser"
$ImportTemplateModules += Get-ChildItem -Path "\\canagroup.cana-group\business\IT Storage\Scripts\CANA-Justin\PowerShell\Modules\CANANewUser\CreateUser.ps1" -Force #-exclude "*.ps1"
foreach ($TemplateModule in $ImportTemplateModules)
{
	Write-Debug "Importing $TemplateModule"
	Import-Module $TemplateModule
}
Write-Verbose "Done Importing Scripts"
Write-Debug "Done Importing Scripts"

#This function will take the $FirstName & #SirName and convert it to the username SirName+First Letter of First Name#
function New-MakeUsername ()
{
	<#
.SYNOPSIS
    
.DESCRIPTION
    
.NOTES
    
.LINK
    
.EXAMPLE
    
.EXAMPLE
    
.INPUTTYPE
   
.RETURNVALUE

.COMPONENT
#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory=$true)]
		[string]$FirstName = $args[0],
		[parameter(Mandatory=$true)]
		[string]$SirName = $args[1],
		[parameter(Mandatory=$false)]
		[string]$UserName

		)
		
	Write-Debug "Given name is $($GivenName)"
	Write-Debug "First name is $($FirstName)"
	Write-Debug "Last name is $($SirName)"
	Write-Debug "User name is $($UserName)"
	
	$UserName = $SirName + $FirstName.substring(0, 1)
	$UserName = $UserName.ToLower()
	
	Write-Debug "Username is now $($UserName)"
	Write-Verbose "Username is now $($UserName)"
	return $UserName
	#Write-Debug "Moving to function ValidateUserName"
	
}

#This function will check the username for whitespace or dashs.  White space will be removed, dashs just throw an information warning (as requested)#
function Search-ValidateUserName
{
<#
.SYNOPSIS
    
.DESCRIPTION
    
.NOTES
    
.LINK
    
.EXAMPLE
    
.EXAMPLE
    
.INPUTTYPE
   
.RETURNVALUE

.COMPONENT
#>

	
	if ($UserName -match "\s")
	{
		Write-Debug "Matched whitespace"
		write-verbose "This User Name contains a white space"
		Write-Debug "Removing whitespace from username $($UserName)"
		Write-Verbose "Removing whitespace from username $($UserName)"
		$UserName = $UserName -replace '(\s)', ''
		Write-Debug "Removed whitespace"
		Write-Debug "Username is now $($UserName)"
		Write-Verbose "Username is now $($UserName)"
	}
	if ($UserName -match "-")
	{
		Write-Debug "Username has DASH in it"
		Write-Information "The User Name $($UserName) contains a dash"
		Write-Verbose "Username is $($UserName)"
		Write-Debug "Cool, don't care about DASHES"
	}
	Write-Debug "Passed IFs on Username. No irregularities"
	Write-Verbose "Username $($UserName) is OK!"
	Write-Debug "Done Check-ValidateUserName"

	return $UserName
		
}
function Connect-DomainController
{
<#
.SYNOPSIS
    
.DESCRIPTION
    
.NOTES
    
.LINK
    
.EXAMPLE
    
.EXAMPLE
    
.INPUTTYPE
   
.RETURNVALUE

.COMPONENT
#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $true)]
		[string]$AdminCredentials = $args[0],
		[parameter(Mandatory = $true)]
		[string]$DomainController1 = $args[1],
		[parameter(Mandatory = $false)]
		[string]$DomainController2 = $args[2]
	)
	
	
	#If (Get-PSSession -ComputerName MyServerName | $script:RemoteDC = Connect-PSSession)
	#{}
	
	Write-debug "Testing $($DomainController1) for connectivity"
	$DC1 = test-connection -quiet -ComputerName $DomainController1
	Write-debug "Domain Controller $($DomainController1) availability is $($DC1)"
	Write-debug "Testing $($DomainController2) for connectivity"
	$DC2 = test-connection -quiet -ComputerName $DomainController2
	Write-debug "Domain Controller $($DomainController2) availability is $($DC2)"
	If ($DC1 = $false)
	{
		Write-Debug "$($DomainController1) is unavialable"
		Write-Debug "Test-Connection was $($DC1)"
		Write-Debug "Trying $($DomainController2)"
		If ($DC2 = $false)
		{
			Write-Debug "No provided Domain Controllers connectable"
			Write-Error "No provided Domain Controllers connectable"
			Write-Debug "Exiting!"
			Exit
		}
		Else
		{
			Write-Debug "$($DomainController2) is aviablable"
			Write-Debug "Setting RemoteDC to $($DomainController2)"
			$RemoteDC = $DomainController2
		}
	}
	Else
	{
		Write-Debug "$($DomainController1) is aviablable"
		Write-Debug "Setting RemoteDC to $($DomainController1)"
		$RemoteDC = $DomainController1
	}
	
	#Write-Debug "Requesting Username\Password"
	#$PSCredUser = Read-Host "Username to connect to $($DomainController1)"
	#$PSCredPass = Read-Host -AsSecureString "Password to connect to $($DomainController1)"
	#Write-Debug "Making Cerdentials to pass to New-PSSession"
	#$PSCred = new-object -typename System.Management.Automation.PSCredential -argumentlist $PSCredUser, $PSCredPass
	Write-Debug "Calling NewPSSession"
	$RemoteSession = New-PSSession -ComputerName $RemoteDC -Credential $AdminCredentials
	Write-Debug "NewPSSession established"
	Write-Debug "Done Enter-DomainController"
	
	Return $RemoteSession
	
}


#This function will check if the $UserName exists.  If it does it will add the 2nd letter from the $FirstName to the end of the $UserName#
	function Submit-UserName ()
{
	<#
.SYNOPSIS
    
.DESCRIPTION
    
.NOTES
    
.LINK
    
.EXAMPLE
    
.EXAMPLE
    
.INPUTTYPE
   
.RETURNVALUE

.COMPONENT
#>
	[CmdletBinding()]
	param (
	[parameter(Mandatory = $true)]
	[string]$UserName = $args[0],
	[parameter(Mandatory = $true)]
	$RemoteSession = $args[1]
	)
	
	
	
	
	
	Write-Verbose "Going to check $UserName on $RemoteDC for conflict"
	Write-Debug "Going to check $UserName on $RemoteDC for conflict"
	Write-Debug "Opening PSSession with $($RemoteDC)"
	#Enter-PSSession -Session $RemoteSession #-ScriptBlock {
	#Import-PSSession -Session $RemoteSession
	Invoke-Command -Session $RemoteSession -ScriptBlock {
		#$DCUsername = $UserName
		
		
		try
		{
			Write-Debug "Checking with Active Directory for $($UserName)"
			$namecheck = get-aduser -filter { samaccountname -like '$UserName' }
			
		}
		catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
		{ }
		
		Write-Debug "AD replied, checking if True or False"
		if ($namecheck.Enabled -eq $true)
		{
			
			Write-Verbose "UserName $($UserName) is in use $($namecheck.Enabled)"
			#$DCUserName = $DCSirName + $DCFirstName.substring(0, 2)
			#Write-Verbose "trying username $DCUserName"
			#Write-Debug "trying username $DCUserName"
			Write-Verbose "Exiting from Check-UserName"
			Exit
			
		}
		else
		{
			
			Write-Verbose "$UserName is avalable"
			Write-Debug "$UserName is avalable"
			return $true
			
		}
	}
	
	#} -ArgumentList $UserName
	Write-Debug "Closing PSSession with Exit-PSSession"
	#remove-PSSession
	Write-Debug "Closed PSSession"
	Write-Debug "Done Submit-UserName"
}








function Connect-Exchange
{
<#
.SYNOPSIS
    
.DESCRIPTION
    
.NOTES
    
.LINK
    
.EXAMPLE
    
.EXAMPLE
    
.INPUTTYPE
   
.RETURNVALUE

.COMPONENT
#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $true)]
		[string]$AdminCredentials = $args[0],
		[parameter(Mandatory = $true)]
		[string]$Exchange1 = $args[1],
		[parameter(Mandatory = $false)]
		[string]$Exchange2 = $args[2]
	)
	
	
	#If (Get-PSSession -ComputerName MyServerName | $script:RemoteDC = Connect-PSSession)
	#{}
	
	Write-debug "Testing $($Exchange1) for connectivity"
	$EX1 = test-connection -quiet -ComputerName $Exchange1
	Write-debug "Exchange Server $($Exchange1) availability is $($EX1)"
	Write-debug "Testing $($Exchange2) for connectivity"
	$EX2 = test-connection -quiet -ComputerName $Exchange2
	Write-debug "Exchange Server $($Exchange2) availability is $($EX2)"
	$RemoteEXCH = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://vCANAEXCH-01/PowerShell/ -Authentication Kerberos -Credential $AdminCredentials
	
	
	Return $RemoteEXCH
}

function New-UserMailbox
{
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $true)]
		[string]$UserName = $args[0],
		[parameter(Mandatory = $false)]
		$RemoteEXCH = $args[1]
	)
	
	if (! (Get-PSSnapin -Registered Microsoft.Exchange.Management.PowerShell.E2010 -ErrorAction:SilentlyContinue))
	{
		Write-Warning "This script must be run in the Exchange Management Shell"
		exit
	}
	
	Import-PSSession $RemoteEXCH
	
	Enable-Mailbox -Identity $Username -Database "CANA Mail 03"
}


function New-HomeFolder
{
	[CmdletBinding(PositionalBinding = $true)]
	param
	(
		[Parameter(Mandatory = $true,
				   Position = 0)]
		[string]$UserName,
		[Parameter()]
		[ValidateScript({ Test-Path -Path $_ })]
		[string]$BaseHomeFolderPath = '\\canagroup.cana-group\HomeDrive\Users'
	)
	

	
	#region Ensure the home folder to create doesn't already exist
	$homeFolderPath = "$BaseHomeFolderPath\$UserName"
	if (Test-Path -Path $homeFolderPath)
	{
		throw "The home folder path [$homeFolderPath] already exists."
	}
	
	
	Write-debug "Disable inheritance and Remove Permission on $homeFolderPath"
	ICACLS $homeFolderPath /inheritance:r
	# setup basic permissions for all folders.
	
	ICACLS $homeFolderPath /T /Grant "administrator:(CI)(OI)(F)"
	
	MKDir $homeFolderPath\"My Documents"
	MKDir $homeFolderPath\"My Documents\Scans"
	
	ICACLS $homeFolderPath /T /Grant "Ricoh:(CI)(OI)(RX)"
	ICACLS $homeFolderPath /T /Grant "svcHTIscan:(CI)(OI)(RX)"
	ICACLS $homeFolderPath /T /Grant "Domain Admins:(CI)(OI)(F)"
	ICACLS $homeFolderPath\"My Documents\Scans" /T /Grant "Ricoh:(CI)(OI)(RX,W,D)"
}

function New-HomeFolder2
{
	[CmdletBinding(PositionalBinding = $true)]
	param
	(
		[Parameter(Mandatory = $true,
				   Position = 0)]
		[string]$UserName,
		[Parameter()]
		[ValidateScript({ Test-Path -Path $_ })]
		[string]$BaseHomeFolderPath = '\\canagroup.cana-group\HomeDrive\Users'
	)
	
	ICACLS $homeFolderPath /T /Grant $UserName":(CI)(OI)(F)"
	
}