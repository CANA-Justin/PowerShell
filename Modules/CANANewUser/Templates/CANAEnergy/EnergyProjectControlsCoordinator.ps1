<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.167
	 Created on:   	08/28/2019 10:13 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	EnergyProjectControlsCoordinator.ps1
	===========================================================================
.SYNOPSIS
Adds the user to the groups defined in this function Add-EnergyProjectControlsCoordinator

.DESCRIPTION
Adds the user to the groups defined in this function Add-EnergyProjectControlsCoordinator
#>


function Add-EnergyProjectControlsCoordinator
{
	<#
	.SYNOPSIS
		Adds the user to the groups defined in this function
	
	.DESCRIPTION
		Adds the user to the groups defined in this function


	
	.EXAMPLE
				PS C:\> Add-EnergyProjectControlsCoordinator $Username
	
	.NOTES
		Using an array and a foreach loop, the listed AD groups are added to the users group membership.  This file is expected to be imported in to the overall module to allow flexibility for adding new rolls, or modifying existing ones without having to modify the core script or module.
#>
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
	
	$ADGroups.add('Ace_EmpCerts_R_Sec') | Out-Null
	$ADGroups.add('Ace_EquipCerts_R_Sec') | Out-Null
	$ADGroups.add('Ace_Sec') | Out-Null
	$ADGroups.add('All Manager Services Users') | Out-Null
	$ADGroups.add('All Users') | Out-Null
	$ADGroups.add('CANA Energy PMs') | Out-Null
	$ADGroups.add('CANA Energy Project Controls') | Out-Null
	$ADGroups.add('All CANA Energy Users') | Out-Null
	$ADGroups.add('Drive J - Business') | Out-Null
	$ADGroups.add('Head Office Users') | Out-Null
	$ADGroups.add('Mbx.Locates') | Out-Null
	$ADGroups.add('Password.Policy.NonExpire') | Out-Null
	$ADGroups.add('SP.Energy.Safety.Notifications') | Out-Null
	$ADGroups.add('SP_Energy_Foremen') | Out-Null
	$ADGroups.add('SP_Energy_Staff') | Out-Null
	$ADGroups.add('SP_Managers_All') | Out-Null
	$ADGroups.add('stfa.CHVProjectJobs.JobNumber.RWED') | Out-Null
	$ADGroups.add('stfa.Energy.Archive.RWED') | Out-Null
	$ADGroups.add('stfa.Energy.Engineering.READ') | Out-Null
	$ADGroups.add('stfa.Energy.Regulatory.RWED') | Out-Null
	$ADGroups.add('stfa.Utilities.Project.RWED') | Out-Null
	$ADGroups.add('SW_Viewpoint_Users') | Out-Null
	$ADGroups.add('SW_Viewpoint_Users') | Out-Null
	$ADGroups.add('tfa.CHVCommon.Read') | Out-Null
	$ADGroups.add('tfa.CHVDrawingManagement.Read') | Out-Null
	$ADGroups.add('tfa.CHVDWGScans.Read') | Out-Null
	$ADGroups.add('tfa.CHVEngineering.Read') | Out-Null
	$ADGroups.add('tfa.CHVManual.Read') | Out-Null
	$ADGroups.add('tfa.CHVProjectJobs.JobNumber.RWED') | Out-Null
	$ADGroups.add('tfa.CHVProjectJobs.RWED') | Out-Null
	$ADGroups.add('tfa.Energy.Administrative.RWED') | Out-Null
	$ADGroups.add('tfa.Energy.Procurement.READ') | Out-Null
	$ADGroups.add('tfa.Energy.ProjectControls.Read') | Out-Null
	$ADGroups.add('tfa.Energy.ProjectControls.RWED') | Out-Null
	$ADGroups.add('tfa.Shared.CHVCUSharedFolder.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.CUTemplates.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.CUWeeklyMeetings.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.Divisions.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.Estimate.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.Project.2012.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.Project.Estimate.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.Project.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.ProjectSummaries&References.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.Purchasing.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.Scans.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.StructureandStandardsManualPlusMaps.Read') | Out-Null
	$ADGroups.add('Viewpoint Users') | Out-Null
	$ADGroups.add('Vista Viewpoint Reviewers') | Out-Null
	$ADGroups.add('Vista Viewpoint Users') | Out-Null
	$ADGroups.add('VPN_Access') | Out-Null
	$ADGroups.add('XenApp75_Users') | Out-Null
	$ADGroups.add('XenApp75_Viewpoint_Prod') | Out-Null
	
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
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCADnBHJPher1yh9
# yWfB2nZ/DwWqAQHe0sQqPU+fMqRzQqCCJAYwggNfMIICR6ADAgECAgsEAAAAAAEh
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
# AwIBAgITTgAAId6x86WzX82CJwADAAAh3jANBgkqhkiG9w0BAQsFADBZMRowGAYK
# CZImiZPyLGQBGRYKY2FuYS1ncm91cDEZMBcGCgmSJomT8ixkARkWCWNhbmFncm91
# cDEgMB4GA1UEAxMXY2FuYWdyb3VwLVZDQU5BQ0EtMDItQ0EwHhcNMjIwMTE0MjIw
# NjAxWhcNMjMwMTE0MjIwNjAxWjCBlDEaMBgGCgmSJomT8ixkARkWCmNhbmEtZ3Jv
# dXAxGTAXBgoJkiaJk/IsZAEZFgljYW5hZ3JvdXAxGTAXBgNVBAsTEENBTkEgR3Jv
# dXAgVXNlcnMxGzAZBgNVBAsTEkNBTkEgTGltaXRlZCBVc2VyczELMAkGA1UECxMC
# SVQxFjAUBgNVBAMTDUp1c3RpbiBIb2xtZXMwggEiMA0GCSqGSIb3DQEBAQUAA4IB
# DwAwggEKAoIBAQDKBeaopcgYUWNZbfBw/tEYr87ri+t7/A6azRSAwf2Jg2mJD8om
# b/HqvIvHVJrN386kUiGL0Ui1Xx/750aogucHnYYCPpSSQKRvMkFR3FQe9l5jKZ3S
# gVDhQHbVNfebljkpeDy+E3uY0DEfj4FYNzv01XiFezaQEtrcvrwylBhBQ99XEwGA
# mA1sGEf03rg3SbVmQ7UVKobcTMEVwRXz9KGDiXZ0zcV4yqd4xjvlY7XGnlujvoeY
# KGcWreX8Z2faQhn4U197fNE3IUYp1J+CxLkkXdlO0zuR5A9vAURpoZgGUvdYGp6t
# uRDm2Al4sQfnJFYqcrAM16cbagSBhs6jIJ8NAgMBAAGjggMIMIIDBDALBgNVHQ8E
# BAMCB4AwPQYJKwYBBAGCNxUHBDAwLgYmKwYBBAGCNxUIgpSHfILYwxuC3Y8nhLzj
# EIeB3VeBVYT1wxW741wCAWQCAQYwHQYDVR0OBBYEFLPWHFhvxNA2hqSlqe1Crrgb
# priBMB8GA1UdIwQYMBaAFDfpaj+f5dFD+PBTr+HMQScVzro/MIIBOwYDVR0fBIIB
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
# KoZIhvcNAQELBQADggEBAGFeekSQPTQFNDdMzV2HSA+OaLVT+9ABh+ABmy4qBbxZ
# jTVk4sExkaO24zJihqICYnCrVDU4k8MaIoIkQlEIjF5NSXmyCRFHDFayFVTd0k9y
# q3ET0k97BfyiiSoxFfN5Z4x1FJBaJYdZ5/XuctRfOm0TNuYrY2yAEq9Tqr22R0IT
# CHDOd47qBI3lmfjcZIiuzPebV2TTgYI1oikEWxJpZ5AvBxsF5Moy3z709rL//39y
# VwvrV44MWBGH8z9CLq2wxx2tCUUK2hofrZk02nRkAkEU0tdRSMXthsmnQUC7pm86
# 053xF/qbFk9jML6G+tQuUYa4mGBo2GWf7SSc0t8e+JExggVdMIIFWQIBATBwMFkx
# GjAYBgoJkiaJk/IsZAEZFgpjYW5hLWdyb3VwMRkwFwYKCZImiZPyLGQBGRYJY2Fu
# YWdyb3VwMSAwHgYDVQQDExdjYW5hZ3JvdXAtVkNBTkFDQS0wMi1DQQITTgAAId6x
# 86WzX82CJwADAAAh3jANBglghkgBZQMEAgEFAKBMMBkGCSqGSIb3DQEJAzEMBgor
# BgEEAYI3AgEEMC8GCSqGSIb3DQEJBDEiBCBJhQ15lUgLrrG+gN07s9iMou138lB/
# g3xwDZ4Z1fjo5zANBgkqhkiG9w0BAQEFAASCAQAZKtZNJ7UAqZJmdtiA6lbVgv8u
# HqE1jEjK9buGef+LUzZHaNnpRXiErIujnl0W8UjVjer+E3GFqXdGkoI5dLgrcC/W
# ZfOWgeU751WOGjQh0vaVufy11aWIFk2iOy35t1ySny5T8qB+vRSZQv9clseIJqDS
# FVMU73IKjSRurD8ZvUc2TELPrF6mfoQ/fVGjHgyqHRGM7nbsjVqX0Ts5Cxg7mYM6
# sRxXn2c1y2gWNyszpPvWNKVdx0jc7GyQaSX4XE49UsMS2yTztyKTYXC6GSogMIP6
# Z3MpFrfuvEqUslgYi4IPuBVArtSmcYq8GRuM93qMEjs+aJA5hb8naM3QGk52oYID
# cDCCA2wGCSqGSIb3DQEJBjGCA10wggNZAgEBMG8wWzELMAkGA1UEBhMCQkUxGTAX
# BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gVGlt
# ZXN0YW1waW5nIENBIC0gU0hBMzg0IC0gRzQCEAGE06jON4HrV/T9h3uDrrIwDQYJ
# YIZIAWUDBAIBBQCgggE/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
# hvcNAQkFMQ8XDTIyMDExODE3MDkxNFowLQYJKoZIhvcNAQk0MSAwHjANBglghkgB
# ZQMEAgEFAKENBgkqhkiG9w0BAQsFADAvBgkqhkiG9w0BCQQxIgQgjh2RXTdfxGTa
# aYNBgrqwdmdeJ8D51Venyzri1D7cvg0wgaQGCyqGSIb3DQEJEAIMMYGUMIGRMIGO
# MIGLBBTdV7WzhzyGGynGrsRzGvvojXXBSTBzMF+kXTBbMQswCQYDVQQGEwJCRTEZ
# MBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBU
# aW1lc3RhbXBpbmcgQ0EgLSBTSEEzODQgLSBHNAIQAYTTqM43getX9P2He4OusjAN
# BgkqhkiG9w0BAQsFAASCAYDZQgFlk/xOgzgM01cacNk1j94yfxi/G1wdsZ82uPay
# Q2KpctyJv0nzSSkV8CUXOTfOw8XrQaG49lrfxKYeoIRy1cxhbVdUEda4cJ4K1ZOv
# 19GfYC4jh2U00ePx+5OHEHpyMJnq0LRAfM/g4jDMrEN+lxPLrbrgsv4aSf2rEdvf
# S4ZmRn96fZiYIzGe00AcbLu5bZQWlAYBW+NJm1gePYGi/0Ra8eDatAA1mjJG2L1D
# uHAQCEbHdOjCvtQLdPgUsqcqt3ueZdDQBwCEn8I5yfubc3tXgP34Xt1zquwaNHmx
# wWE71jqNdaiDvOVlaAy0a7hYjqdR64ZlI6qkZ2j8Mt3QrYiUk5KpWqLOnPuHeyNo
# HKOg55BchTpNWWz8O9MY07ntWPNE/5v0/QQLHcO4aF6eR16aS7gy3awVhDGprB0j
# Z2tdWBqvxfInfPGgcn7ajJ2TUTSDF94+LMJbwrz24YsDKHsnUq12rHqJSB4ki6uQ
# JRQAMnmmAk962IcMtGy4908=
# SIG # End signature block