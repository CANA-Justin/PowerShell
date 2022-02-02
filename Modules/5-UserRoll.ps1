﻿<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.163
	 Created on:   	06/11/2019 11:08 AM
	 Created by:   	admjustin
	 Organization: 	
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

if (Get-Module -ListAvailable -Name ActiveDirectory)
{
	Write-Debug "Module ActiveDirectory exists on system"
}
else
{
	Write-Host -ForegroundColor Red "Module ActiveDirectory is not installed on $env:COMPUTERNAME"
	exit
}


#	Write-Verbose "Importing Scripts"
#	Write-Debug "Importing *.PS1 from \\canagroup.cana-group\SYSVOL\canagroup.cana-group\scripts\Powershell\Modules\CANANewUser\Templates"
#	$ImportTemplateModules = Get-ChildItem -Path "\\canagroup.cana-group\SYSVOL\canagroup.cana-group\scripts\Powershell\Modules\CANANewUser\Templates" -Recurse -Force -exclude "*.TempPoint.ps1"
#	Write-Debug "Importing *.PS1 from \\canagroup.cana-group\SYSVOL\canagroup.cana-group\scripts\Powershell\Modules\CANANewUser\Templates"
#	$ImportTemplateModules += Get-ChildItem -Path "\\canagroup.cana-group\SYSVOL\canagroup.cana-group\scripts\Powershell\Modules\CANANewUser\Templates" -Force #-exclude "*.ps1"
	foreach ($TemplateModule in $ImportTemplateModules)
	{
		Write-Debug "Importing $TemplateModule"
		Import-Module $TemplateModule
	}
	Write-Verbose "Done Importing Scripts"
	Write-Debug "Done Importing Scripts"

#$AdminCredentials = Get-Credential -Message "Credential are required for access the Domain Controller, File server and Exchange server"
$UserName = Read-Host "Enter the Username of the User"
$UserRoll = Read-Host "Enter the role for $UserName"
#$DomainController1 = Read-Host "Enter the Name of the Domain Controller"

Write-Verbose "Making Connection"
#$session = New-PSSession -ComputerName $DomainController1 -Credential $AdminCredentials
Write-Verbose "Invoke Active Directory"
#Invoke-Command -Session $session -Scriptblock { $ImportTemplateModules = Get-ChildItem -Path "\\canagroup.cana-group\SYSVOL\canagroup.cana-group\scripts\Powershell\Modules\CANANewUser\Templates" -Recurse -Force -exclude "*.TempPoint.ps1" }
$ImportTemplateModules = Get-ChildItem -Path "\\canagroup.cana-group\SYSVOL\canagroup.cana-group\scripts\Powershell\Modules\CANANewUser\Templates" -Recurse -Force -exclude "*.TempPoint.ps1"
#Invoke-Command -Session $session -Scriptblock {
	foreach ($TemplateModule in $ImportTemplateModules)
	{
		Write-Debug "Importing $TemplateModule"
		. $TemplateModule -ErrorAction SilentlyContinue
	}
#}




Import-Module ActiveDirectory
Write-Verbose "Invoke UserRoll Script"
.$UserRoll $UserName

#Remove-PSSession $Session

# SIG # Begin signature block
# MIIbwAYJKoZIhvcNAQcCoIIbsTCCG60CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBr1aQmLFEdeGjp
# 84TqC95gyqUTxgv2XW1Aoayjw4WlcqCCFvEwggOwMIICmKADAgECAhBz0HdolQdJ
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
# hvcNAQkDMQwGCisGAQQBgjcCAQQwLwYJKoZIhvcNAQkEMSIEIG0Gtbe/ITj56hyz
# boNXtFPxw+hVEt0XQ/v+yCtC8tPvMA0GCSqGSIb3DQEBAQUABIGARU4wUj7ct+R3
# YHHuz8yrD/TegjMdtF6ryHlWRtmz/awR5cJvvFJ7oVHcdDoy/pRdX/hMkPjVw5NQ
# 9rWrMyesvesF4tMz/4HUiEq+Gk7zXgYIDFbCeGZUMpGP4az7g7bWCNpIjkFa8m2B
# OJX5FlC8zHSP0k3REY2MVqsSCvkoLP2hggK5MIICtQYJKoZIhvcNAQkGMYICpjCC
# AqICAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
# YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0EgLSBTSEEyNTYg
# LSBHMgIMJFS4fx4UU603+qF4MA0GCWCGSAFlAwQCAQUAoIIBDDAYBgkqhkiG9w0B
# CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTAyMDExNzM0MzJaMC8G
# CSqGSIb3DQEJBDEiBCAoJZoL9zNvbrIKAdxecgUC3Dwrr7pMq3briNdSH04xkTCB
# oAYLKoZIhvcNAQkQAgwxgZAwgY0wgYowgYcEFD7HZtXU1HLiGx8hQ1IcMbeQ2Uto
# MG8wX6RdMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
# MTEwLwYDVQQDEyhHbG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAtIFNIQTI1NiAt
# IEcyAgwkVLh/HhRTrTf6oXgwDQYJKoZIhvcNAQEBBQAEggEAU3o9HOIrwhmqNdH7
# B38vz9zCNUK/3sI+bHGcWFJ8EfF2Dk8u5TcXb3u2+Rw59xqt1DZOk2D37PA2X8i9
# nuvVrvWqGqHnxWaUqOGRplV/pRD932wyN+Gyi9mQjrEmnoBl0UGOClyNzsaMosb9
# N5Ma3ZFNGR3d5t3YUYWVP4g9NGf/Juu0hpKiP9fgi1I3X9C4kALoaRNZi2sxkmuC
# nIkf6LnHkyS9k0+LRrLyxUq3KaH1SbilMAotLCrPV+M/s5TNW6EMBn98LszZCyKj
# +YuTJVtCBqCe2nyg8qfFWUwd/yr7/a4Gr3P4xTudq8YMqtAXCMi4R/xut2/qT0CB
# JwtaQw==
# SIG # End signature block
