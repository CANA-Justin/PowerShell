﻿<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2020 v5.7.181
	 Created on:   	10/15/2020 10:32 AM
	 Created by:   	Justin Holmes
	 Organization: 	
	 Filename:     	O365-ExchangeClearPreviousMailboxInfo.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

#Requires -RunAsAdministrator	
Import-Module "\\canagroup.cana-group\business\IT Storage\Scripts\CANA-Justin\PowerShell\Select-MenuItem.ps1"



if (Get-Module -ListAvailable -Name ExchangeOnlineManagement)
{
	Write-Verbose "Module ExchangeOnlineManagement exists on system"
}
else
{
	Write-Verbose "Module ExchangeOnlineManagement does not exist on system"
	
	
	Write-Host "Module" -nonewline
	Write-Host " ExchangeOnlineManagement" -NoNewline -ForegroundColor Red
	Write-Host " does not exist on this system"
	Write-Host "You NEED to install this module for this script to work"
	
	$Ans2 = select-menuitem -heading "Install Module" -prompt "Would you like to install the ExchangeOnlineManagement module?" -menutext 'yn' -default "no"
	
	if ($Ans2 -eq "Yes")
	{
		Write-Verbose "Installing ExchangeOnlineManagement"
		Write-Host "Installing ExchangeOnlineManagement"
		Install-Module -Name ExchangeOnlineManagement -Force -MinimumVersion 0.3582.0
		
		Write-Verbose "Done installing ExchangeOnlineManagement"
		Write-Host "Done installing ExchangeOnlineManagement"
	}
	else
	{
		
		Write-Host " " -BackgroundColor Yellow
		Write-Host " " -BackgroundColor Yellow -NoNewline
		Write-Host " You have choosen to not install ExchangeOnlineManagement module " -BackgroundColor Black
		Write-Host " " -BackgroundColor Yellow -NoNewline
		Write-Host " Operation aborted!                                              " -ForegroundColor Red -BackgroundColor Black
		Write-Host " " -BackgroundColor Yellow
		Pause
		exit
	}
	
}
Write-Host ""
Write-Host ""
$AdminUsername = Read-Host "Enter the username/email of your O365 Administrator"

Write-Verbose "Importing module ExchangeOnlineManagement"
Import-Module ExchangeOnlineManagement

Write-Verbose "Connecting to Office 365 with $AdminUsername"
Connect-ExchangeOnline -UserPrincipalName $AdminUsername -DelegatedOrganization canagroup.onmicrosoft.com


$ClientUsername = Read-Host "Enter the username/email of your f*ed user"

Write-Host ""
Write-Host ""

$Ans3 = select-menuitem -heading "DELETE MAILBOX" -prompt "Would you like to permanently delete $ClientUsername online mailbox and start the migration again?" -menutext 'yn' -default "no"


if ($Ans3 -eq "Yes")
{
	Set-User -Identity $ClientUsername -PermanentlyClearPreviousMailboxInfo
	
	Write-Verbose "Pausing for review"
	Pause
	
	Write-Verbose "Closing open PS Sessions to Office 365"
	Get-PSSession | Remove-PSSession
	
	exit
}
else
{
	
	Write-Host " " -BackgroundColor Yellow
	Write-Host " " -BackgroundColor Yellow -NoNewline
	Write-Host " You have choosen to not delete $ClientUsername online mailbox " -BackgroundColor Black
	Write-Host " " -BackgroundColor Yellow -NoNewline
	Write-Host " Operation aborted!                                                 " -ForegroundColor Red -BackgroundColor Black
	Write-Host " " -BackgroundColor Yellow
	Pause
	Write-Verbose "Closing open PS Sessions to Office 365"
	Get-PSSession | Remove-PSSession
	
	exit
}




# SIG # Begin signature block
# MIIcugYJKoZIhvcNAQcCoIIcqzCCHKcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCD/VZRwXYYUZ2t9
# PFZdCP1edqyLB105hsKSKKltCO+nKKCCF2owggOwMIICmKADAgECAhBz0HdolQdJ
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
# CSqGSIb3DQEJBDEiBCB7rnJHmhWPvvhi4opgx4SwD3ypDkLiwWuNtiqVOU+1pDAN
# BgkqhkiG9w0BAQEFAASCAQAn5izc7bxKkbBbMc7Sf8Z7c8g74z2v1JNXk+c3mD2f
# jkdNkVKre4yizfRPM8OP3e71K4CcGybvnwaXI4M+RlgDeUgXo+jhNz/UUbbzy/ad
# rdvc80PEnZODdlwVmcgHB6SwlidS/jZibIQ3/cOepVpKaiHMWSf88bfI0ZEUEzYn
# P2iwjIPSurP7ourNDdgXC5ZZVHsV4IYB8IIZNZxPLTeucPP2wYflU2pYetSq8emi
# Fhg/uk7iuF4FWn17RP4pTBhkMczJhiEQNb6kqnYJ1fMyvu4M5V93FyczGgMI8Y05
# pW0gWghbhUj92KDJbjXv6QhCgZrv5yZljKdj0VqsNkYAoYICuTCCArUGCSqGSIb3
# DQEJBjGCAqYwggKiAgEBMGswWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2Jh
# bFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gVGltZXN0YW1waW5nIENB
# IC0gU0hBMjU2IC0gRzICDCRUuH8eFFOtN/qheDANBglghkgBZQMEAgEFAKCCAQww
# GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjAxMDE1
# MTY1MTIxWjAvBgkqhkiG9w0BCQQxIgQgz1Ly5JKlsZ6VgxH5bV6jDNsWRlcWdsop
# cwSvZAkeHuowgaAGCyqGSIb3DQEJEAIMMYGQMIGNMIGKMIGHBBQ+x2bV1NRy4hsf
# IUNSHDG3kNlLaDBvMF+kXTBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFs
# U2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0Eg
# LSBTSEEyNTYgLSBHMgIMJFS4fx4UU603+qF4MA0GCSqGSIb3DQEBAQUABIIBADXu
# hhjDpJwuAVF13IZhHzyZjoJOSZBF8OR9JmuBbeB92XqzoCs8FZ/sktB/tHXmeMFc
# KhvDno7sRAmX64vznl/Wdk4SPojp4S5eZJ+nQv4ycq+sxOdB/slElM0wp29wNNRh
# X58M/RWuhBxKVjUzLsLRkgSjOO5KBnf7FoiX4zCGAa+5YORVJlArMQm1O2oEJZqs
# qCIioe4oCtXL65el3py8wLDbrPPAzM43PSzczF/ROeZ9pDFNla36YvX1u+DK8Kgv
# IU5GIzqzoNwD3Wxr5auW64NwkpuJhrOJo5dNVGLwaBZ3SZkIfNGTmFFyFyZGr7Qk
# M3d0p4uLPVsxiXCUfL8=
# SIG # End signature block
