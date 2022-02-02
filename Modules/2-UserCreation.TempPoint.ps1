<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.163
	 Created on:   	06/04/2019 12:42 PM
	 Created by:   	admjustin
	 Organization: 	
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
$AdminCredentials = Get-Credential -Message "Credential are required"

$adminusername = $AdminCredentials.username
$adminpassword = $AdminCredentials.GetNetworkCredential().password

# Get current domain using logged-on user's credentials
$CurrentDomain = "LDAP://" + ([ADSI]"").distinguishedName
$domain = New-Object System.DirectoryServices.DirectoryEntry($CurrentDomain, $AdminUserName, $AdminPassword)

if ($domain.name -eq $null)
{
	write-host -ForegroundColor Red "Authentication failed - please verify your username and password."
	exit #terminate the script.
}
else
{
	Write-Debug "Successfully authenticated with domain $domain.name"
}

$FirstName = Read-Host "Paste the Users First Name"
$SirName = Read-Host "Paste the Users Last Name"
if (($result = Read-Host "Enter the DNS name for the Domain Controller | Or press enter to accept default value [vcana-dc01]") -eq '') { "vcana-dc01" }
else { $result }
$DomainController1 = $result
#$DomainController1 = Read-Host "Enter the DNS name for the Domain Controller"
$DefaultPassword = 'Welcome2cana2021'
$Location = 'OU=Energy,OU=CANA Group Users'
$BaseHomeFolderPath = '\\canagroup.cana-group\HomeDrive\Users'


	Write-Debug "Given name is $($GivenName)"
	Write-Debug "First name is $($FirstName)"
	Write-Debug "Last name is $($SirName)"
	Write-Debug "User name is $($UserName)"
	
	$UserName = $SirName + $FirstName.substring(0, 1)
	$UserName = $UserName.ToLower()
	
	Write-Debug "Username is now $($UserName)"
	Write-Verbose "Username is now $($UserName)"


	
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
	

	


	
	Write-debug "Testing $($DomainController1) for connectivity"
	$DC1 = test-connection -quiet -ComputerName $DomainController1
	Write-debug "Domain Controller $($DomainController1) availability is $($DC1)"
	Write-debug "Testing $($DomainController2) for connectivity"
	#$DC2 = test-connection -quiet -ComputerName $DomainController2
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


$homeFolderPath = "$BaseHomeFolderPath\$UserName"


Write-Verbose "Going to check $UserName on $RemoteDC for conflict"
Write-Debug "Going to check $UserName on $RemoteDC for conflict"
Write-Debug "Opening PSSession with $($RemoteDC)"


$session = New-PSSession -ComputerName $DomainController1 -Credential $AdminCredentials
Invoke-Command $session -Scriptblock { Import-Module ActiveDirectory }
Import-PSSession -Session $session -DisableNameChecking -module ActiveDirectory
	
	
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
		Exit
		
	}
	else
	{
		
		Write-Verbose "R$UserName is avalable"
		Write-Debug "$UserName is avalable"
		
	}
	
	
		Write-Debug "First name is $($FirstName)"
		Write-Debug "Sirname is $($SirName)"
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
			'UserPrincipalName' = "$FirstName.$SirName@cana.ca"
			'Name'			    = "$FirstName $SirName"
			'GivenName'		    = $FirstName
			'Surname'		    = $SirName
			'DisplayName'	    = "$FirstName $SirName"
			'HomeDrive'		    = "H:"
			'HomeDirectory'	    = "$homeFolderPath\My Documents"
			#'EmployeeID'		= $EmployeeID
			'SamAccountName'    = $UserName
			'AccountPassword'   = (ConvertTo-SecureString $DefaultPassword -AsPlainText -Force)
			'Enabled'		    = $true
			'Path'			    = "$ouDN"
			'ChangePasswordAtLogon' = $false
		}
		Write-Verbose -Message "Creating the new user account [$($UserName)] in OU [$($ouDN)]"
		New-AdUser @NewUserParams
		#endregion

Remove-PSSession $Session
	




# SIG # Begin signature block
# MIIbwAYJKoZIhvcNAQcCoIIbsTCCG60CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAvcuqNAEByVOhz
# +fXhzujwu+EixNWrpYCrDuw/zy0qFaCCFvEwggOwMIICmKADAgECAhBz0HdolQdJ
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
# hvcNAQkDMQwGCisGAQQBgjcCAQQwLwYJKoZIhvcNAQkEMSIEIPhklU52enx2Zz3k
# x1jjEer+P1wOpHjhIE4UjHckKF2WMA0GCSqGSIb3DQEBAQUABIGAXn5KFyYGD+8n
# /fS0Pt7Co5PLSVJiwDAn3ItYMeRTnJ5gtKIv6zCJ8ovAB2IIR1E0PTjItxIV4QfX
# mDQc1mGNX1YzyevpZPqrkpGmGp27GD+wzQZkZxRUGKkIsuRcCjbh6MSBewMwEgzu
# jrbDpWVSynSAOmcXIdk6wIYI5bsqhIehggK5MIICtQYJKoZIhvcNAQkGMYICpjCC
# AqICAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
# YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0EgLSBTSEEyNTYg
# LSBHMgIMJFS4fx4UU603+qF4MA0GCWCGSAFlAwQCAQUAoIIBDDAYBgkqhkiG9w0B
# CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTAyMDExOTE0NDFaMC8G
# CSqGSIb3DQEJBDEiBCB6/pjGDuBVrYgOICYrkjmKj6UVihVeQPuj8x343oWNtTCB
# oAYLKoZIhvcNAQkQAgwxgZAwgY0wgYowgYcEFD7HZtXU1HLiGx8hQ1IcMbeQ2Uto
# MG8wX6RdMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
# MTEwLwYDVQQDEyhHbG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAtIFNIQTI1NiAt
# IEcyAgwkVLh/HhRTrTf6oXgwDQYJKoZIhvcNAQEBBQAEggEAIKmy4Nmh0Y40azDV
# CkN3ZfojazvR/UGYQqyoptziFKHSHQreAOlJlChcSNLFlkJWSGuDXtuxcMXg9lLy
# kKN9ay9LcH2hU2Ms3ixAgFQoZqVh6wW6z4iJHh+sLOrEQV/pNH491tHv+2jgsBmo
# HPtK+Xiw23zxA/JRvVItn99otPbznEXN+2fQSKjLAzEDpqE0U+heRQ3BoHXe5B5N
# RdVnEP9aFKvfZoH3+40Er57VczZ4bMSiVNq4/rgN3P7dVwLCIicpQyQe3g/d4Lhe
# Xo/Ii659BhcYDtoksye+RT8fW4BvpGoXzREHOFkr+NG3gsi6BeJRmoWrJGmBy+rg
# B2Gxcg==
# SIG # End signature block
