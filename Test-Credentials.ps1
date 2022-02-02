﻿<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.170
	 Created on:   	12/16/2019 1:22 PM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	Test-Credentials.ps1
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

# SIG # Begin signature block
# MIIcFQYJKoZIhvcNAQcCoIIcBjCCHAICAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBV0EP2I95V/PxK
# PfOpKNckuT2zPYtYzJSVkpsmEvBf3qCCFsUwggMLMIIB86ADAgECAhAdBzYmM16G
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
# vyjXCSMN4hb6uvM0MIIGfzCCBWegAwIBAgITTgAACemaeFnpVfhH6wACAAAJ6TAN
# BgkqhkiG9w0BAQUFADBZMRowGAYKCZImiZPyLGQBGRYKY2FuYS1ncm91cDEZMBcG
# CgmSJomT8ixkARkWCWNhbmFncm91cDEgMB4GA1UEAxMXY2FuYWdyb3VwLVZDQU5B
# Q0EtMDItQ0EwHhcNMTkxMjEzMTkyNDUwWhcNMjAxMjEyMTkyNDUwWjCBlDEaMBgG
# CgmSJomT8ixkARkWCmNhbmEtZ3JvdXAxGTAXBgoJkiaJk/IsZAEZFgljYW5hZ3Jv
# dXAxGTAXBgNVBAsTEENBTkEgR3JvdXAgVXNlcnMxGzAZBgNVBAsTEkNBTkEgTGlt
# aXRlZCBVc2VyczELMAkGA1UECxMCSVQxFjAUBgNVBAMTDUp1c3RpbiBIb2xtZXMw
# ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC0mIgJG9Gv/ysSfBFQa2s/
# cwibayyjOZFsir8Bo+vnDTstLdw1tQGb/k4s5RiwMuS05YKU1pyBOOfsFT3nLhLW
# gm4oA90pUT3SZ33UP6tsI9xthCYHWsc6rK1GMUJqOk1t+OgBTNW6iHVD+BOIoSh5
# dz9t43YxaVlfDj7ZVw4mFGOGnQL2rUrpaZuJPikEGbPbZOvPR45o8eUK5avuf+S7
# lOLEcKOIbpY72RlQJw9KPC8Lk3TtlFDPf6yJJPGsqOf5XQqRBFey264Hv7R/Pnzs
# 3Ak97szx0VG7TEGQLk8CXEQRDIafNJNDnktiyw9C4lDfAMvFfHAjL/HvWLrgfdjl
# AgMBAAGjggMCMIIC/jALBgNVHQ8EBAMCB4AwPQYJKwYBBAGCNxUHBDAwLgYmKwYB
# BAGCNxUIgpSHfILYwxuC3Y8nhLzjEIeB3VeBVYT1wxW741wCAWQCAQUwHQYDVR0O
# BBYEFHFb4fr3kmup4gtFxFYrlYWIVEPhMB8GA1UdIwQYMBaAFNOXMV3tIt33Ehxt
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
# bWVzQGNhbmEuY2EwDQYJKoZIhvcNAQEFBQADggEBAGuwWHTsjcqHpRgvlqcNAhv3
# +/jrd8F6yzMypiLbG46yWNsWOx7/V7xMgWw79zbq5hRH/jG7akcLirXa4L0gWfps
# slW3CQRKJlGrV1y/zeD8Bs1kUcrEp167nHDbnGfMaEDOOK6tErektLNB33rJNQ+Q
# EY8d2AP+Q4BrlGgrdH6knQf2Mf3vT01wYoz8akTrZa0NNS/ZF2hfX8uNxFjKhEb3
# WR8DCrhT6cvJK7BG83RWkwEQRkEEr03zISh3XXaJv3MXMPdWufIr/w/CmUI96J2Q
# +hvi06GaczfsiVFpqdjTJ3O+8uUQuA7Kg7wtba0DL/zG7sp3xaRrZ1Nh8ea9ioox
# ggSmMIIEogIBATBwMFkxGjAYBgoJkiaJk/IsZAEZFgpjYW5hLWdyb3VwMRkwFwYK
# CZImiZPyLGQBGRYJY2FuYWdyb3VwMSAwHgYDVQQDExdjYW5hZ3JvdXAtVkNBTkFD
# QS0wMi1DQQITTgAACemaeFnpVfhH6wACAAAJ6TANBglghkgBZQMEAgEFAKBMMBkG
# CSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMC8GCSqGSIb3DQEJBDEiBCATysiLp81j
# oy6XpGJicIV60sjv2WehYR2EhnTRLg3/sDANBgkqhkiG9w0BAQEFAASCAQBMUEHX
# Dnu/DgiH9THCCPodSzoQ7DsZ5mG3fVQeyYApfASrGZHcpbLFbADsFJ8UeylyNAcd
# 9wzsiM2bMItlHVEagIfQVB8Gq5P4Fje4XzLgwQoevAwdOzQvIrwHo7TCsgukXWg5
# B4sJovc+CXZbkgUjWB91sFlDe3SN+gewWntmoFb8q3vlMAGUzkKnNwwMBi5JGU2R
# 09zxf2KEflIxtQDbS6vdOjkhlpHtRlYPjzHPMCWq7KkbBhmdXdKK+Onrx9VHTz6C
# FG/4gqHWk8r7IZus7DHGU5Xdo/omkqd+JjUjoSrH1SujIPg3JNFXC7S+RvdQ5uHB
# 7kOvbq12pws39vkloYICuTCCArUGCSqGSIb3DQEJBjGCAqYwggKiAgEBMGswWzEL
# MAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMT
# KEdsb2JhbFNpZ24gVGltZXN0YW1waW5nIENBIC0gU0hBMjU2IC0gRzICDCRUuH8e
# FFOtN/qheDANBglghkgBZQMEAgEFAKCCAQwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
# DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkxMjE2MjAyODAzWjAvBgkqhkiG9w0BCQQx
# IgQgQ0JAcmJ8E2/fGo2yWiniMZn507/Cd/AyHheyi4015fUwgaAGCyqGSIb3DQEJ
# EAIMMYGQMIGNMIGKMIGHBBQ+x2bV1NRy4hsfIUNSHDG3kNlLaDBvMF+kXTBbMQsw
# CQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMo
# R2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0EgLSBTSEEyNTYgLSBHMgIMJFS4fx4U
# U603+qF4MA0GCSqGSIb3DQEBAQUABIIBAGQ0x9P9qVgLqKvVSJYJ6Mv0uv7W+aUe
# FYFsdNGntl84ftK7lV6GYUwnzbBdIDsj7/CGbvyrYkSCn6b2SQvg4J/vAfJdvliS
# CB7QQ2GHFMFxUy6HLAtgt9zvXYyWnhg7Xq82g394o3ShnEx6yjiGVejL7QAp+CnE
# 6H6GGvq3S4ZhprTbcke1Toyy/6m1zszD3GEmbtqRUndw/N6Shbhq7z3jNr7aTwwK
# q+9g4qukL2V8pv5pJVThf7fUBhYkqDrkm/LddafAfJjwas0VlNDygDeHnYQ2UWZs
# FycuV11QkF8SqOcg+jn2MKet/+lvppOHpTLrMCYDU8Qt+LFsm+AoZ7k=
# SIG # End signature block
