﻿<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2020 v5.7.181
	 Created on:   	10/16/2020 7:54 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	CCCL150Estimator.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

<#
	.SYNOPSIS
		Adds the user to the groups defined in this function
	
	.DESCRIPTION
		Adds the user to the groups defined in this function


		Domain Users
		All Users
		Head Office Users
		Est_Sec
		Salaried Employees
		All CANA Construction Users
		CANA Construction Estimating Report
		SW_Viewpoint_Users
		CANA Construction Weekly RFP and Tender Schedule
		XenAppUsers
		XenApp75_Users
		tfa.Estimating.RWED
		Vista Viewpoint Users
		SP_CCCL_Staff
		VPN_Access
		Drive J - Business
		Password.Policy.NonExpire
		stfa.CCCLProjectJobs.RWED
		All CANA Energy Users                                            

	
	.EXAMPLE
				PS C:\> Add-CCCL150Estimator $Username
	
	.NOTES
		Using an array and a foreach loop, the listed AD groups are added to the users group membership.  This file is expected to be imported in to the overall module to allow flexibility for adding new rolls, or modifying existing ones without having to modify the core script or module.
#>
function Add-CCCL150Estimator
{
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $true)]
		[string]$Username
	)
	Write-Debug "The username is $Username"
	Write-Debug "Creating empty array"
	$ADGroups = [System.Collections.ArrayList]@()
	
	Write-Debug "Adding groups to the Array"
	Write-Verbose "Adding groups to the Array"
	
	
	$ADGroups.add('311ProjectManager') | Out-Null
	$ADGroups.add('321ProjectAdministrator') | Out-Null
	$ADGroups.add('351Estimator') | Out-Null
	$ADGroups.add('361POReceiver') | Out-Null
	$ADGroups.add('371APReviewer') | Out-Null
	$ADGroups.add('All CANA Construction Users') | Out-Null
	$ADGroups.add('All iOS Users') | Out-Null
	$ADGroups.add('All Manager Services Users') | Out-Null
	$ADGroups.add('All Users') | Out-Null
	$ADGroups.add('CANA Construction - Project Coordinators') | Out-Null
	$ADGroups.add('CANA Construction Estimating Report') | Out-Null
	$ADGroups.add('CANA Construction Estimating Team') | Out-Null
	$ADGroups.add('CANA Construction iOS Users') | Out-Null
	$ADGroups.add('CANA Construction Weekly RFP and Tender Schedule') | Out-Null
	$ADGroups.add('CANA Safety - WCB Compliance') | Out-Null
	$ADGroups.add('Construction Lead Daily Summary') | Out-Null
	$ADGroups.add('Construction Opportunity Daily Summary') | Out-Null
	$ADGroups.add('Drive J - Business') | Out-Null
	$ADGroups.add('Est_Sec') | Out-Null
	$ADGroups.add('Group_0b6ba538-8ddf-4516-b638-ecb3297b4679') | Out-Null
	$ADGroups.add('Group_0d087eb3-24ba-4b2d-846c-d53bc47e6d56') | Out-Null
	$ADGroups.add('Group_6c0af341-fa96-4e41-9f3d-d5bb6759d2e7') | Out-Null
	$ADGroups.add('Group_74d1da38-1689-4762-a08c-2da5a38e48ab') | Out-Null
	$ADGroups.add('Group_766d0c7f-86c8-455d-ade7-a136f90602e2') | Out-Null
	$ADGroups.add('Group_8cc5cde0-426a-4fa8-817f-82734ab84454') | Out-Null
	$ADGroups.add('Group_a55402ed-7a8b-4553-b73f-c3f04a8162bf') | Out-Null
	$ADGroups.add('Group_b02da551-ff46-4f52-83db-c772825a3500') | Out-Null
	$ADGroups.add('Group_b7bba7bb-bfcb-4ec3-8264-482fcb5a818f') | Out-Null
	$ADGroups.add('Group_d73c57fb-2ad6-496d-b303-95a257a68574') | Out-Null
	$ADGroups.add('Group_dc9cb2ca-00ca-4d32-b07b-02c967ba5fbc') | Out-Null
	$ADGroups.add('Group_f2499731-360e-434d-9aec-45eef1850dab') | Out-Null
	$ADGroups.add('Head Office Users') | Out-Null
	$ADGroups.add('Iphone Users') | Out-Null
	$ADGroups.add('Password.Policy.NonExpire') | Out-Null
	$ADGroups.add('PBI_CES') | Out-Null
	$ADGroups.add('portal.Procore') | Out-Null
	$ADGroups.add('Print_CODA_Sec') | Out-Null
	$ADGroups.add('Salaried Employees') | Out-Null
	$ADGroups.add('SP KnowMatrix Notice Sub') | Out-Null
	$ADGroups.add('SP.All.Construction.R') | Out-Null
	$ADGroups.add('SP.ConstructionEstimating') | Out-Null
	$ADGroups.add('SP.ConstructionEstimating.Contribute') | Out-Null
	$ADGroups.add('SP_CCCL_Managers') | Out-Null
	$ADGroups.add('SP_CCCL_Staff') | Out-Null
	$ADGroups.add('SP_Construction_CRM_Contribute') | Out-Null
	$ADGroups.add('SP_Construction_CRM_Read') | Out-Null
	$ADGroups.add('SP_Construction_OPSManual_Dev') | Out-Null
	$ADGroups.add('SP_CSL_Managers') | Out-Null
	$ADGroups.add('SP_Managers_All') | Out-Null
	$ADGroups.add('stfa.CCCLProjectJobs.RWED') | Out-Null
	$ADGroups.add('SW_FWC_Users') | Out-Null
	$ADGroups.add('SW_Project_Users') | Out-Null
	$ADGroups.add('SW_Viewpoint_Test') | Out-Null
	$ADGroups.add('SW_Viewpoint_Users') | Out-Null
	$ADGroups.add('tfa.Estimating.RWED') | Out-Null
	$ADGroups.add('Viewpoint Users') | Out-Null
	$ADGroups.add('Vista Viewpoint Reviewers') | Out-Null
	$ADGroups.add('Vista Viewpoint Users') | Out-Null
	$ADGroups.add('VPN_Access') | Out-Null
	$ADGroups.add('XenApp75_Bluebeam_Revu12') | Out-Null
	$ADGroups.add('Xenapp75_Project2016') | Out-Null
	$ADGroups.add('XenApp75_Users') | Out-Null
	$ADGroups.add('XenApp75_Viewpoint_Prod') | Out-Null
	$ADGroups.add('XenAppUsers') | Out-Null	
	#$ADGroups.add('NAME') | Out-Null
	
	
	Write-Debug "Array contains $ADGroups"
	Write-Verbose "Added list of groups to array"
	
	Write-Debug "Starting Foreach"
	foreach ($ADGroup in $ADGroups)
	{
		Add-ADGroupMember -Identity $ADGroup -Members $Username
		Write-Debug "Adding $Username to the group $ADGroup"
		Write-Verbose "Adding $Username to the group $ADGroup"
	}
	
}

# SIG # Begin signature block
# MIIqDQYJKoZIhvcNAQcCoIIp/jCCKfoCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBK27IhJ8Zogjp7
# sO6B+A2FmgH1f8//eVs3fYtE/Yy6rKCCJAYwggNfMIICR6ADAgECAgsEAAAAAAEh
# WFMIojANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3Qg
# Q0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2ln
# bjAeFw0wOTAzMTgxMDAwMDBaFw0yOTAzMTgxMDAwMDBaMEwxIDAeBgNVBAsTF0ds
# b2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYD
# VQQDEwpHbG9iYWxTaWduMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
# zCV2kHkGeCIW9cCDtoTKKJ79BXYRxa2IcvxGAkPHsoqdBF8kyy5L4WCCRuFSqwyB
# R3Bs3WTR6/Usow+CPQwrrpfXthSGEHm7OxOAd4wI4UnSamIvH176lmjfiSeVOJ8G
# 1z7JyyZZDXPesMjpJg6DFcbvW4vSBGDKSaYo9mk79svIKJHlnYphVzesdBTcdOA6
# 7nIvLpz70Lu/9T0A4QYz6IIrrlOmOhZzjN1BDiA6wLSnoemyT5AuMmDpV8u5BJJo
# aOU4JmB1sp93/5EU764gSfytQBVI0QIxYRleuJfvrXe3ZJp6v1/BE++bYvsNbOBU
# aRapA9pu6YOTcXbGaYWCFwIDAQABo0IwQDAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0T
# AQH/BAUwAwEB/zAdBgNVHQ4EFgQUj/BLf6guRSSuTVD6Y5qL3uLdG7wwDQYJKoZI
# hvcNAQELBQADggEBAEtA28BQqv7IDO/3llRFSbuWAAlBrLMThoYoBzPKa+Z0uboA
# La6kCtP18fEPir9zZ0qDx0R7eOCvbmxvAymOMzlFw47kuVdsqvwSluxTxi3kJGy5
# lGP73FNoZ1Y+g7jPNSHDyWj+ztrCU6rMkIrp8F1GjJXdelgoGi8d3s0AN0GP7URt
# 11Mol37zZwQeFdeKlrTT3kwnpEwbc3N29BeZwh96DuMtCK0KHCz/PKtVDg+Rfjbr
# w1dJvuEuLXxgi8NBURMjnc73MmuUAaiZ5ywzHzo7JdKGQM47LIZ4yWEvFLru21Vv
# 34TuBQlNvSjYcs7TYlBlHuuSl4Mx2bO1ykdYP18wggOwMIICmKADAgECAhBz0Hdo
# lQdJoki8RRr2J0/sMA0GCSqGSIb3DQEBCwUAMBgxFjAUBgNVBAMTDVZDQU5BQ0Et
# MDEtQ0EwHhcNMTQwNjA1MjAzNTU3WhcNNDAwMjIyMTUwNDU1WjAYMRYwFAYDVQQD
# Ew1WQ0FOQUNBLTAxLUNBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
# l8bYqRoITo9oA5hAh6NMfF80ur408wGvPSaMCNW7lpsRdtvtkkrahACkEsgwSd+9
# lR7Df9gvXrrTFNS6dmYia0KrwlEWNCWVi3IZMB4LEW+dg75O2Dv5zyAWyI41S8mA
# Xr1auexdiQrQ1sXsK/bOgfSsa6QMuoEz5ygBgsASpDnJrkAfytpb9FusJItqOse9
# twcRhx8TUxAcMXFknRqTTIGVsI5EiW+Hz9IE7wlSKI64OWGgbA5CBPS9nQrNX03t
# jNvKX9fYnGc/M5AGQzX77lZEe+JFKP9xiagyp/U6NXzHkNGP3MI4HhcCKa22/WiK
# U8J3jBcMxXdYakAHohKrJwIDAQABo4H1MIHyMAsGA1UdDwQEAwIBhjAPBgNVHRMB
# Af8EBTADAQH/MB0GA1UdDgQWBBRf3xmx13bZF/B33p006A7YobZKMDAQBgkrBgEE
# AYI3FQEEAwIBATAjBgkrBgEEAYI3FQIEFgQUxdeKfYHC0kzdgNNR9c3hnA6RPMow
# fAYDVR0gBHUwczBxBggqAwSLL0NZBTBlMDoGCCsGAQUFBwICMC4eLABMAGUAZwBh
# AGwAIABQAG8AbABpAGMAeQAgAFMAdABhAHQAZQBtAGUAbgB0MCcGCCsGAQUFBwIB
# FhtodHRwOi8vcGtpLmNhbmEuY2EvY3BzLnR4dAAwDQYJKoZIhvcNAQELBQADggEB
# ADqsoXnS6AFVBoLccnE/PQdUkFRhGcCJGgpktJKXVmBqXzzGRIXBaEwErFpi10jR
# 5tiU5JonWJiZkSUoiXnNN64oemUZh6OB1TBoMau+6U/IXwa8tlju4MvjZBR5MQCn
# wRScOUS6YgjZFe2DJfMfBlzU1VBBcS2v7iaWGInt93cotOPqORYWp9OpTg7CU/09
# kdIt3GLwbRxqOmz77OirEGliAT8+D2sqw7S99mjxPHQQNRjGVIzXxdu1hE9WaY15
# fJZK8+W+FCrpxOc+t63aFh6qoa3kYkIjswG7plpXTOM5LYJfxRbQWwvMsNvMLAt7
# D7CHdVTSjfwnZ7aHbVtI7o0wggRRMIIDOaADAgECAhMTAAAACFKC+JYeThjcAAEA
# AAAIMA0GCSqGSIb3DQEBCwUAMBgxFjAUBgNVBAMTDVZDQU5BQ0EtMDEtQ0EwHhcN
# MjAwMjIyMTUzODAyWhcNMzAwMjIyMTU0ODAyWjBZMRowGAYKCZImiZPyLGQBGRYK
# Y2FuYS1ncm91cDEZMBcGCgmSJomT8ixkARkWCWNhbmFncm91cDEgMB4GA1UEAxMX
# Y2FuYWdyb3VwLVZDQU5BQ0EtMDItQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
# ggEKAoIBAQDN+NqHU7LkZG85wnNJZvwx/Ye3qtDcJzD+1kQRMD3Ju6Bdu1mgxzZ2
# k3+cFXzjfVZvRwRCprAlJb95LS3giBw8LAVhiiukx1jzPjxCELF7yDA3qd8CWQ3J
# S584bSBMbT6G2+mgem8SUA1F/JvHr2GhE6l0PFJPJRxSG1cJ3mIxwuj5JDdqOGaI
# yHufNP+YryFozxlWHGWoWBSjffEry8mQmQXkFv47M7dC1AVM6+jr3luMrTIVu2YG
# SbkFsHCxfD6NB6uslVkJpznA0Foqc6xeS/Vbvy1UR8wlquoNZBqc/Zoiv/bHy7KY
# Pqj91WqHtQ2d3GfXnz696bnL8QKIorDVAgMBAAGjggFRMIIBTTASBgkrBgEEAYI3
# FQEEBQIDAwADMCMGCSsGAQQBgjcVAgQWBBRDeQSZEXeYcpTN69HADKw4vcaSSDAd
# BgNVHQ4EFgQUN+lqP5/l0UP48FOv4cxBJxXOuj8wGQYJKwYBBAGCNxQCBAweCgBT
# AHUAYgBDAEEwCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0jBBgw
# FoAUX98Zsdd22Rfwd96dNOgO2KG2SjAwPwYDVR0fBDgwNjA0oDKgMIYuaHR0cDov
# L3ZjYW5hY2EtMDIvQ2VydEVucm9sbC9WQ0FOQUNBLTAxLUNBLmNybDBYBggrBgEF
# BQcBAQRMMEowSAYIKwYBBQUHMAKGPGh0dHA6Ly92Y2FuYWNhLTAyL0NlcnRFbnJv
# bGwvVkNBTkFDQS0wMV9WQ0FOQUNBLTAxLUNBKDEpLmNydDANBgkqhkiG9w0BAQsF
# AAOCAQEAVdG21+w19neEe0rOjjcDzS4xtx43cy44v5KP35jSn92EDQEs6xhY2mrL
# V8di78ts0XeH3iAIIyIhOV8UewyEmwtVXgiBS5gTdbVJ9IezrNgpPJijJXIShs98
# A5HlemjPItkTbaAD130K7VMX0qv0qLInOX/PboLH889zJeDUHXEbuXU8zG6PVW1Q
# WkLxmDgz1E0sbNESYtTXvG/AJDPGim05KzobgJyqxXYAguekavuloOJmgWtE9eYs
# ZBPzkOhihyHYVY1h3whMJOY4WPI+MuErGvLxIf37L4TUxyO/s2GvcXcI7agwe8yh
# MPquxhxWvqRobLQS5/fRAX9X5nrITzCCBUcwggQvoAMCAQICDQHyQEJAzv0i2+ls
# cfwwDQYJKoZIhvcNAQEMBQAwTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
# IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24w
# HhcNMTkwMjIwMDAwMDAwWhcNMjkwMzE4MTAwMDAwWjBMMSAwHgYDVQQLExdHbG9i
# YWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
# AxMKR2xvYmFsU2lnbjCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAJUH
# 6HPKZvnsFMp7PPcNCPG0RQssgrRIxutbPK6DuEGSMxSkb3/pKszGsIhrxbaJ0cay
# /xTOURQh7ErdG1rG1ofuTToVBu1kZguSgMpE3nOUTvOniX9PeGMIyBJQbUJmL025
# eShNUhqKGoC3GYEOfsSKvGRMIRxDaNc9PIrFsmbVkJq3MQbFvuJtMgamHvm566qj
# uL++gmNQ0PAYid/kD3n16qIfKtJwLnvnvJO7bVPiSHyMEAc4/2ayd2F+4OqMPKq0
# pPbzlUoSB239jLKJz9CgYXfIWHSw1CM69106yqLbnQneXUQtkPGBzVeS+n68UARj
# NN9rkxi+azayOeSsJDa38O+2HBNXk7besvjihbdzorg1qkXy4J02oW9UivFyVm4u
# iMVRQkQVlO6jxTiWm05OWgtH8wY2SXcwvHE35absIQh1/OZhFj931dmRl4QKbNQC
# TXTAFO39OfuD8l4UoQSwC+n+7o/hbguyCLNhZglqsQY6ZZZZwPA1/cnaKI0aEYdw
# gQqomnUdnjqGBQCe24DWJfncBZ4nWUx2OVvq+aWh2IMP0f/fMBH5hc8zSPXKbWQU
# LHpYT9NLCEnFlWQaYw55PfWzjMpYrZxCRXluDocZXFSxZba/jJvcE+kNb7gu3Gdu
# yYsRtYQUigAZcIN5kZeR1BonvzceMgfYFGM8KEyvAgMBAAGjggEmMIIBIjAOBgNV
# HQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn
# 4tcc1sfwf8hnU6AwHwYDVR0jBBgwFoAUj/BLf6guRSSuTVD6Y5qL3uLdG7wwPgYI
# KwYBBQUHAQEEMjAwMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2ln
# bi5jb20vcm9vdHIzMDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
# c2lnbi5jb20vcm9vdC1yMy5jcmwwRwYDVR0gBEAwPjA8BgRVHSAAMDQwMgYIKwYB
# BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMA0G
# CSqGSIb3DQEBDAUAA4IBAQBJrF7Fg/Nay2EqTZdKFSmf5BSQqgn5xHqfNRiKCjMV
# bXKHIk5BP20Knhiu2+Jf/JXRLJgUO47B8DZZefONgc909hik5OFoz+9/ZVlC6cpV
# ObzTxSbucTj61yEDD7dO2VtgakO0fQnQYGHdqu0AXk4yHuCybJ48ssK7mNOQdmpp
# rRrcqInaWE/SwosySs5U+zjpOwcLdQoR2wt8JSfxrCbPEVPm3MbiYTUy9M7dg+MZ
# OuvCaKNyAMgkPE64UzyxF6vmNSz500Ip5l9gA6xCYaaxV2ozQt81MYbKPjcr2sTa
# JPVOEvK2ubdH6rsgrWEWt6Az4y2Jp7yzPAF/IxqACTTpMIIGWTCCBEGgAwIBAgIN
# AewckkDe/S5AXXxHdDANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxT
# aWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
# R2xvYmFsU2lnbjAeFw0xODA2MjAwMDAwMDBaFw0zNDEyMTAwMDAwMDBaMFsxCzAJ
# BgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
# bG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAtIFNIQTM4NCAtIEc0MIICIjANBgkq
# hkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA8ALiMCP64BvhmnSzr3WDX6lHUsdhOmN8
# OSN5bXT8MeR0EhmW+s4nYluuB4on7lejxDXtszTHrMMM64BmbdEoSsEsu7lw8nKu
# jPeZWl12rr9EqHxBJI6PusVP/zZBq6ct/XhOQ4j+kxkX2e4xz7yKO25qxIjw7pf2
# 3PMYoEuZHA6HpybhiMmg5ZninvScTD9dW+y279Jlz0ULVD2xVFMHi5luuFSZiqgx
# kjvyen38DljfgWrhsGweZYIq1CHHlP5CljvxC7F/f0aYDoc9emXr0VapLr37WD21
# hfpTmU1bdO1yS6INgjcZDNCr6lrB7w/Vmbk/9E818ZwP0zcTUtklNO2W7/hn6gi+
# j0l6/5Cx1PcpFdf5DV3Wh0MedMRwKLSAe70qm7uE4Q6sbw25tfZtVv6KHQk+JA5n
# Jsf8sg2glLCylMx75mf+pliy1NhBEsFV/W6RxbuxTAhLntRCBm8bGNU26mSuzv31
# BebiZtAOBSGssREGIxnk+wU0ROoIrp1JZxGLguWtWoanZv0zAwHemSX5cW7pnF0C
# TGA8zwKPAf1y7pLxpxLeQhJN7Kkm5XcCrA5XDAnRYZ4miPzIsk3bZPBFn7rBP1Sj
# 2HYClWxqjcoiXPYMBOMp+kuwHNM3dITZHWarNHOPHn18XpbWPRmwl+qMUJFtr1eG
# fhA3HWsaFN8CAwEAAaOCASkwggElMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8E
# CDAGAQH/AgEAMB0GA1UdDgQWBBTqFsZp5+PLV0U5M6TwQL7Qw71lljAfBgNVHSME
# GDAWgBSubAWjkxPioufi1xzWx/B/yGdToDA+BggrBgEFBQcBAQQyMDAwLgYIKwYB
# BQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjYwNgYDVR0f
# BC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXI2LmNy
# bDBHBgNVHSAEQDA+MDwGBFUdIAAwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cu
# Z2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDQYJKoZIhvcNAQEMBQADggIBAH/i
# iNlXZytCX4GnCQu6xLsoGFbWTL/bGwdwxvsLCa0AOmAzHznGFmsZQEklCB7km/fW
# pA2PHpbyhqIX3kG/T+G8q83uwCOMxoX+SxUk+RhE7B/CpKzQss/swlZlHb1/9t6C
# yLefYdO1RkiYlwJnehaVSttixtCzAsw0SEVV3ezpSp9eFO1yEHF2cNIPlvPqN1eU
# kRiv3I2ZOBlYwqmhfqJuFSbqtPl/KufnSGRpL9KaoXL29yRLdFp9coY1swJXH4uc
# /LusTN763lNMg/0SsbZJVU91naxvSsguarnKiMMSME6yCHOfXqHWmc7pfUuWLMwW
# axjN5Fk3hgks4kXWss1ugnWl2o0et1sviC49ffHykTAFnM57fKDFrK9RBvARxx0w
# xVFWYOh8lT0i49UKJFMnl4D6SIknLHniPOWbHuOqhIKJPsBK9SH+YhDtHTD89szq
# SCd8i3VCf2vL86VrlR8EWDQKie2CUOTRe6jJ5r5IqitV2Y23JSAOG1Gg1GOqg+ps
# cmFKyfpDxMZXxZ22PLCLsLkcMe+97xTYFEBsIB3CLegLxo1tjLZx7VIh/j72n585
# Gq6s0i96ILH0rKod4i0UnfqWah3GPMrz2Ry/U02kR1l8lcRDQfkl4iwQfoH5DZSn
# ffK1CfXYYHJAUJUg1ENEvvqglecgWbZ4xqRqqiKbMIIGZTCCBE2gAwIBAgIQAYTT
# qM43getX9P2He4OusjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJCRTEZMBcG
# A1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBUaW1l
# c3RhbXBpbmcgQ0EgLSBTSEEzODQgLSBHNDAeFw0yMTA1MjcxMDAwMTZaFw0zMjA2
# MjgxMDAwMTVaMGMxCzAJBgNVBAYTAkJFMRkwFwYDVQQKDBBHbG9iYWxTaWduIG52
# LXNhMTkwNwYDVQQDDDBHbG9iYWxzaWduIFRTQSBmb3IgTVMgQXV0aGVudGljb2Rl
# IEFkdmFuY2VkIC0gRzQwggGiMA0GCSqGSIb3DQEBAQUAA4IBjwAwggGKAoIBgQDi
# opu2Sfs0SCgjB4b9UhNNusuqNeL5QBwbe2nFmCrMyVzvJ8bsuCVlwz8dROfe4Qjv
# BBcAlZcM/dtdg7SI66COm0+DuvnfXhhUagIODuZU8DekHpxnMQW1N3F8en7YgWUz
# 5JrqsDE3x2a0o7oFJ+puUoJY2YJWJI3567MU+2QAoXsqH3qeqGOR5tjRIsY/0p04
# P6+VaVsnv+hAJJnHH9l7kgUCfSjGPDn3es33ZSagN68yBXeXauEQG5iFLISt5SWG
# fHOezYiNSyp6nQ9Zeb3y2jZ+Zqwu+LuIl8ltefKz1NXMGvRPi0WVdvKHlYCOKHm6
# /cVwr7waFAKQfCZbEYtd9brkEQLFgRxmaEveaM6dDIhhqraUI53gpDxGXQRR2z9Z
# C+fsvtLZEypH70sSEm7INc/uFjK20F+FuE/yfNgJKxJewMLvEzFwNnPc1ldU01dg
# nhwQlfDmqi8Qiht+yc2PzlBLHCWowBdkURULjM/XyV1KbEl0rlrxagZ1Pok3O5EC
# AwEAAaOCAZswggGXMA4GA1UdDwEB/wQEAwIHgDAWBgNVHSUBAf8EDDAKBggrBgEF
# BQcDCDAdBgNVHQ4EFgQUda8nP7jbmuxvHO7DamT2v4Q1sM4wTAYDVR0gBEUwQzBB
# BgkrBgEEAaAyAR4wNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
# bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADCBkAYIKwYBBQUHAQEEgYMwgYAw
# OQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzdHNh
# Y2FzaGEzODRnNDBDBggrBgEFBQcwAoY3aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
# LmNvbS9jYWNlcnQvZ3N0c2FjYXNoYTM4NGc0LmNydDAfBgNVHSMEGDAWgBTqFsZp
# 5+PLV0U5M6TwQL7Qw71lljBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmds
# b2JhbHNpZ24uY29tL2NhL2dzdHNhY2FzaGEzODRnNC5jcmwwDQYJKoZIhvcNAQEL
# BQADggIBADiTt301iTTqGtaqes6NhNvhNLd0pf/YXZQ2JY/SgH6hZbGbzzVRXdug
# S273IUAu7E9vFkByHHUbMAAXOY/IL6RxziQzJpDV5P85uWHvC8o58y1ejaD/TuFW
# ZB/UnHYEpERcPWKFcC/5TqT3hlbbekkmQy0Fm+LDibc6oS0nJxjGQ4vcQ6G2ci0/
# 2cY0igLTYjkp8H0o0KnDZIpGbbNDHHSL3bmmCyF7EacfXaLbjOBV02n6d9FdFLmW
# 7JFFGxtsfkJAJKTtQMZl+kGPSDGc47izF1eCecrMHsLQT08FDg1512ndlaFxXYqe
# 51rCT6gGDwiJe9tYyCV9/2i8KKJwnLsMtVPojgaxsoKBhxKpXndMk6sY+ERXWBHL
# 9pMVSTG3U1Ah2tX8YH/dMMWsUUQLZ6X61nc0rRIfKPuI2lGbRJredw7uMhJgVgyR
# nViPvJlX8r7NucNzJBnad6bk7PHeb+C8hB1vw/Hb4dVCUYZREkImPtPqE/QonK1N
# ereiuhRqP0BVWE6MZRyz9nXWf64PhIAvvoh4XCcfRxfCPeRpnsuunu8CaIg3EMJs
# JorIjGWQU02uXdq4RhDUkAqK//QoQIHgUsjyAWRIGIR4aiL6ypyqDh3FjnLDNiIZ
# 6/iUH7/CxQFW6aaA6gEdEzUH4rl0FP2aOJ4D0kn2TOuhvRwU0uOZMIIGhTCCBW2g
# AwIBAgITTgAAG0hbiu4stI3Y4wADAAAbSDANBgkqhkiG9w0BAQsFADBZMRowGAYK
# CZImiZPyLGQBGRYKY2FuYS1ncm91cDEZMBcGCgmSJomT8ixkARkWCWNhbmFncm91
# cDEgMB4GA1UEAxMXY2FuYWdyb3VwLVZDQU5BQ0EtMDItQ0EwHhcNMjEwOTA5MTQ0
# ODE0WhcNMjIwOTA5MTQ0ODE0WjCBlDEaMBgGCgmSJomT8ixkARkWCmNhbmEtZ3Jv
# dXAxGTAXBgoJkiaJk/IsZAEZFgljYW5hZ3JvdXAxGTAXBgNVBAsTEENBTkEgR3Jv
# dXAgVXNlcnMxGzAZBgNVBAsTEkNBTkEgTGltaXRlZCBVc2VyczELMAkGA1UECxMC
# SVQxFjAUBgNVBAMTDUp1c3RpbiBIb2xtZXMwggEiMA0GCSqGSIb3DQEBAQUAA4IB
# DwAwggEKAoIBAQDdgYeAgkom43rkexED8c9fOK3fFGcZnNewNYjg/Q2LJA+kFKaF
# WSr2U0hRcKSIssDZrUsBFEN0RQXlskQufFUPHYHJ5RnsHGqPh+7GGAvRi3Uzmme/
# AuI2uhAaQ2+nSneCLrI9KNmb2nHCDNTkYFlhRbwtYV2c609/F++zQTiDJkuZhrmV
# A17PJdpaYUCHD66TeWVIKow38pI/y2eXSOFTjkq5ctN5Efm7TwDFiYXUOzx7t8TB
# fRvJDz71IliEUVhGffnIURRPb/GM/SdqRWA8lfzzHxDvGH3PGLv+7gz3bnm3ZJLo
# d64OXJqSF6g3CDUyvDAHAebd8Ll3wX++NyM5AgMBAAGjggMIMIIDBDALBgNVHQ8E
# BAMCB4AwPQYJKwYBBAGCNxUHBDAwLgYmKwYBBAGCNxUIgpSHfILYwxuC3Y8nhLzj
# EIeB3VeBVYT1wxW741wCAWQCAQYwHQYDVR0OBBYEFOvNWiAxBrBVY2MdR7lRkbHX
# ACiNMB8GA1UdIwQYMBaAFDfpaj+f5dFD+PBTr+HMQScVzro/MIIBOwYDVR0fBIIB
# MjCCAS4wggEqoIIBJqCCASKGgc1sZGFwOi8vL0NOPWNhbmFncm91cC1WQ0FOQUNB
# LTAyLUNBKDMpLENOPXZDQU5BQ0EtMDIsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUy
# MFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9Y2FuYWdy
# b3VwLERDPWNhbmEtZ3JvdXA/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNl
# P29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hlBodHRwOi8vdkNBTkFD
# QS0wMi5jYW5hZ3JvdXAuY2FuYS1ncm91cC9DZXJ0RW5yb2xsL2NhbmFncm91cC1W
# Q0FOQUNBLTAyLUNBKDMpLmNybDCB0gYIKwYBBQUHAQEEgcUwgcIwgb8GCCsGAQUF
# BzAChoGybGRhcDovLy9DTj1jYW5hZ3JvdXAtVkNBTkFDQS0wMi1DQSxDTj1BSUEs
# Q049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmln
# dXJhdGlvbixEQz1jYW5hZ3JvdXAsREM9Y2FuYS1ncm91cD9jQUNlcnRpZmljYXRl
# P2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTATBgNVHSUE
# DDAKBggrBgEFBQcDAzAbBgkrBgEEAYI3FQoEDjAMMAoGCCsGAQUFBwMDMDAGA1Ud
# EQQpMCegJQYKKwYBBAGCNxQCA6AXDBVKdXN0aW4uSG9sbWVzQGNhbmEuY2EwDQYJ
# KoZIhvcNAQELBQADggEBAFtRfZ3MLepukyv4u4aw8i2QjuquSnE5sxR+9BBiEapI
# +kr86qx2dAEJMPyx1ioOXvRv+whYpplaLVrRjmh0qkpBAbbBe5MC5PDrx7BrSKXC
# Eu9d8rEgVZXcuWvC5i1T7fFDWtd47DWCpF5RbNMOag9CniW9oMvs7U9Sq7XfDzwb
# BynfBgaL+ikrNb3z8lH9DvKwTvG3GLRQEETKV/ekNQVezsrFr58H4SQUKKIBiteB
# DHin0flaEyjEtBodCWUvzsn5HoCV7owLMYtn8lu50S9afhsDDgFLZjKmS0qI+P43
# PjBmVt0g67UxTYebjFkdudpgfIfp4QJ8mvOEcHeAA1QxggVdMIIFWQIBATBwMFkx
# GjAYBgoJkiaJk/IsZAEZFgpjYW5hLWdyb3VwMRkwFwYKCZImiZPyLGQBGRYJY2Fu
# YWdyb3VwMSAwHgYDVQQDExdjYW5hZ3JvdXAtVkNBTkFDQS0wMi1DQQITTgAAG0hb
# iu4stI3Y4wADAAAbSDANBglghkgBZQMEAgEFAKBMMBkGCSqGSIb3DQEJAzEMBgor
# BgEEAYI3AgEEMC8GCSqGSIb3DQEJBDEiBCDP/e5VJG5Q7jh+D/PhrdX9RLEPzFa5
# yeaQYqqB86DDuDANBgkqhkiG9w0BAQEFAASCAQACnS+O/++BQiIEZT3DYVb6nPE/
# qF5aEKxourmUv6G3/Cua3LWfLTjfdLdcNFPV4UsLbTw9P1Yw1DC5L1QdDom9KTXp
# eBJMeX+pD2rzEJYbtrADvrggj5vb5b0yGNxT7aWdv4TncPK5xZQbVHsGLpIVOlZi
# kWYb6WLjAm0gh1gCwPxqnjm9ktYYijkcpMHHM6mSrbR4kmVKV5131zFOYrmQjTXW
# YSAUtV7UsxV/xbV/I0exdTPii073GGgdZwCvDVGCMIZ+c+kV5YMKVXrhY1WINuXZ
# 2De94TMP6JD0XqNqQtGqdvKoa0rHQwfZKAvGUGyfTc8uTtoR2DtxzA1NFqG4oYID
# cDCCA2wGCSqGSIb3DQEJBjGCA10wggNZAgEBMG8wWzELMAkGA1UEBhMCQkUxGTAX
# BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gVGlt
# ZXN0YW1waW5nIENBIC0gU0hBMzg0IC0gRzQCEAGE06jON4HrV/T9h3uDrrIwDQYJ
# YIZIAWUDBAIBBQCgggE/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
# hvcNAQkFMQ8XDTIxMTAyNTE2NDU0NVowLQYJKoZIhvcNAQk0MSAwHjANBglghkgB
# ZQMEAgEFAKENBgkqhkiG9w0BAQsFADAvBgkqhkiG9w0BCQQxIgQgdh6qhkM8TKmt
# rj1S25RTuhDFXap23odlSUUMIh5M2nswgaQGCyqGSIb3DQEJEAIMMYGUMIGRMIGO
# MIGLBBTdV7WzhzyGGynGrsRzGvvojXXBSTBzMF+kXTBbMQswCQYDVQQGEwJCRTEZ
# MBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBU
# aW1lc3RhbXBpbmcgQ0EgLSBTSEEzODQgLSBHNAIQAYTTqM43getX9P2He4OusjAN
# BgkqhkiG9w0BAQsFAASCAYC7iGkZRLp9tP4o7lgIQIN9fhwmpPL/ci55q+veJQB/
# EojQ+/F3nMgoLyQmy/ElF4dO3e3B5zEZYkTTmaPvpCSB5mWbn4nFkSEcFCVL2MlV
# Ii2DZDK8W+bWZAuO4Tb+kA5YrETq03ftewR8R//O05W7J0sr38KAzCYk0Ds3oRH4
# YzOm8fb048EugdbKAyI2wlg29s057gi81fOEscJBJmT0jsH2pDWTnlsw97WDqHGn
# LLGPspdA6dntss8WJMP5ZwTmDBGVHlE2t4wwAS2+eZbKhU4ZLhUMWIllSg1Yowh5
# Ewc2dpNIE8ZEP1Ppv/Oiexvma9XdpYjX2AxD1sFQpw5BgOJ6XTUrO10cwC3q0fBV
# ooX+9eK3+CppCaWF/Sb/+DH5kb6+gOkGoXt6fO3fs1bklZ1stugPjGoKluadh511
# lT7E7WzaM+yBqaMo3ezCIRKV4f5MXwG6GMa0n0H0f3UVekEVnvj1z74VoR1zsLHl
# Cj0O0lCpXbC2bo4i1XbHAUI=
# SIG # End signature block