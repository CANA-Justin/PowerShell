<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2020 v5.7.180
	 Created on:   	09/04/2020 8:48 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	Get-ClusterStorageVolumeFreeSpace.ps1
	===========================================================================
	.DESCRIPTION
		This script will monitor the available free space on the Cluster Shared Volumes and if they fall below a set threshold it will send a webhook alert or an email.
		You can call this in the task scheduler of a cluster node member.
		Script modified from https://gallery.technet.microsoft.com/scriptcenter/Monitor-Cluster-Shared-21de7554/file/201113/1/Get-ClusterStorageVolumeFreeSpace.ps1
#>

param (
	[Parameter(ParameterSetName = 'webhook')]
	[switch]$webhook,
	[Parameter(ParameterSetName = 'webhook', Mandatory = $false)]
	[string]$Uri,
	[Parameter(ParameterSetName = 'email')]
	[switch]$Email,
	[Parameter(ParameterSetName = 'minfree')]
	[int]$MinFree,
	[Parameter(ParameterSetName = 'email', Mandatory = $false)]
	[string]$smtpServer = 'mail.cana.ca',
	[Parameter(ParameterSetName = 'email', Mandatory = $false)]
	[int]$smtpPort = '25',
	[Parameter(ParameterSetName = 'email', Mandatory = $false)]
	[string]$mailFrom = 'helpdesk@cana.ca',
	[Parameter(ParameterSetName = 'email', Mandatory = $false)]
	[string]$mailTo = 'justin.holmes@cana.ca',
	[Parameter(ParameterSetName = 'email', Mandatory = $false)]
	[string]$subject = '[Warning] CSV Free Space is low'
)

<#  
.Synopsis  
   Checks the available space on cluster Shared Volumes and sends an alert if free space is below set threshold.  
.DESCRIPTION  
   Riccardo Toni: 2018/06/27  
   Version 1.1  
   Checks free CSV space and sends a webhook or email alert if available space falls below a set threshold.  
.EXAMPLE  
   Run the script as a (elevated) scheduled task on a member node of the Hyper-V Cluster. 
   .\Get-ClusterStorageVolumeFreeSpace.ps1 -WebHook -Uri 'https://webhook.example.com/apikey' 
.EXAMPLE 
    To send an email alert instead of a webhook POST: 
    .\Get-ClusterStorageVolumeFreeSpace.ps1 -Email 
#>

# Percent of freespace on CSV to trigger an alert.  

[int]$MinFree = 10

Import-Module FailoverClusters

$clustername = Get-Cluster

$objs = @()
$CurrentFree = @{ }

$csvs = Get-ClusterSharedVolume
foreach ($csv in $csvs)
{
	$csvinfos = $csv | select -Property Name -ExpandProperty SharedVolumeInfo
	foreach ($csvinfo in $csvinfos)
	{
		$obj = New-Object PSObject -Property @{
			Name = $csv.Name
			Path = $csvinfo.FriendlyVolumeName
			Size = $csvinfo.Partition.Size
			FreeSpace = $csvinfo.Partition.FreeSpace
			UsedSpace = $csvinfo.Partition.UsedSpace
			PercentFree = $csvinfo.Partition.PercentFree
		}
		
		$objs += $obj
		
		if ($webhook)
		{
			# Sends Webhook Alert 
			if ($($obj.PercentFree) -lt $MinFree)
			{
				$notificationPayload = @{ text = "WARNING: Free space on $($obj.Name) CSV is below warning threshold - Current free space: $($obj.PercentFree)%" }
				Invoke-RestMethod -Uri $uri -Method Post -Body (ConvertTo-Json $notificationPayload)
			}
		}
		
		if ($email)
		{
			# Sends Email Alert 
			if ($($obj.PercentFree) -lt $MinFree)
			{
				
				$body = "<b>Current free space: $($obj.PercentFree)% </b>on $($obj.Name) CSV"
				$body += "<br></br>"
				$body += "WARNING: Free space on $($obj.Name) CSV is below warning threshold."
				
				Send-MailMessage -From $mailFrom -Subject $subject -To $mailTo -SmtpServer $smtpServer -Port $smtpPort -Body $body -BodyAsHtml
				
			}
			
		}
	}
}


# SIG # Begin signature block
# MIIcugYJKoZIhvcNAQcCoIIcqzCCHKcCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCB0fvUuP0VGjLZ6
# AIiYG1TAfYJPgwS0KRuyJG60N9gVX6CCF2owggOwMIICmKADAgECAhBz0HdolQdJ
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
# CSqGSIb3DQEJBDEiBCDi6N/An2pSLyazpKJ9ICjGal2IzGiaL/QNltYGzAD0xzAN
# BgkqhkiG9w0BAQEFAASCAQB3sHj/BEFI5MsYejnub6BzmGO1FmjlcfqSx71GGvtP
# zbrrO4pmNv5aKAJ8vvddf5p6NMV8S4iq3ptTsAplSLUJLP9eLGnRel8oiLJ3bPKp
# /xnQN8HXsb9ZQlbStqpmYfvJ85MUZ7p9UNaKlz5LaLeSSNRWN/ndM48VAVXQMNUY
# 7jmH46A9V9ca2myIGQcblU3G1tPUMaPOjvlDlFAsGUvSr/28rwgo0Fxb5xWv23Mt
# TGJkcxislTEG/cmSlPyUhNg5hkr79Y01jo4x0EiRZbIwjP5c+JZLD23TqBWJRHB2
# kmFlxKknu3cPuJ5Dy5Zb6s8Fgqa53aoC/ojmuHVtWvzqoYICuTCCArUGCSqGSIb3
# DQEJBjGCAqYwggKiAgEBMGswWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2Jh
# bFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gVGltZXN0YW1waW5nIENB
# IC0gU0hBMjU2IC0gRzICDCRUuH8eFFOtN/qheDANBglghkgBZQMEAgEFAKCCAQww
# GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjAwOTA0
# MjE0NTI1WjAvBgkqhkiG9w0BCQQxIgQgg5nNd6BeMyFGWLoZJbNstsTGe+ikYwba
# NIZplA4Fyz8wgaAGCyqGSIb3DQEJEAIMMYGQMIGNMIGKMIGHBBQ+x2bV1NRy4hsf
# IUNSHDG3kNlLaDBvMF+kXTBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFs
# U2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0Eg
# LSBTSEEyNTYgLSBHMgIMJFS4fx4UU603+qF4MA0GCSqGSIb3DQEBAQUABIIBAFLV
# O68vID63V6B3McCmiUq39iEGgUcoKZiAjTgi5adOcO5GVO83mUv28smfEcolYFA0
# 1FdjrRpOugCiq9soLE92w/kBSSodJGlqIwQJr+k2U1T8UJS1vw3FEYc6DrcyZ/HG
# w/z2EwSOaZqOLzEedNqzmeuiOPnBfnyN64R4oM8ESEpCCkCtFwWFw+KhHlmry9jL
# HQH5t8FKTvyd6dFXHxK8w5By9DbLvTa+wvFdmK4JWV7xsPJjKjfqpv3cnPPzqjYb
# iDiefEd67kH3gT1uQQqJ/kQUgT+cDrcWB7n2hVDI/5/cUXerJXjJ3tKC7hJAxDDe
# t6xYeoTe33zX5C7kApY=
# SIG # End signature block
