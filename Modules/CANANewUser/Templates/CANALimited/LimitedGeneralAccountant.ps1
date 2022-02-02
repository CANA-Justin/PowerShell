<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.159
	 Created on:   	10/27/2020 11:27 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	LimitedGeneralAccountant.ps1
	===========================================================================
	.SYNOPSIS
		Adds the user to the groups defined in this function Add-LimitedGeneralAccountant
	
	.DESCRIPTION
		Adds the user to the groups defined in this function Add-LimitedGeneralAccountant
#>


function Add-LimitedGeneralAccountant
{
<#
	.SYNOPSIS
		Adds the user to the groups defined in this function
	
	.DESCRIPTION
		Adds the user to the groups defined in this function
	

		Acct.CANA Utilities.AP
		Acct.CANA Utilities.AR
		Acct.CANA Utilities.Equipment
		Acct.CANA Utilities.Finan Acct
		Acct.CANA Utilities.Proj Acct
		Acct.CANA.AP
		Acct.CANA.AR
		Acct.CANA.Equipment
		Acct.CANA.Proj Acct
		Acct.InterCo.AP
		Acct.InterCo.AR
		Acct.InterCo.Acct Manuals
		Acct.InterCo.Proj Acct
		Acct.OtherCo.AP
		Acct.Purchase Journals
		Acct.SDC
		Acct_Users
		Ace_Sec
		Head Office Users
		All Users
		CANA Construction Accounting
		CANA Construction Accounts Receivable
		CANA FWC Users
		All CANA Limited Users
		SP_Accounting_Staff
		SW_Spreadsheet_Server
		SW_Viewpoint_Users
		Salaried Employees
		Viewpoint Users
		Vista Viewpoint Users
		XenApp75_Print_Acct_2ndFL
		XenApp75_Users
		XenApp75_Viewpoint_Prod
		XenApp_BO
		Xenappusers.deleted
		tfa.Accounting.AccountingHandbook.Read
		tfa.Accounting.CANA.AP.RWED
		tfa.Accounting.CANA.AR.RWED
		tfa.Accounting.CANA.Equipment.Read
		tfa.Accounting.CANA.FinanAccounting.RWED
		tfa.Accounting.CANA.ProjAcct.RWED
		tfa.Accounting.CANAUtilties.AP.RWED
		tfa.Accounting.CANAUtilties.AR.RWED
		tfa.Accounting.CANAUtilties.Equipment.RWED
		tfa.Accounting.CANAUtilties.FinanAcct.RWED
		tfa.Accounting.CANAUtilties.ProjAcct.RWED
		tfa.Accounting.InterCo.AP.RWED
		tfa.Accounting.InterCo.AR.RWED
		tfa.Accounting.InterCo.AccountingManuals.RWED
		tfa.Accounting.InterCo.ProjAcct.RWED
		tfa.Accounting.OtherCo.AP.RWED
		tfa.Accounting.OtherCo.AR.RWED
		tfa.Accounting.OtherCo.EFT.RWED
		tfa.Accounting.OtherCo.Equipment.RWED
		tfa.Accounting.OtherCo.FinanAcct.RWED
		tfa.Accounting.OtherCo.PR.RWED
		tfa.Accounting.OtherCo.ProjAcct.RWED
		tfa.Accounting.RWED
		tfa.Accounting.Read
		tfa.Accounting.SalesJournals.RWED
		tfa.Accouting.AccountingHandbook.Read
		tfa.CHVAccounting.RWED
		tfa.CHVPivot9.RWED
		tfa.CHVPivot9.Read
		tfa.Finance.AP-CANA.RWED
		tfa.Finance.AP-Other.RWED
		tfa.Finance.Audit.RWED
		tfa.Finance.Banking.RWED
		tfa.Finance.Forms.RWED
		tfa.Finance.GenAcct.RWED
		tfa.Finance.Projects.RWED
		tfa.Finance.Reports.RWED
		tfa.Finance.Statements.RWED
		tfa.Finance.Tax.RWED
		tfa.Utilities.Project.RWED
		tfa.Utilities.RWED
		tfa.Utilities.Read
		tfa.Utilities.Scans.RWED
		VPN_Access
		Drive J - Business
		Password.Policy.NonExpire
	
	.EXAMPLE
				PS C:\> Add-LimitedGeneralAccountant $Username
	
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
	
	$ADGroups.add('141GeneralAccountant') | Out-Null
	$ADGroups.add('151ProjectAccountant') | Out-Null
	$ADGroups.add('161APCoordinator') | Out-Null
	$ADGroups.add('171ARCoordinator') | Out-Null
	$ADGroups.add('181AccountingAssistant') | Out-Null
	$ADGroups.add('331Purchaser') | Out-Null
	$ADGroups.add('Acct') | Out-Null
	$ADGroups.add('Acct.CANA Utilities.AP') | Out-Null
	$ADGroups.add('Acct.CANA Utilities.AR') | Out-Null
	$ADGroups.add('Acct.CANA Utilities.Equipment') | Out-Null
	$ADGroups.add('Acct.CANA Utilities.Finan Acct') | Out-Null
	$ADGroups.add('Acct.CANA Utilities.Proj Acct') | Out-Null
	$ADGroups.add('Acct.CANA.AP') | Out-Null
	$ADGroups.add('Acct.CANA.AR') | Out-Null
	$ADGroups.add('Acct.CANA.Controller') | Out-Null
	$ADGroups.add('Acct.CANA.Equipment') | Out-Null
	$ADGroups.add('Acct.CANA.Finan Acct') | Out-Null
	$ADGroups.add('Acct.CANA.Proj Acct') | Out-Null
	$ADGroups.add('Acct.CANA.Proj Status') | Out-Null
	$ADGroups.add('Acct.InterCo.Acct Manuals') | Out-Null
	$ADGroups.add('Acct.InterCo.Administration') | Out-Null
	$ADGroups.add('Acct.InterCo.AP') | Out-Null
	$ADGroups.add('Acct.InterCo.AR') | Out-Null
	$ADGroups.add('Acct.InterCo.Proj Acct') | Out-Null
	$ADGroups.add('Acct.OtherCo.AP') | Out-Null
	$ADGroups.add('Acct.Purchase Journals') | Out-Null
	$ADGroups.add('Acct.Sales Journals') | Out-Null
	$ADGroups.add('Acct.SDC') | Out-Null
	$ADGroups.add('Acct_CANAFin') | Out-Null
	$ADGroups.add('Acct_Fin') | Out-Null
	$ADGroups.add('Acct_Mgr') | Out-Null
	$ADGroups.add('Acct_OtherCo') | Out-Null
	$ADGroups.add('Acct_PayrollTransfer_RW') | Out-Null
	$ADGroups.add('Acct_Shepard') | Out-Null
	$ADGroups.add('Acct_Simpson') | Out-Null
	$ADGroups.add('Acct_Users') | Out-Null
	$ADGroups.add('Ace_DR_Sec') | Out-Null
	$ADGroups.add('Ace_Sec') | Out-Null
	$ADGroups.add('All CANA Limited Users') | Out-Null
	$ADGroups.add('All iOS Users') | Out-Null
	$ADGroups.add('All Users') | Out-Null
	$ADGroups.add('CANA Account Receivable') | Out-Null
	$ADGroups.add('CANA Construction Accounting') | Out-Null
	$ADGroups.add('CANA Construction Accounts Receivable') | Out-Null
	$ADGroups.add('CANA Construction Weekly Report') | Out-Null
	$ADGroups.add('CANA Energy PMs') | Out-Null
	$ADGroups.add('CANA FWC Users') | Out-Null
	$ADGroups.add('CANA General Accountants') | Out-Null
	$ADGroups.add('CANA Reception Access') | Out-Null
	$ADGroups.add('CANA Safety - WCB Compliance') | Out-Null
	$ADGroups.add('CANA Utilities Accounts Receivable') | Out-Null
	$ADGroups.add('CANA Utilities Billing') | Out-Null
	$ADGroups.add('CANA Utilities Deposits') | Out-Null
	$ADGroups.add('CANA_DSMM_Sec') | Out-Null
	$ADGroups.add('Drive J - Business') | Out-Null
	$ADGroups.add('Est_Sec') | Out-Null
	$ADGroups.add('Group_29e2416e-1de0-4c3d-b872-ee854f35f79d') | Out-Null
	$ADGroups.add('Group_6a5360d7-588a-4517-88e6-6afeaa84824e') | Out-Null
	$ADGroups.add('Group_72cfbe34-a7c8-484e-89d5-da430a1aef19') | Out-Null
	$ADGroups.add('Group_8e1f56bb-d2fd-4f7e-8e47-100991a8c4e8') | Out-Null
	$ADGroups.add('Group_93de2978-a0b9-4a82-b98e-9217cc0be563') | Out-Null
	$ADGroups.add('Group_c85485a6-c9fd-4197-a594-eddf1d38ea13') | Out-Null
	$ADGroups.add('Group_ca1695da-fc36-4690-b371-6e8ca25d5f1b') | Out-Null
	$ADGroups.add('Group_dc9cb2ca-00ca-4d32-b07b-02c967ba5fbc') | Out-Null
	$ADGroups.add('Group_f2499731-360e-434d-9aec-45eef1850dab') | Out-Null
	$ADGroups.add('Head Office Users') | Out-Null
	$ADGroups.add('Iphone Users') | Out-Null
	$ADGroups.add('Mbx.Reception') | Out-Null
	$ADGroups.add('Monthly Forecast') | Out-Null
	$ADGroups.add('Off Boarding - Construction') | Out-Null
	$ADGroups.add('Off Boarding - Energy') | Out-Null
	$ADGroups.add('Off Boarding - Limited') | Out-Null
	$ADGroups.add('Off Boarding - Services') | Out-Null
	$ADGroups.add('Password.Policy.NonExpire') | Out-Null
	$ADGroups.add('PBI_ACC') | Out-Null
	$ADGroups.add('PBI_GA') | Out-Null
	$ADGroups.add('PF_Accounting_AP_Permissions') | Out-Null
	$ADGroups.add('PF_Accounting_POReceiving_Permission') | Out-Null
	$ADGroups.add('PF_Accounting_SubcontractAP_Permissions') | Out-Null
	$ADGroups.add('portal.Procore') | Out-Null
	$ADGroups.add('Salaried Employees') | Out-Null
	$ADGroups.add('SP.Accounting.General') | Out-Null
	$ADGroups.add('SP.All.Construction.R') | Out-Null
	$ADGroups.add('SP_Accounting_General') | Out-Null
	$ADGroups.add('SP_Accounting_Staff') | Out-Null
	$ADGroups.add('SP_Construction_CRM_Read') | Out-Null
	$ADGroups.add('stfa.CCCLProjectJobs.RWED') | Out-Null
	$ADGroups.add('stfa.CHVProjectJobs.JobNumber.RWED') | Out-Null
	$ADGroups.add('stfa.Energy.Engineering.READ') | Out-Null
	$ADGroups.add('stfa.Energy.Regulatory.RWED') | Out-Null
	$ADGroups.add('SW_HFF_TEST') | Out-Null
	$ADGroups.add('SW_Spreadsheet_Server') | Out-Null
	$ADGroups.add('SW_Viewpoint_Test') | Out-Null
	$ADGroups.add('SW_Viewpoint_Users') | Out-Null
	$ADGroups.add('tfa.Accounting.AccountingHandbook.Read') | Out-Null
	$ADGroups.add('tfa.Accounting.Budgets.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.CANA.AP.Read') | Out-Null
	$ADGroups.add('tfa.Accounting.CANA.AP.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.CANA.AR.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.CANA.Equipment.Read') | Out-Null
	$ADGroups.add('tfa.Accounting.CANA.FinanAccounting.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.CANA.ProjAcct.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.CANAUtilties.AP.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.CANAUtilties.AR.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.CANAUtilties.Equipment.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.CANAUtilties.FinanAcct.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.CANAUtilties.PR.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.CANAUtilties.ProjAcct.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.InterCo.AccountingManuals.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.InterCo.Administration.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.InterCo.AP.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.InterCo.AR.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.InterCo.ProjAcct.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.OtherCo.AP.Read') | Out-Null
	$ADGroups.add('tfa.Accounting.OtherCo.AP.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.OtherCo.AR.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.OtherCo.EFT.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.OtherCo.Equipment.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.OtherCo.FinanAcct.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.OtherCo.PR.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.OtherCo.ProjAcct.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.Read') | Out-Null
	$ADGroups.add('tfa.Accounting.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.SalesJournals.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.SDC.AP.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.SDC.AR.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.SDC.FinanAcct.Read') | Out-Null
	$ADGroups.add('tfa.Accounting.SDC.FinanAcct.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.SDC.ProjAcct.RWED') | Out-Null
	$ADGroups.add('tfa.Accounting.SDC.ScannedDeposits.RWED') | Out-Null
	$ADGroups.add('tfa.Accouting.AccountingHandbook.Read') | Out-Null
	$ADGroups.add('tfa.CHVAccounting.RWED') | Out-Null
	$ADGroups.add('tfa.CHVPivot9.Read') | Out-Null
	$ADGroups.add('tfa.CHVPivot9.RWED') | Out-Null
	$ADGroups.add('tfa.CHVProjectJobs.JobNumber.RWED') | Out-Null
	$ADGroups.add('tfa.CHVProjectJobs.RWED') | Out-Null
	$ADGroups.add('tfa.Energy.Administrative.READ') | Out-Null
	$ADGroups.add('tfa.Energy.Procurement.READ') | Out-Null
	$ADGroups.add('tfa.Energy.ProjectControls.RWED') | Out-Null
	$ADGroups.add('tfa.Energy.READ') | Out-Null
	$ADGroups.add('tfa.Energy.RWED') | Out-Null
	$ADGroups.add('tfa.Estimating.DSMM.RWED') | Out-Null
	$ADGroups.add('tfa.Estimating.RWED') | Out-Null
	$ADGroups.add('tfa.Finance.AP-CANA.RWED') | Out-Null
	$ADGroups.add('tfa.Finance.AP-Other.RWED') | Out-Null
	$ADGroups.add('tfa.Finance.Audit.RWED') | Out-Null
	$ADGroups.add('tfa.Finance.Banking.RWED') | Out-Null
	$ADGroups.add('tfa.Finance.Forecasts.RWED') | Out-Null
	$ADGroups.add('tfa.Finance.Forms.RWED') | Out-Null
	$ADGroups.add('tfa.Finance.GenAcct.RWED') | Out-Null
	$ADGroups.add('tfa.Finance.Projects.RWED') | Out-Null
	$ADGroups.add('tfa.Finance.Reports.RWED') | Out-Null
	$ADGroups.add('tfa.Finance.Statements.RWED') | Out-Null
	$ADGroups.add('tfa.Finance.Tax.RWED') | Out-Null
	$ADGroups.add('tfa.Shared.ApprenticeshipFinance.RWED') | Out-Null
	$ADGroups.add('tfa.Utilities.Project.RWED') | Out-Null
	$ADGroups.add('tfa.Utilities.Read') | Out-Null
	$ADGroups.add('tfa.Utilities.RWED') | Out-Null
	$ADGroups.add('tfa.Utilities.Scans.RWED') | Out-Null
	$ADGroups.add('tfa.UtilitiesDR.Read') | Out-Null
	$ADGroups.add('tfa.UtilitiesDR.RWED') | Out-Null
	$ADGroups.add('Viewpoint Users') | Out-Null
	$ADGroups.add('Vista Viewpoint Users') | Out-Null
	$ADGroups.add('VPN_Access') | Out-Null
	$ADGroups.add('XenApp75_Bluebeam_Revu12') | Out-Null
	$ADGroups.add('XenApp75_Print_Acct_2ndFL') | Out-Null
	$ADGroups.add('Xenapp75_SpreadsheetServer') | Out-Null
	$ADGroups.add('XenApp75_Users') | Out-Null
	$ADGroups.add('XenApp75_Viewpoint_Prod') | Out-Null
	$ADGroups.add('XenApp_BO') | Out-Null
	
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
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDjzmZfsfIPJNgv
# unJ99etf0acvpHtQyot2APAp7BYAWKCCJAYwggNfMIICR6ADAgECAgsEAAAAAAEh
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
# BgEEAYI3AgEEMC8GCSqGSIb3DQEJBDEiBCD5CaP/4bphav6AMLEyhf5w6Z9VjAj4
# 8QKy6aXfit5+3zANBgkqhkiG9w0BAQEFAASCAQAL5RQyfHBTJ0Uy4rYOxa5b0tkZ
# 8P+JEjINUO+cFAqn4thrXroAl2wJt6ISEq7Ybh9BHikFwiRS9Qhdrxa9ZaS49rw3
# YDCjH0zi3Gtts1RyByP+zoS0aA92Fm14Nn5gTmOhVlVlXr07R98YVUt7LDbFrfzF
# u0qTNuLiLxy55t027vJaIboai2Z9JkEiPJcPas7FnUJoJ7dtg3/yWYe955Kz+rIA
# tMY6ng84mE4GW4+A3p9mBY7olG/HF75taJlQdQq9WzwKVxEf98GSYUC6cOzjhlwm
# TDrtuCnfO4rEd7Wtb65ef4H/MfACeO7qqP/yKfv3RunRIBs3LWAZh0Jberl/oYID
# cDCCA2wGCSqGSIb3DQEJBjGCA10wggNZAgEBMG8wWzELMAkGA1UEBhMCQkUxGTAX
# BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gVGlt
# ZXN0YW1waW5nIENBIC0gU0hBMzg0IC0gRzQCEAGE06jON4HrV/T9h3uDrrIwDQYJ
# YIZIAWUDBAIBBQCgggE/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
# hvcNAQkFMQ8XDTIxMTAyNzE2MzY0MVowLQYJKoZIhvcNAQk0MSAwHjANBglghkgB
# ZQMEAgEFAKENBgkqhkiG9w0BAQsFADAvBgkqhkiG9w0BCQQxIgQgk8VvpqUdiNmI
# Zdvr+qbLJx91uBDLA57pqe3ZsiQox+swgaQGCyqGSIb3DQEJEAIMMYGUMIGRMIGO
# MIGLBBTdV7WzhzyGGynGrsRzGvvojXXBSTBzMF+kXTBbMQswCQYDVQQGEwJCRTEZ
# MBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBU
# aW1lc3RhbXBpbmcgQ0EgLSBTSEEzODQgLSBHNAIQAYTTqM43getX9P2He4OusjAN
# BgkqhkiG9w0BAQsFAASCAYDh36seGKt1RP3hPiQrnhpds/DUdkatebN/2qHZnVO/
# ScTzixTDN8okPBOghcGyOxlGU2kZbV5oH5Fb4MhJO4R0JoE37hpz7iIHugwxWPiL
# HjsKUaaZelwdXfAtdu0Iw+uFx6aGAL0U6wacqOduu5stMjY2G7JY5c8T728ZX4oY
# H0nc4xMG5UXO/sGdu71hZvHQmQfCLGh/eBWmQ5BIXVdkGNsgIm3+FfC9Z+eYPTpt
# rs0r240mYt8wb3MnPZuvD9AN3q4FCKg2XEAd54ZY39ev9GHTXQB2rw7r34QAcSR/
# cTzYMV53CSc+f/L0aHM7qGy+Hj4rYkmIDAiWbOqQPjWdkkjkwEXXRj2JpGlDht8K
# KiNoFBPY0A/11Va3r7drlml9svimW45gJTlAq0/xJqvWAn62LKv9IXBZrX+D+nGu
# xqPbTMtu1EnmGcclhnG/tHftEpQ1rmCNCbuoxmB1lzTjC0ywtq9Eo3J8Qwz9h1RA
# 82i8mrckS8oCWSPpHAugOg4=
# SIG # End signature block
