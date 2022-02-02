
<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.167
	 Created on:   	10/18/2019 8:44 AM
	 Created by:   	Justin Holmes
	 Organization: 	
	 Filename:     	Energy-Wrapper-ArchiveProposalProject.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

."\\canagroup.cana-group\business\IT Storage\Scripts\CANA-Justin\PowerShell\IsMember.ps1"
<#
	.SYNOPSIS
		Bypass check for group membership.
	
	.DESCRIPTION
		Bypass check for group membership. Useful if you want to run the scrip as the logged on user to create the actual file scructure (ie. ADM account)
	
	.EXAMPLE
				PS C:\> Switch-NoElevate
	
	.OUTPUTS
		Switch
	
	.NOTES
		Additional information about the function.
#>
function Switch-NoElevate
{
	[CmdletBinding()]
	[OutputType([Switch], ParameterSetName = 'NoElevate')]
	[OutputType([switch])]
	param ()
	
	switch ($PsCmdlet.ParameterSetName)
	{
		'NoElevate' {
			#TODO: Place script here
			break
		}
	}
	
}

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
	
	Write-Verbose "Creating cerdentials for folder creation."
	Write-Debug "Start- Creating cerdentials for folder creation."
	Write-Debug "Set User to CANAGROUP\SVCEnergyMFA"
	$User = "CANAGROUP\SVCEnergyMFA"
	Write-Debug "Getting password hash from file"
	$PasswordFile = "\\canagroup.cana-group\SYSVOL\canagroup.cana-group\scripts\Powershell\Energy\SVCEnergyMFA.txt" #This file **NEEDS** to be secured by NTFS permissions.  This is the hashed password for the service account.
	Write-Debug "Setting password key"
	[Byte[]]$key = (61, 237, 132, 192, 170, 160, 199, 228, 107, 205, 55, 149, 146, 29, 166, 175, 174, 206, 88, 189, 180, 133, 1, 112, 253, 14, 177, 72, 129, 211, 55, 176) #This is the AES key used to encrypt/decrypt the hashed password.
	Write-Debug "Building credentials"
	$credentials = New-Object -TypeName System.Management.Automation.PSCredential `
							  -ArgumentList $User, (Get-Content $PasswordFile | ConvertTo-SecureString -Key $key)
	$arguments = ".'\\canagroup.cana-group\SYSVOL\canagroup.cana-group\scripts\Powershell\Energy\Energy-ArchiveProject.ps1'"
	
	Write-Verbose "Using cerdentials for new powershell session with access."
	Write-Debug "Using cerdentials for new powershell session with access"
	Start-Process C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Credential $credentials -ArgumentList $arguments
	
	stop-process -Id $PID
}


Confirm-Authorized





# SIG # Begin signature block
# MIIcugYJKoZIhvcNAQcCoIIcqzCCHKcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAp1MR4ldegPrB2
# lAsWgi+crIcXfjQh0hZ2nmuGauR+R6CCF2owggOwMIICmKADAgECAhBz0HdolQdJ
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
# IOM28LZQuTCCBEwwggM0oAMCAQICExMAAAAGLUYVgdAHJfgAAAAAAAYwDQYJKoZI
# hvcNAQEFBQAwGDEWMBQGA1UEAxMNVkNBTkFDQS0wMS1DQTAeFw0xNDA2MDYxOTEy
# MjJaFw0yNDA2MDYxOTIyMjJaMFkxGjAYBgoJkiaJk/IsZAEZFgpjYW5hLWdyb3Vw
# MRkwFwYKCZImiZPyLGQBGRYJY2FuYWdyb3VwMSAwHgYDVQQDExdjYW5hZ3JvdXAt
# VkNBTkFDQS0wMi1DQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALYA
# ghcYHT1OPm+SA2FEWnnNNBltH4ixxES3za6BUIg9buOh4+NyUShKNwsWZtrL1SjA
# //SSMtyIqhwOSyz6Nfl3MaEd9BzSME5TkPLey+EBHsDUEjhjhSLOS2HX/eRu10WA
# TUB7QfJZgf/3K9C8GNSxe9KeIUvs2liP5UfOrj60mseXyzKOAEXGT74IN58Czr3P
# QZfuRf1Vm6JH1DW1Mpbdvi5ZGr4F0MLEhMQ01VxLPFKSlp4Kmt6MyPtkub9OJISv
# U3JDqxVisI7KKs87RW1wT/Og/TEcQWOsbUJm/SwjDIfvZlv5AiNGL91X05aXqFar
# IEma2pPp2QwdU85YCZsCAwEAAaOCAUwwggFIMBAGCSsGAQQBgjcVAQQDAgECMCMG
# CSsGAQQBgjcVAgQWBBRyijiHXgfL88D1K7XaFeWY6OQiqDAdBgNVHQ4EFgQU05cx
# Xe0i3fcSHG3Pg6X7qM5MzscwGQYJKwYBBAGCNxQCBAweCgBTAHUAYgBDAEEwCwYD
# VR0PBAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0jBBgwFoAUX98Zsdd22Rfw
# d96dNOgO2KG2SjAwPwYDVR0fBDgwNjA0oDKgMIYuaHR0cDovL3ZjYW5hY2EtMDIv
# Q2VydEVucm9sbC9WQ0FOQUNBLTAxLUNBLmNybDBVBggrBgEFBQcBAQRJMEcwRQYI
# KwYBBQUHMAKGOWh0dHA6Ly92Y2FuYWNhLTAyL0NlcnRFbnJvbGwvVkNBTkFDQS0w
# MV9WQ0FOQUNBLTAxLUNBLmNydDANBgkqhkiG9w0BAQUFAAOCAQEAHV8j8+9DW2T5
# VsORwO2dJyRlp3ae0YYEkKKdgEB0IClWqOoUd0pGVXLlNWUEfTr3mbigzeNmtMWs
# 7SsqlGuWech929GJJvHCJpx/gIWROF0fE5WPS6+F400krI9DNToB8GBNkc/SBLGU
# cq8YlsqTvOp969MrhzaD0Ga7qUpLlIG7OJU59da5ckkvbq/05z2OZ/IO/3O6u9ju
# Av82INd8z/WxZ5daEOOqH0DopDKEwg0jKzIaomqXi6JRO9EYsT1hEJazgVSzK1Zb
# e0SatL73Z2ORoVL+fBUL0UPrFp2N4oBDmXK3YRO0b/czZE6vhPL0LcJcvmYEylcN
# xYiXQuNheDCCBMYwggOuoAMCAQICDCRUuH8eFFOtN/qheDANBgkqhkiG9w0BAQsF
# ADBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8G
# A1UEAxMoR2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0EgLSBTSEEyNTYgLSBHMjAe
# Fw0xODAyMTkwMDAwMDBaFw0yOTAzMTgxMDAwMDBaMDsxOTA3BgNVBAMMMEdsb2Jh
# bFNpZ24gVFNBIGZvciBNUyBBdXRoZW50aWNvZGUgYWR2YW5jZWQgLSBHMjCCASIw
# DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANl4YaGWrhL/o/8n9kRge2pWLWfj
# X58xkipI7fkFhA5tTiJWytiZl45pyp97DwjIKito0ShhK5/kJu66uPew7F5qG+JY
# tbS9HQntzeg91Gb/viIibTYmzxF4l+lVACjD6TdOvRnlF4RIshwhrexz0vOop+lf
# 6DXOhROnIpusgun+8V/EElqx9wxA5tKg4E1o0O0MDBAdjwVfZFX5uyhHBgzYBj83
# wyY2JYx7DyeIXDgxpQH2XmTeg8AUXODn0l7MjeojgBkqs2IuYMeqZ9azQO5Sf1YM
# 79kF15UgXYUVQM9ekZVRnkYaF5G+wcAHdbJL9za6xVRsX4ob+w0oYciJ8BUCAwEA
# AaOCAagwggGkMA4GA1UdDwEB/wQEAwIHgDBMBgNVHSAERTBDMEEGCSsGAQQBoDIB
# HjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBv
# c2l0b3J5LzAJBgNVHRMEAjAAMBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMEYGA1Ud
# HwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3MvZ3N0aW1l
# c3RhbXBpbmdzaGEyZzIuY3JsMIGYBggrBgEFBQcBAQSBizCBiDBIBggrBgEFBQcw
# AoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3N0aW1lc3Rh
# bXBpbmdzaGEyZzIuY3J0MDwGCCsGAQUFBzABhjBodHRwOi8vb2NzcDIuZ2xvYmFs
# c2lnbi5jb20vZ3N0aW1lc3RhbXBpbmdzaGEyZzIwHQYDVR0OBBYEFNSHuI3m5UA8
# nVoGY8ZFhNnduxzDMB8GA1UdIwQYMBaAFJIhp0qVXWSwm7Qe5gA3R+adQStMMA0G
# CSqGSIb3DQEBCwUAA4IBAQAkclClDLxACabB9NWCak5BX87HiDnT5Hz5Imw4eLj0
# uvdr4STrnXzNSKyL7LV2TI/cgmkIlue64We28Ka/GAhC4evNGVg5pRFhI9YZ1wDp
# u9L5X0H7BD7+iiBgDNFPI1oZGhjv2Mbe1l9UoXqT4bZ3hcD7sUbECa4vU/uVnI4m
# 4krkxOY8Ne+6xtm5xc3NB5tjuz0PYbxVfCMQtYyKo9JoRbFAuqDdPBsVQLhJeG/l
# lMBtVks89hIq1IXzSBMF4bswRQpBt3ySbr5OkmCCyltk5lXT0gfenV+boQHtm/DD
# XbsZ8BgMmqAc6WoICz3pZpendR4PvyjXCSMN4hb6uvM0MIIGfzCCBWegAwIBAgIT
# TgAACemaeFnpVfhH6wACAAAJ6TANBgkqhkiG9w0BAQUFADBZMRowGAYKCZImiZPy
# LGQBGRYKY2FuYS1ncm91cDEZMBcGCgmSJomT8ixkARkWCWNhbmFncm91cDEgMB4G
# A1UEAxMXY2FuYWdyb3VwLVZDQU5BQ0EtMDItQ0EwHhcNMTkxMjEzMTkyNDUwWhcN
# MjAxMjEyMTkyNDUwWjCBlDEaMBgGCgmSJomT8ixkARkWCmNhbmEtZ3JvdXAxGTAX
# BgoJkiaJk/IsZAEZFgljYW5hZ3JvdXAxGTAXBgNVBAsTEENBTkEgR3JvdXAgVXNl
# cnMxGzAZBgNVBAsTEkNBTkEgTGltaXRlZCBVc2VyczELMAkGA1UECxMCSVQxFjAU
# BgNVBAMTDUp1c3RpbiBIb2xtZXMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
# AoIBAQC0mIgJG9Gv/ysSfBFQa2s/cwibayyjOZFsir8Bo+vnDTstLdw1tQGb/k4s
# 5RiwMuS05YKU1pyBOOfsFT3nLhLWgm4oA90pUT3SZ33UP6tsI9xthCYHWsc6rK1G
# MUJqOk1t+OgBTNW6iHVD+BOIoSh5dz9t43YxaVlfDj7ZVw4mFGOGnQL2rUrpaZuJ
# PikEGbPbZOvPR45o8eUK5avuf+S7lOLEcKOIbpY72RlQJw9KPC8Lk3TtlFDPf6yJ
# JPGsqOf5XQqRBFey264Hv7R/Pnzs3Ak97szx0VG7TEGQLk8CXEQRDIafNJNDnkti
# yw9C4lDfAMvFfHAjL/HvWLrgfdjlAgMBAAGjggMCMIIC/jALBgNVHQ8EBAMCB4Aw
# PQYJKwYBBAGCNxUHBDAwLgYmKwYBBAGCNxUIgpSHfILYwxuC3Y8nhLzjEIeB3VeB
# VYT1wxW741wCAWQCAQUwHQYDVR0OBBYEFHFb4fr3kmup4gtFxFYrlYWIVEPhMB8G
# A1UdIwQYMBaAFNOXMV3tIt33Ehxtz4Ol+6jOTM7HMIIBNQYDVR0fBIIBLDCCASgw
# ggEkoIIBIKCCARyGgcpsZGFwOi8vL0NOPWNhbmFncm91cC1WQ0FOQUNBLTAyLUNB
# LENOPXZDQU5BQ0EtMDIsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2Vz
# LENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9Y2FuYWdyb3VwLERDPWNh
# bmEtZ3JvdXA/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENs
# YXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hk1odHRwOi8vdkNBTkFDQS0wMi5jYW5h
# Z3JvdXAuY2FuYS1ncm91cC9DZXJ0RW5yb2xsL2NhbmFncm91cC1WQ0FOQUNBLTAy
# LUNBLmNybDCB0gYIKwYBBQUHAQEEgcUwgcIwgb8GCCsGAQUFBzAChoGybGRhcDov
# Ly9DTj1jYW5hZ3JvdXAtVkNBTkFDQS0wMi1DQSxDTj1BSUEsQ049UHVibGljJTIw
# S2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1j
# YW5hZ3JvdXAsREM9Y2FuYS1ncm91cD9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0
# Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTATBgNVHSUEDDAKBggrBgEFBQcD
# AzAbBgkrBgEEAYI3FQoEDjAMMAoGCCsGAQUFBwMDMDAGA1UdEQQpMCegJQYKKwYB
# BAGCNxQCA6AXDBVKdXN0aW4uSG9sbWVzQGNhbmEuY2EwDQYJKoZIhvcNAQEFBQAD
# ggEBAGuwWHTsjcqHpRgvlqcNAhv3+/jrd8F6yzMypiLbG46yWNsWOx7/V7xMgWw7
# 9zbq5hRH/jG7akcLirXa4L0gWfpsslW3CQRKJlGrV1y/zeD8Bs1kUcrEp167nHDb
# nGfMaEDOOK6tErektLNB33rJNQ+QEY8d2AP+Q4BrlGgrdH6knQf2Mf3vT01wYoz8
# akTrZa0NNS/ZF2hfX8uNxFjKhEb3WR8DCrhT6cvJK7BG83RWkwEQRkEEr03zISh3
# XXaJv3MXMPdWufIr/w/CmUI96J2Q+hvi06GaczfsiVFpqdjTJ3O+8uUQuA7Kg7wt
# ba0DL/zG7sp3xaRrZ1Nh8ea9iooxggSmMIIEogIBATBwMFkxGjAYBgoJkiaJk/Is
# ZAEZFgpjYW5hLWdyb3VwMRkwFwYKCZImiZPyLGQBGRYJY2FuYWdyb3VwMSAwHgYD
# VQQDExdjYW5hZ3JvdXAtVkNBTkFDQS0wMi1DQQITTgAACemaeFnpVfhH6wACAAAJ
# 6TANBglghkgBZQMEAgEFAKBMMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMC8G
# CSqGSIb3DQEJBDEiBCBo9gg20ZThuEb2JzcXRs/vSmz1Uyd8vucQKZNyIAj3cjAN
# BgkqhkiG9w0BAQEFAASCAQAHoJ0tGVgdv2sUyvPEKrod7yp4DsjuLT/Icqq/x7mR
# GmEaM/sjy1U+cbgYUlGmiAXRT8evrUO5kccEzOmvjRFMLoCyie4Lpb5W2elzq4Yx
# b7uuRYYLe5gDqp7gsZv9A7bCvIT23vA8nmsfPHQ0/ROmBLEHwltp7ZVge32TPKYT
# qOQR6psMxmIhM3ZAt43na7OJoyWTIDV8XpixFlCHExTvhy+uk3SucPh0nwW6Fhd/
# Kh9ZF0PJ+4VYtMlJMJlJk8brwwDIGI3pT0CF2BnJCaMK/vQF4Px3yyrkfwKphcfS
# UL0ii83X6SxP8+/B1ItaJ8M1EDP/N9457rVPTQZLzHSwoYICuTCCArUGCSqGSIb3
# DQEJBjGCAqYwggKiAgEBMGswWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2Jh
# bFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gVGltZXN0YW1waW5nIENB
# IC0gU0hBMjU2IC0gRzICDCRUuH8eFFOtN/qheDANBglghkgBZQMEAgEFAKCCAQww
# GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjAwNDIy
# MTgzMjU5WjAvBgkqhkiG9w0BCQQxIgQgZSHlUBSRWiepSQL7geE+vfyfArgK/WR7
# ssN+tOZgnE4wgaAGCyqGSIb3DQEJEAIMMYGQMIGNMIGKMIGHBBQ+x2bV1NRy4hsf
# IUNSHDG3kNlLaDBvMF+kXTBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFs
# U2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0Eg
# LSBTSEEyNTYgLSBHMgIMJFS4fx4UU603+qF4MA0GCSqGSIb3DQEBAQUABIIBAHQl
# ebBJZzskDhcKbL7H2rSY50Ouy4R5o8A7y3xpiboaCMLHfb8TXhFc2Jvh1YjYisi7
# HzJn3b0iF38CqhiqEMsAz4BppovQ+eYQ2ZvEQItucxMJXnzkRFpaizURlXpS0zx+
# bsOhoZrvd29eAUEVt3JaihaKbFlEZZPlUlZZAFdaQBCufPtqLncsB8avoMO20XKp
# FIcRG7b28rwJ3z03TFokFB1+qSRX11DtcsoCLV94O1cGp7XZVc2n9AsOa2Hrr9XO
# VdYHI9g+PpLiRexUDPi8lpxoi2SUrpf7AXi/1L0LwHnMWCEV1hfoPD0u96/HqHVu
# Phxp/yvPzBD/brnkRWA=
# SIG # End signature block
