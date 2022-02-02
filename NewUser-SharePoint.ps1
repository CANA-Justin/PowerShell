<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.163
	 Created on:   	05/22/2019 9:52 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>


$AdminCredentials = Get-Credential -Message "Credential are required for access the Domain Controller, File server and Exchange server"

#Requires -RunAsAdministrator


$versionMinimum = [Version]'5.1'

if ($versionMinimum -gt $PSVersionTable.PSVersion)
{ throw "This script requires PowerShell $versionMinimum" }
#Requires -Version 5.1
"Requires version $versionMinimum"
"Running PowerShell $($PSVersionTable.PSVersion)."

Write-Verbose "Importing Scripts"
Write-Debug "Going to import *.PS1 from \\canagroup.cana-group\business\IT Storage\Scripts\CANA-Justin\PowerShell\Modules\CANANewUser\Templates\"
$ImportTemplateModules = Get-ChildItem -Path "\\canagroup.cana-group\business\IT Storage\Scripts\CANA-Justin\PowerShell\Modules\CANANewUser\Templates\*.ps1" -Recurse -Force -exclude "*.TempPoint.ps1"
Write-Debug "Going to import *.PS1 from \\canagroup.cana-group\business\IT Storage\Scripts\CANA-Justin\PowerShell\Modules\CANANewUser"
$ImportTemplateModules += Get-ChildItem -Path "\\canagroup.cana-group\business\IT Storage\Scripts\CANA-Justin\PowerShell\Modules\CANANewUser\CreateUser.ps1" -Force #-exclude "*.ps1"
foreach ($TemplateModule in $ImportTemplateModules)
{
	Write-Debug "Importing $TemplateModule"
	Import-Module $TemplateModule
}
Import-Module $ImportTemplateModules
Write-Verbose "Done Importing Scripts"
Write-Debug "Done Importing Scripts"

$scriptPath = "\\canagroup.cana-group\business\IT Storage\Scripts\CANA-Justin\PowerShell\Modules\CANANewUser\Templates\"
$scriptFilter = "*.ps1"
[System.Collections.ArrayList]$filesArray = (Get-ChildItem -Path $scriptPath -Filter $scriptFilter -Recurse | Select-String -Pattern "function") | %{ $_.Line.Substring(9) }
($filesArray | Where-Object { $_ -like "*group*" }) | ForEach-Object { $filesArray.Remove($_) }
Write-Debug "List of valid job functions"
$filesArray | ForEach-Object { $_ } | Write-Debug



Write-Debug "##### ##### ##### #####"
Write-Debug "Done Importing"
Write-Debug "##### ##### ##### #####"

################################
#Test Paramitors

$GivenName = "Dan"
$FirstName = "Justin"
$MiddleInitial = "R"
$SirName = "Van Holmes"
#$UserName = "vanholmesj"
$Department = "120-Information Technology"
$Title = "IT Technical Analyst"
$Manager = "georgek"
$CompanyGroup = "95-CANA Limited"
Set-Variable -Name "Role" -Value "Add-CommissioningSupervisor"

###############################
#Common Paramitors

$DomainController1 = "vcana-dc01"
$DomainController2 = "vcana-dc02"
$Exchange1 = "vCANAEXCH-01"
$Exchange2 = "vCANAEXCH-02"
$FileServer = "vCANAFile-01"
$BaseHomeFolderPath = '\\canagroup.cana-group\HomeDrive\Users'

###############################


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
		[parameter(Mandatory = $true)]
		[string]$FirstName = $args[0],
		[parameter(Mandatory = $true)]
		[string]$SirName = $args[1],
		[parameter(Mandatory = $false)]
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
		[string]$DomainController1 = $args[0],
		[parameter(Mandatory = $false)]
		[string]$DomainController2 = $args[0]
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
	
	Return $RemoteDC
	
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

function New-ADUserCreation
{
	
	param (
		[Parameter(Mandatory, ValueFromPipelineByPropertyname)]
		[ValidateNotNullOrEmpty()]
		[string]$FirstName,
		[Parameter(Mandatory, ValueFromPipelineByPropertyname)]
		[ValidateNotNullOrEmpty()]
		[string]$LastName,
		[Parameter(Mandatory, ValueFromPipelineByPropertyname)]
		[ValidateNotNullOrEmpty()]
		[string]$MiddleInitial,
		[Parameter(Mandatory, ValueFromPipelineByPropertyname)]
		[ValidateNotNullOrEmpty()]
		[string]$Username,
		[Parameter(Mandatory, ValueFromPipelineByPropertyname)]
		[ValidateNotNullOrEmpty()]
		[string]$CompanyGroup,
		[Parameter(Mandatory, ValueFromPipelineByPropertyname)]
		[ValidateNotNullOrEmpty()]
		[string]$Department,
		[Parameter(Mandatory, ValueFromPipelineByPropertyname)]
		[ValidateNotNullOrEmpty()]
		[string]$Manager,
		[Parameter(Mandatory, ValueFromPipelineByPropertyname)]
		[ValidateNotNullOrEmpty()]
		[string]$Title,
		[Parameter(ValueFromPipelineByPropertyname)]
		[ValidateNotNullOrEmpty()]
		[string]$Location = 'OU=Energy,OU=CANA Group Users',
		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$DefaultGroup = 'XYZCompany',
		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$DefaultPassword = 'Welcome2cana' #,
		#[Parameter()]
		#[ValidateScript({ Test-Path -Path $_ })]
		#[string]$BaseHomeFolderPath = '\\canagroup.cana-group\HomeDrive\Users'
	)
	
	Write-Debug "First name is $($FirstName)"
	Write-Debug "Sirname is $($LastName)"
	Write-Debug "Middle initial is $($MiddleInitial)"
	Write-Debug "Department is $($Department)"
	Write-Debug "Title is $($Title)"
	Write-Debug "Manager is $($Manager)"
	
	## Find the distinguished name of the domain the current computer is a part of.
	$DomainDn = (Get-AdDomain).DistinguishedName
	
	#region Ensure the OU the user's going into exists
	$ouDN = "$Location,$DomainDn"
	if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$ouDN'"))
	{
		throw "The user OU [$($ouDN)] does not exist. Can't add a user there"
	}
	#endregion
	
	#region Ensure the group the user's going into exists
	#if (-not (Get-ADGroup -Filter "Name -eq '$DefaultGroup'"))
	#{
	#	throw "The group [$($DefaultGroup)] does not exist. Can't add the user into this group."
	#}
	#if (-not (Get-ADGroup -Filter "Name -eq '$Department'"))
	#{
	#	throw "The group [$($Department)] does not exist. Can't add the user to this group."
	#}
	
	#region Ensure the home folder to create doesn't already exist
	#$homeFolderPath = "$BaseHomeFolderPath\$UserName"
	#if (Test-Path -Path $homeFolderPath)
	#{
	#	throw "The home folder path [$homeFolderPath] already exists."
	#}
	#endregion
	
	#region Create the new user
	$NewUserParams = @{
		'UserPrincipalName' = "$Username@canagroup.cana-group"
		'Name'			    = $Username
		'GivenName'		    = $FirstName
		'Surname'		    = $LastName
		'DisplayName'	    = "$FirstName $LastName"
		'Title'			    = $Title
		'Description'	    = $Title
		'Department'	    = $Department
		'Company'		    = $CompanyGroup
		'Manager'		    = $Manager
		'ScriptPath'	    = "logon.vbs"
		'HomeDrive'		    = "H:"
		'HomeDirectory'	    = "$homeFolderPath\My Documents"
		#'EmployeeID'		= $EmployeeID
		'SamAccountName'    = $Username
		'AccountPassword'   = (ConvertTo-SecureString $DefaultPassword -AsPlainText -Force)
		'Enabled'		    = $true
		'Initials'		    = $MiddleInitial
		'Path'			    = "$Location,$DomainDn"
		'ChangePasswordAtLogon' = $false
	}
	Write-Verbose -Message "Creating the new user account [$($Username)] in OU [$($ouDN)]"
	New-AdUser @NewUserParams
	#endregion
	
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
		[string]$BaseHomeFolderPath
	)
	
	Invoke-Command -Computername $FileServer -Credential $AdminCredentials -ScriptBlock {
		param
		(
		$RUserName,$RBaseHomeFolderPath
		)
		
		#region Ensure the home folder to create doesn't already exist
		$RhomeFolderPath = "$RBaseHomeFolderPath\$RUserName"
		if (Test-Path -Path $homeFolderPath)
		{
			throw "The home folder path [$RhomeFolderPath] already exists."
		}
		Write-debug "Making Home Folder$RhomeFolderPath"
		MKDir $RhomeFolderPath
		
		Write-debug "Disable inheritance and Remove Permission on $RhomeFolderPath"
		ICACLS $RhomeFolderPath /inheritance:r
		# setup basic permissions for all folders.
		
		ICACLS $RhomeFolderPath /T /Grant "administrator:(CI)(OI)(F)"
		
		MKDir $RhomeFolderPath\"My Documents"
		MKDir $RhomeFolderPath\"My Documents\Scans"
		
		ICACLS $RhomeFolderPath /T /Grant "Ricoh:(CI)(OI)(RX)"
		ICACLS $RhomeFolderPath /T /Grant "svcHTIscan:(CI)(OI)(RX)"
		ICACLS $RhomeFolderPath /T /Grant "Domain Admins:(CI)(OI)(F)"
		ICACLS $RhomeFolderPath\"My Documents\Scans" /T /Grant "Ricoh:(CI)(OI)(RX,W,D)"
	} -ArgumentList $UserName, $BaseHomeFolderPath
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
		[string]$BaseHomeFolderPath
	)
	Invoke-Command -Computername $FileServer -Credential $AdminCredentials -ScriptBlock {
		param
		(
			$RUserName,
			$RBaseHomeFolderPath
		)
		ICACLS $homeFolderPath /T /Grant ${$UserName}":(CI)(OI)(F)"
		
	} -ArgumentList $UserName, $BaseHomeFolderPath
	
}

function Add-Role
{
	[CmdletBinding(PositionalBinding = $true)]
	param
	(
		[Parameter(
			Mandatory = $true,
			Position = 0)]
		[ValidateNotNullOrEmpty()]
		[string]$UserName,
		[Parameter(
			Mandatory = $true,
			 Position = 1)]
		[ValidateNotNullOrEmpty()]
		[string]$Role
	)
	
	Write-Debug "Running $Role"
	invoke-expression $Role $UserName
	Write-Debug "End $Role"
}

Write-Debug "Call New-MakeUsername"
Write-Verbose "Making username"
$UserName = New-MakeUsername $FirstName $SirName
Write-Debug "End MakeUsername"

Write-Debug "Call Check-ValidateUserName"
Write-Verbose "Validating username"
$UserName = Search-ValidateUserName $UserName
Write-Debug "End Check-ValidateUserName"

Write-Debug "Call Enter-DomainController"
Write-Verbose "Checking Domain Controllers"
$RemoteDC = Connect-DomainController $DomainController1 $DomainController2
Write-Debug "End Enter-DomainController"

Write-Debug "Calling NewPSSession"
Write-Verbose "Making connection to Domain Controller"
$RemoteSession = New-PSSession -ComputerName $RemoteDC -Credential $AdminCredentials

Write-Debug "Call Submit-UserName"
Write-Verbose "Connecting to Domain Controller to make sure User does not exist"
Submit-UserName $UserName $RemoteSession
Write-Debug "End Check-UserName"

Write-Debug "Call New-HomeFolder"
Write-Verbose "Creating the home folders for the User (part 1)"
New-HomeFolder $UserName
Write-Debug "End New-HomeFolder"

Write-Debug "Call New-ADUserCreation"
Write-Verbose "Creating the user on the Domain Controller"
New-ADUserCreation $FirstName $SirName $MiddleInitial $UserName $CompanyGroup $Department $Manager $Title
Write-Debug "End New-ADUserCreation"

Write-Debug "Call New-HomeFolder2"
Write-Verbose "Creating and assigning permissions to the home folder for the user now that they exist (pert 2)"
New-HomeFolder2 $UserName
Write-Debug "End New-HomeFolder2"

Write-Debug "Call Add-Role"
Write-Verbose "Adding the user to the assigned groups in the role"
Add-Role $UserName $Role
Write-Debug "End Add-Role"

#$RemoteEXCH = Connect-Exchange $AdminCredentials $Exchange1 $Exchange2

#New-UserMailbox $UserName $RemoteEXCH

Write-Host "Hello World"

