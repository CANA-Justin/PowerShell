<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2021 v5.8.183
	 Created on:   	01/25/2021 9:15 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	FTP-UploadToTarrahub.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

#Checking for PowerShell version
function CheckPSVersion(
	[string][Parameter(Mandatory = $true)]$DesiredPS
	)
{
	$ps_version = "{0}.{1}" -f $PSVersionTable.PSVersion.major, $PSVersionTable.PSVersion.minor
	
	if ($ps_version -lt $DesiredPS)
	{
		
		Write-Verbose "PowerShell version $ps_version found"
		Write-Verbose "PowerShell version needs to be"
		
		
		Write-Host -ForegroundColor Yellow "WARNING!"
		Write-Host -ForegroundColor Yellow "########################################################################"
		Write-Host -ForegroundColor Yellow -NoNewline "# "
		Write-Host "You are using Powershell " -NoNewline
		Write-Host -ForegroundColor Red "$ps_version"
		Write-Host -ForegroundColor Yellow -NoNewline "# "
		Write-Host "This script needs version $DesiredPS or better."
		Write-Host -ForegroundColor Yellow -NoNewline "# "
		Write-Host "Please install a more up to date version of PowerShell on this host."
		Write-Host -ForegroundColor Yellow "########################################################################"
		Write-Host ""
		Write-Host ""
		Write-Host "The script will now exit"
		Pause
		Exit
	}
	elseif ($ps_version -ge $DesiredPS)
	{
		Write-Verbose "PowerShell version $ps_version found"
		#Write-Host "PowerShell version $ps_version found"
	}
}

#Checking for PSFTP module
function CheckModule(
	[string][Parameter(Mandatory = $true)]$moduleName
)
{
	if (Get-Module -ListAvailable -Name $moduleName)
	{
		Write-Verbose "Module $moduleName exists"
		#Write-Host "Module $moduleName exists"
	}
	else
	{
		Write-Host "Module $moduleName does not exist"
		Write-Host "Would you like to install $moduleName ?"
		$title = "Install $moduleName"
		$question = "Would you like to install $moduleName"
		$choices = '&Yes', '&No'
		
		$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
		if ($decision -eq 0)
		{
			Write-Host -ForegroundColor Yellow "Starting to install $moduleName"
			Install-ModuleIfNotInstalled $moduleName
		}
		else
		{
			Write-Host -ForegroundColor Red "You declined to install $moduleName"
			Write-Host "script will now exit"
			Pause
			Exit
		}
		
	}
}

#Will install PSFTP if it is not found, and the user accepts the install
Function Install-ModuleIfNotInstalled(
	[string][Parameter(Mandatory = $true)]$moduleName,
	[string]$minimalVersion
)
{
	#Need to check the PowerShell version.
	#PowerShell version 5.0 and newer will allow for download and install of modules
	
	CheckPSVersion 5
	
	$module = Get-Module -Name $moduleName -ListAvailable |`
	Where-Object { $null -eq $minimalVersion -or $minimalVersion -ge $_.Version } |`
	Select-Object -Last 1
	if ($null -ne $module)
	{
		Write-Verbose ('Module {0} (v{1}) is available.' -f $moduleName, $module.Version)
	}
	else
	{
		Import-Module -Name 'PowershellGet'
		$installedModule = Get-InstalledModule -Name $moduleName -ErrorAction SilentlyContinue
		if ($null -ne $installedModule)
		{
			Write-Verbose ('Module [{0}] (v {1}) is installed.' -f $moduleName, $installedModule.Version)
		}
		if ($null -eq $installedModule -or ($null -ne $minimalVersion -and $installedModule.Version -lt $minimalVersion))
		{
			Write-Verbose ('Module {0} min.vers {1}: not installed; check if nuget v2.8.5.201 or later is installed.' -f $moduleName, $minimalVersion)
			#First check if package provider NuGet is installed. Incase an older version is installed the required version is installed explicitly
			if ((Get-PackageProvider -Name NuGet -Force).Version -lt '2.8.5.201')
			{
				Write-Warning ('Module {0} min.vers {1}: Install nuget!' -f $moduleName, $minimalVersion)
				Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Scope CurrentUser -Force
			}
			$optionalArgs = New-Object -TypeName Hashtable
			if ($null -ne $minimalVersion)
			{
				$optionalArgs['RequiredVersion'] = $minimalVersion
			}
			Write-Warning ('Install module {0} (version [{1}]) within scope of the current user.' -f $moduleName, $minimalVersion)
			Install-Module -Name $moduleName @optionalArgs -Scope CurrentUser -Force -Verbose
		}
	}
}

#This function configures the necessary details for the script to connect to the FTP server 
function ConnectFTP ($FTPRemotePath, $FTPLocalFile)
{
	Import-Module -Name PSFTP
	$User = "PSFTPTEST"
	$Pass = "KZVX4669yhkg"
	$EncryptedPass = ConvertTo-SecureString -String $Pass -asPlainText -Force
	$Credentials = New-Object System.Management.Automation.PSCredential($User, $EncryptedPass)
	$Server = "ftp://ftp.cana.ca"
	
	#Connect to FTP site 
	#Store the connection output into a variable called $ResponseStatus 
	Set-FTPConnection -Credentials $Credentials -Server $Server -Session MySession -UsePassive
	
	#Evaluate the contents of $ResponseStatus using ConnectionStatus function 
#	if (ConnectionStatus $ResponseStatus -eq $True)
#	{
		#If the connection was successful, list the files in the given path 
		#Get-FTPChildItem -Session MySession -Path ftp://ftp.servername.com/ftproot/path/
		
		#If the connection was successful, move the file to FTP site
		Add-FTPItem -Session MySession -Path $FTPRemotePath -Overwrite -LocalPath $FTPLocalFile -Confirm:$False #| Out-Null
#	}
	
#	else
#	{
		#If the connection failed, write the below string to screen 
#		Write-Host "Connection to FTP server failed!"
#	}
}

#Program starts here
#To call the function now, you have to add parameters to the function call
CheckPSVersion 5.1
CheckModule PSFTP
ConnectFTP "" "C:\TerraHubExport\PowerShell-7.1.1-win-x64.msi"
