<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2021 v5.8.188
	 Created on:   	05/11/2021 10:52 AM
	 Created by:   	admJustin
	 Organization: 	
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

#-----
# Administrative
#
Write-Verbose "Removing Inheritance from R:\Energy-MP\Energy-Shared\Administrative"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative /inheritance:r /t /q
Write-Verbose "Granting permission for mfa.AllFolders.Full to R:\Energy-MP\Energy-Shared\Administrative with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative /T /Q /Grant "mfa.AllFolders.Full:(CI)(OI)(F)"
Write-Verbose "Granting permission for SVCEnergyMFA to R:\Energy-MP\Energy-Shared\Administrative with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative /T /Q /Grant "SVCEnergyMFA:(CI)(OI)(F)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative with (CI)(OI)(RX)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative /T /Q /Grant "tfa.Energy.Administrative.READ:(CI)(OI)(RX)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Company Policies\Active with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\"Company Policies"\Active /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Company Policies\Archived with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\"Company Policies"\Archived /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Company Policies\Information with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\"Company Policies"\Information /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Company Policies\Archived with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\"Company Policies"\Pending /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Company Procedures\Active with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\"Company Procedures"\Active /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Company Procedures\Archived with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\"Company Procedures"\Archived /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Company Procedures\Information with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\"Company Procedures"\Information /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Company Procedures\Archived with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\"Company Procedures"\Pending /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Company Templates\Active with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\"Company Templates"\Active /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Company Templates\Archived with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\"Company Templates"\Archived /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Company Templates\Information with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\"Company Templates"\Information /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Company Templates\Archived with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\"Company Templates"\Pending /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Marketing Materials\Active with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\"Marketing Materials"\Active /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Marketing Materials\Archived with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\"Marketing Materials"\Archived /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Marketing Materials\Information with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\"Marketing Materials"\Information /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Marketing Materials\Archived with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\"Marketing Materials"\Pending /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Standards\Active with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\Standards\Active /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Standards\Archived with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\Standards\Archived /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Standards\Information with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\Standards\Information /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Administrative\Standards\Archived with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Administrative\Standards\Pending /Q /Grant "tfa.Energy.Administrative.RWED:(CI)(OI)(M)"

