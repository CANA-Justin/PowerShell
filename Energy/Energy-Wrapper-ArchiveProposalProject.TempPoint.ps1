﻿
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
	$arguments = ".'\\canagroup.cana-group\SYSVOL\canagroup.cana-group\scripts\Powershell\Energy\Energy-ArchiveProposalProject.ps1'"
	
	Write-Verbose "Using cerdentials for new powershell session with access."
	Write-Debug "Using cerdentials for new powershell session with access"
	Start-Process C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Credential $credentials -ArgumentList $arguments
}


Confirm-Authorized





# SIG # Begin signature block
# MIIcFQYJKoZIhvcNAQcCoIIcBjCCHAICAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAstk07f8El9zQ5
# BfbKoyQohpWPWzt/pVyVyQ+Deb6FwaCCFsUwggMLMIIB86ADAgECAhAdBzYmM16G
# g06JYzHUiBhJMA0GCSqGSIb3DQEBBQUAMBgxFjAUBgNVBAMTDVZDQU5BQ0EtMDEt
# Q0EwHhcNMTQwNjA1MjAzNTU3WhcNMzkwNjA1MjA0NTU3WjAYMRYwFAYDVQQDEw1W
# Q0FOQUNBLTAxLUNBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAl8bY
# qRoITo9oA5hAh6NMfF80ur408wGvPSaMCNW7lpsRdtvtkkrahACkEsgwSd+9lR7D
# f9gvXrrTFNS6dmYia0KrwlEWNCWVi3IZMB4LEW+dg75O2Dv5zyAWyI41S8mAXr1a
# uexdiQrQ1sXsK/bOgfSsa6QMuoEz5ygBgsASpDnJrkAfytpb9FusJItqOse9twcR
# hx8TUxAcMXFknRqTTIGVsI5EiW+Hz9IE7wlSKI64OWGgbA5CBPS9nQrNX03tjNvK
# X9fYnGc/M5AGQzX77lZEe+JFKP9xiagyp/U6NXzHkNGP3MI4HhcCKa22/WiKU8J3
# jBcMxXdYakAHohKrJwIDAQABo1EwTzALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUw
# AwEB/zAdBgNVHQ4EFgQUX98Zsdd22Rfwd96dNOgO2KG2SjAwEAYJKwYBBAGCNxUB
# BAMCAQAwDQYJKoZIhvcNAQEFBQADggEBAHFJx/l0oL0KlISxzlj4cgxzuTEmEfAC
# UZWDA18gEjWkGcmAIaO/5scnwIbHQhI7R7b3geyOQ+5UmvSuWZ+cyXpWUjpzqUbb
# XnGp0Jh1rEsS2IlXO1PN3dzZGfYlYjzCgsv14v4VRXaAy8ZjccC6/Hjz+F0l2Fwk
# ah6P8U1y2ieFJedEPhJG6Fo47B673b6aBnnyHBfQXzc0SvZ7ASQG+reBBq75hJ2q
# YeJ39Vgjr27qT8gfaaY2Ei5TDHO/tgnkrnZc+C1OGVyLpPljhtoItSRTACngxm2n
# TWpE1d4P9WQrzM6YrmnCWSz+a1qEYdU0EDCLgioHlcKNGjSh/UwBGsUwggQVMIIC
# /aADAgECAgsEAAAAAAExicZQBDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQLExdH
# bG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEG
# A1UEAxMKR2xvYmFsU2lnbjAeFw0xMTA4MDIxMDAwMDBaFw0yOTAzMjkxMDAwMDBa
# MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
# VQQDEyhHbG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAtIFNIQTI1NiAtIEcyMIIB
# IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqpuOw6sRUSUBtpaU4k/YwQj2
# RiPZRcWVl1urGr/SbFfJMwYfoA/GPH5TSHq/nYeer+7DjEfhQuzj46FKbAwXxKbB
# uc1b8R5EiY7+C94hWBPuTcjFZwscsrPxNHaRossHbTfFoEcmAhWkkJGpeZ7X61ed
# K3wi2BTX8QceeCI2a3d5r6/5f45O4bUIMf3q7UtxYowj8QM5j0R5tnYDV56tLwhG
# 3NKMvPSOdM7IaGlRdhGLD10kWxlUPSbMQI2CJxtZIH1Z9pOAjvgqOP1roEBlH1d2
# zFuOBE8sqNuEUBNPxtyLufjdaUyI65x7MCb8eli7WbwUcpKBV7d2ydiACoBuCQID
# AQABo4HoMIHlMA4GA1UdDwEB/wQEAwIBBjASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
# A1UdDgQWBBSSIadKlV1ksJu0HuYAN0fmnUErTDBHBgNVHSAEQDA+MDwGBFUdIAAw
# NDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
# dG9yeS8wNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLm5l
# dC9yb290LXIzLmNybDAfBgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDAN
# BgkqhkiG9w0BAQsFAAOCAQEABFaCSnzQzsm/NmbRvjWek2yX6AbOMRhZ+WxBX4Au
# wEIluBjH/NSxN8RooM8oagN0S2OXhXdhO9cv4/W9M6KSfREfnops7yyw9GKNNnPR
# FjbxvF7stICYePzSdnno4SGU4B/EouGqZ9uznHPlQCLPOc7b5neVp7uyy/YZhp2f
# yNSYBbJxb051rvE9ZGo7Xk5GpipdCJLxo/MddL9iDSOMXCo4ldLA1c3PiNofKLW6
# gWlkKrWmotVzr9xG2wSukdduxZi61EfEVnSAR3hYjL7vK/3sbL/RlPe/UOB74JD9
# IBh4GCJdCC6MHKCX8x2ZfaOdkdMGRE4EbnocIOM28LZQuTCCBEwwggM0oAMCAQIC
# ExMAAAAGLUYVgdAHJfgAAAAAAAYwDQYJKoZIhvcNAQEFBQAwGDEWMBQGA1UEAxMN
# VkNBTkFDQS0wMS1DQTAeFw0xNDA2MDYxOTEyMjJaFw0yNDA2MDYxOTIyMjJaMFkx
# GjAYBgoJkiaJk/IsZAEZFgpjYW5hLWdyb3VwMRkwFwYKCZImiZPyLGQBGRYJY2Fu
# YWdyb3VwMSAwHgYDVQQDExdjYW5hZ3JvdXAtVkNBTkFDQS0wMi1DQTCCASIwDQYJ
# KoZIhvcNAQEBBQADggEPADCCAQoCggEBALYAghcYHT1OPm+SA2FEWnnNNBltH4ix
# xES3za6BUIg9buOh4+NyUShKNwsWZtrL1SjA//SSMtyIqhwOSyz6Nfl3MaEd9BzS
# ME5TkPLey+EBHsDUEjhjhSLOS2HX/eRu10WATUB7QfJZgf/3K9C8GNSxe9KeIUvs
# 2liP5UfOrj60mseXyzKOAEXGT74IN58Czr3PQZfuRf1Vm6JH1DW1Mpbdvi5ZGr4F
# 0MLEhMQ01VxLPFKSlp4Kmt6MyPtkub9OJISvU3JDqxVisI7KKs87RW1wT/Og/TEc
# QWOsbUJm/SwjDIfvZlv5AiNGL91X05aXqFarIEma2pPp2QwdU85YCZsCAwEAAaOC
# AUwwggFIMBAGCSsGAQQBgjcVAQQDAgECMCMGCSsGAQQBgjcVAgQWBBRyijiHXgfL
# 88D1K7XaFeWY6OQiqDAdBgNVHQ4EFgQU05cxXe0i3fcSHG3Pg6X7qM5MzscwGQYJ
# KwYBBAGCNxQCBAweCgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQF
# MAMBAf8wHwYDVR0jBBgwFoAUX98Zsdd22Rfwd96dNOgO2KG2SjAwPwYDVR0fBDgw
# NjA0oDKgMIYuaHR0cDovL3ZjYW5hY2EtMDIvQ2VydEVucm9sbC9WQ0FOQUNBLTAx
# LUNBLmNybDBVBggrBgEFBQcBAQRJMEcwRQYIKwYBBQUHMAKGOWh0dHA6Ly92Y2Fu
# YWNhLTAyL0NlcnRFbnJvbGwvVkNBTkFDQS0wMV9WQ0FOQUNBLTAxLUNBLmNydDAN
# BgkqhkiG9w0BAQUFAAOCAQEAHV8j8+9DW2T5VsORwO2dJyRlp3ae0YYEkKKdgEB0
# IClWqOoUd0pGVXLlNWUEfTr3mbigzeNmtMWs7SsqlGuWech929GJJvHCJpx/gIWR
# OF0fE5WPS6+F400krI9DNToB8GBNkc/SBLGUcq8YlsqTvOp969MrhzaD0Ga7qUpL
# lIG7OJU59da5ckkvbq/05z2OZ/IO/3O6u9juAv82INd8z/WxZ5daEOOqH0DopDKE
# wg0jKzIaomqXi6JRO9EYsT1hEJazgVSzK1Zbe0SatL73Z2ORoVL+fBUL0UPrFp2N
# 4oBDmXK3YRO0b/czZE6vhPL0LcJcvmYEylcNxYiXQuNheDCCBMYwggOuoAMCAQIC
# DCRUuH8eFFOtN/qheDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJCRTEZMBcG
# A1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBUaW1l
# c3RhbXBpbmcgQ0EgLSBTSEEyNTYgLSBHMjAeFw0xODAyMTkwMDAwMDBaFw0yOTAz
# MTgxMDAwMDBaMDsxOTA3BgNVBAMMMEdsb2JhbFNpZ24gVFNBIGZvciBNUyBBdXRo
# ZW50aWNvZGUgYWR2YW5jZWQgLSBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
# AQoCggEBANl4YaGWrhL/o/8n9kRge2pWLWfjX58xkipI7fkFhA5tTiJWytiZl45p
# yp97DwjIKito0ShhK5/kJu66uPew7F5qG+JYtbS9HQntzeg91Gb/viIibTYmzxF4
# l+lVACjD6TdOvRnlF4RIshwhrexz0vOop+lf6DXOhROnIpusgun+8V/EElqx9wxA
# 5tKg4E1o0O0MDBAdjwVfZFX5uyhHBgzYBj83wyY2JYx7DyeIXDgxpQH2XmTeg8AU
# XODn0l7MjeojgBkqs2IuYMeqZ9azQO5Sf1YM79kF15UgXYUVQM9ekZVRnkYaF5G+
# wcAHdbJL9za6xVRsX4ob+w0oYciJ8BUCAwEAAaOCAagwggGkMA4GA1UdDwEB/wQE
# AwIHgDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBHjA0MDIGCCsGAQUFBwIBFiZodHRw
# czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMBYG
# A1UdJQEB/wQMMAoGCCsGAQUFBwMIMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9j
# cmwuZ2xvYmFsc2lnbi5jb20vZ3MvZ3N0aW1lc3RhbXBpbmdzaGEyZzIuY3JsMIGY
# BggrBgEFBQcBAQSBizCBiDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9i
# YWxzaWduLmNvbS9jYWNlcnQvZ3N0aW1lc3RhbXBpbmdzaGEyZzIuY3J0MDwGCCsG
# AQUFBzABhjBodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3N0aW1lc3RhbXBp
# bmdzaGEyZzIwHQYDVR0OBBYEFNSHuI3m5UA8nVoGY8ZFhNnduxzDMB8GA1UdIwQY
# MBaAFJIhp0qVXWSwm7Qe5gA3R+adQStMMA0GCSqGSIb3DQEBCwUAA4IBAQAkclCl
# DLxACabB9NWCak5BX87HiDnT5Hz5Imw4eLj0uvdr4STrnXzNSKyL7LV2TI/cgmkI
# lue64We28Ka/GAhC4evNGVg5pRFhI9YZ1wDpu9L5X0H7BD7+iiBgDNFPI1oZGhjv
# 2Mbe1l9UoXqT4bZ3hcD7sUbECa4vU/uVnI4m4krkxOY8Ne+6xtm5xc3NB5tjuz0P
# YbxVfCMQtYyKo9JoRbFAuqDdPBsVQLhJeG/llMBtVks89hIq1IXzSBMF4bswRQpB
# t3ySbr5OkmCCyltk5lXT0gfenV+boQHtm/DDXbsZ8BgMmqAc6WoICz3pZpendR4P
# vyjXCSMN4hb6uvM0MIIGfzCCBWegAwIBAgITTgAACW3cM1+/ejCSQAACAAAJbTAN
# BgkqhkiG9w0BAQUFADBZMRowGAYKCZImiZPyLGQBGRYKY2FuYS1ncm91cDEZMBcG
# CgmSJomT8ixkARkWCWNhbmFncm91cDEgMB4GA1UEAxMXY2FuYWdyb3VwLVZDQU5B
# Q0EtMDItQ0EwHhcNMTkwOTEwMTcxMzExWhcNMjAwOTA5MTcxMzExWjCBlDEaMBgG
# CgmSJomT8ixkARkWCmNhbmEtZ3JvdXAxGTAXBgoJkiaJk/IsZAEZFgljYW5hZ3Jv
# dXAxGTAXBgNVBAsTEENBTkEgR3JvdXAgVXNlcnMxGzAZBgNVBAsTEkNBTkEgTGlt
# aXRlZCBVc2VyczELMAkGA1UECxMCSVQxFjAUBgNVBAMTDUp1c3RpbiBIb2xtZXMw
# ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCnBfU4e3OaJ2884NQae573
# X08fTJlAp+9UkPQgtQcapVUgh++m5Gjsf0D9LEWfIyNioHzPXpPcimpwX/MQqyI5
# qThmAgzJlhG9GONGMd3yhwOqr1GnPeEgu47jpX/W/Dyz9ooqj4CYH6/KGebiEP9u
# 27xRtG3P279OoGXfaqWlZw1uDKRJQrkzJST432fD/36V3hJWGgtU6B6x2Ni5jlmN
# e9IJtNzSCtCn7b1UN8nxfsl2XbqARDVH6lpLA7MT76xI4Z4fRCJu9nR8dmKKrQji
# oM9aBaMPWIo8PCd8dnxeFPFmq3cVcQRPM8ZS2MnsIoZUhsFlLcuNR0BjkVLhBgrR
# AgMBAAGjggMCMIIC/jALBgNVHQ8EBAMCB4AwPQYJKwYBBAGCNxUHBDAwLgYmKwYB
# BAGCNxUIgpSHfILYwxuC3Y8nhLzjEIeB3VeBVYT1wxW741wCAWQCAQUwHQYDVR0O
# BBYEFAHEyQIMrcHjAnBPvzmW8+MzdwpMMB8GA1UdIwQYMBaAFNOXMV3tIt33Ehxt
# z4Ol+6jOTM7HMIIBNQYDVR0fBIIBLDCCASgwggEkoIIBIKCCARyGgcpsZGFwOi8v
# L0NOPWNhbmFncm91cC1WQ0FOQUNBLTAyLUNBLENOPXZDQU5BQ0EtMDIsQ049Q0RQ
# LENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZp
# Z3VyYXRpb24sREM9Y2FuYWdyb3VwLERDPWNhbmEtZ3JvdXA/Y2VydGlmaWNhdGVS
# ZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBv
# aW50hk1odHRwOi8vdkNBTkFDQS0wMi5jYW5hZ3JvdXAuY2FuYS1ncm91cC9DZXJ0
# RW5yb2xsL2NhbmFncm91cC1WQ0FOQUNBLTAyLUNBLmNybDCB0gYIKwYBBQUHAQEE
# gcUwgcIwgb8GCCsGAQUFBzAChoGybGRhcDovLy9DTj1jYW5hZ3JvdXAtVkNBTkFD
# QS0wMi1DQSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2Vy
# dmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1jYW5hZ3JvdXAsREM9Y2FuYS1ncm91
# cD9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1
# dGhvcml0eTATBgNVHSUEDDAKBggrBgEFBQcDAzAbBgkrBgEEAYI3FQoEDjAMMAoG
# CCsGAQUFBwMDMDAGA1UdEQQpMCegJQYKKwYBBAGCNxQCA6AXDBVKdXN0aW4uSG9s
# bWVzQGNhbmEuY2EwDQYJKoZIhvcNAQEFBQADggEBAK/51/vESFjme4tgkr8wOoNJ
# QRX2j+q90c9tPNjsdad8cAM+EzqGFuhe9WjA/1vG7oY8mXHkxm9Xr9HgCUSyuZcs
# OhzHXv+NbmLPbH6UB3g5pTR3ALzze/AqDYgtLhVtI7O4r4LWi6VMk9dZBC9LLD9Q
# RHIBjGfY0Jzxty+PEjFxZ60PyJl7sLYxgYZYT9N40//jVT+SnLgj98SQ8yeiWcBZ
# Jds9WyqzvgthmMt1SXD+99dra1ifDOs5wXV3JRApujDfRiLjxWsnEKi6xOuq8u3i
# gVMwWgHTOaC1fkOVyxaeuI3ewnEz0I35Ec4D3c3Tcd0w6TCx2pe/5JsPLfsHg5gx
# ggSmMIIEogIBATBwMFkxGjAYBgoJkiaJk/IsZAEZFgpjYW5hLWdyb3VwMRkwFwYK
# CZImiZPyLGQBGRYJY2FuYWdyb3VwMSAwHgYDVQQDExdjYW5hZ3JvdXAtVkNBTkFD
# QS0wMi1DQQITTgAACW3cM1+/ejCSQAACAAAJbTANBglghkgBZQMEAgEFAKBMMBkG
# CSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMC8GCSqGSIb3DQEJBDEiBCDUBHby4BzD
# dwaXEIZ16MsI5yO1tTi3QAcU0IYUW8Lk1DANBgkqhkiG9w0BAQEFAASCAQB4njwC
# scfmY9jf7uiLcV7eQMc1y+So1G951yXLAG4mH0TK1Rfr/dSLk7YEspjKkTo/Nv2v
# l+Jb8arXJrc8o8tLm/5ytq9EW9Wr6XV46t3EGA7nwtRfhGnriyifv2Ky+MkVshDk
# jVbJWDOgpp6cAjSGHyIPULDKQrB/MeGa9ciehAd37cZYCId6m7stWlHH01jh7gRR
# 4qqygL5mxs5Psc8gKU3nwwAtZyg+EVNUhM7YY87qyu2oS7+ZstT7tbkf7f7mBnak
# 30RnNC4zHZrOVEIr3CQxQACsCM8Z93y0iCZpl0XZHXUarsAA6t+OzFrEhSvS0gll
# 61Ts97aWWaWvY2iPoYICuTCCArUGCSqGSIb3DQEJBjGCAqYwggKiAgEBMGswWzEL
# MAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMT
# KEdsb2JhbFNpZ24gVGltZXN0YW1waW5nIENBIC0gU0hBMjU2IC0gRzICDCRUuH8e
# FFOtN/qheDANBglghkgBZQMEAgEFAKCCAQwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
# DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkxMTEyMjIyODU0WjAvBgkqhkiG9w0BCQQx
# IgQgFki4/uDgfx0yZj3HRm96bZoyDIvlNhbL9PC910o0+bYwgaAGCyqGSIb3DQEJ
# EAIMMYGQMIGNMIGKMIGHBBQ+x2bV1NRy4hsfIUNSHDG3kNlLaDBvMF+kXTBbMQsw
# CQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMo
# R2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0EgLSBTSEEyNTYgLSBHMgIMJFS4fx4U
# U603+qF4MA0GCSqGSIb3DQEBAQUABIIBAINicAqeJ7z9+aK2wKU9uqkXGmdiGS3B
# sOVdVmAzvqckLlup27SafHrtcaMgBZRbOEPhGmygNl3AXoKs1Gmtkii1Ten5XtFb
# I0oEoP+EU9h75dRYRYFOSaztzouPmh4nnKMDwN8J7YMwGu3iJCW8ToHaiHWNn1tU
# zgBL3bEFTJ42GVDujC4SXGO2y+xpMK/MjTdSBcJCpM6jWRAVMElT7+vx6sLZrhwH
# QzyNigBFt8tGYpLqK15D5b9AVZzTESi0H1dtHYO5KU+Xj74bQ3dW8ryTDjP/94VT
# exiFaojtzdMrOnLkf4sbAWkUFBAUqweuqG00XJvitkyzTrLycP7CUCQ=
# SIG # End signature block
