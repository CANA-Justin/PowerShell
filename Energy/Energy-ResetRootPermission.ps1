Set-Location -Path "R:\Energy-MP\Energy-Shared\"

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
#

#-----
#Business Development
#
Write-Verbose "Removing Inheritance from R:\Energy-MP\Energy-Shared\Business Development"
& icacls.exe R:\Energy-MP\Energy-Shared\"Business Development" /inheritance:r /t /q
Write-Verbose "Granting permission for mfa.AllFolders.Full to R:\Energy-MP\Energy-Shared\Business Development with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Business Development" /T /Q /Grant "mfa.AllFolders.Full:(CI)(OI)(F)"
Write-Verbose "Granting permission for SVCEnergyMFA to R:\Energy-MP\Energy-Shared\Business Development with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Business Development" /T /Q /Grant "SVCEnergyMFA:(CI)(OI)(F)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Business Development with (CI)(OI)(RX)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Business Development" /T /Q /Grant "tfa.Energy.BusnessDevelopment.READ:(CI)(OI)(RX)"
#

#-----
#Clients
#
Write-Verbose "Removing Inheritance from R:\Energy-MP\Energy-Shared\Clients"
& icacls.exe R:\Energy-MP\Energy-Shared\Clients /inheritance:r /q
Write-Verbose "Granting permission for mfa.AllFolders.Full to R:\Energy-MP\Energy-Shared\Clients with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\Clients /Q /Grant "mfa.AllFolders.Full:(CI)(OI)(F)"
Write-Verbose "Granting permission for SVCEnergyMFA to R:\Energy-MP\Energy-Shared\Clients with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\Clients /T /Q /Grant "SVCEnergyMFA:(CI)(OI)(F)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Clients with (CI)(OI)(RX)"
& icacls.exe R:\Energy-MP\Energy-Shared\Clients /Q /Grant "tfa.Energy.READ:(CI)(OI)(RX)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Clients with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Clients /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
#

#-----
#Contractor Management Program
#
Write-Verbose "Removing Inheritance from R:\Energy-MP\Energy-Shared\Contractor Management Program"
& icacls.exe R:\Energy-MP\Energy-Shared\"Contractor Management Program" /inheritance:r /q /t
Write-Verbose "Granting permission for mfa.AllFolders.Full to R:\Energy-MP\Energy-Shared\Contractor Management Program with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Contractor Management Program" /T /Q /Grant "mfa.AllFolders.Full:(CI)(OI)(F)"
Write-Verbose "Granting permission for SVCEnergyMFA to R:\Energy-MP\Energy-Shared\Contractor Management Program with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Contractor Management Program" /T /Q /Grant "SVCEnergyMFA:(CI)(OI)(F)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Contractor Management Program with (CI)(OI)(RX)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Contractor Management Program" /T /Q /Grant "tfa.Energy.READ:(CI)(OI)(RX)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Clients with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Contractor Management Program" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
#

#-----
#Field Services
#
Write-Verbose "Removing Inheritance from R:\Energy-MP\Energy-Shared\Field Services"
& icacls.exe R:\Energy-MP\Energy-Shared\"Field Services" /inheritance:r /q /t
Write-Verbose "Granting permission for mfa.AllFolders.Full to R:\Energy-MP\Energy-Shared\Field Services with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Field Services" /T /Q /Grant "mfa.AllFolders.Full:(CI)(OI)(F)"
Write-Verbose "Granting permission for SVCEnergyMFA to R:\Energy-MP\Energy-Shared\Field Services with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Field Services" /T /Q /Grant "SVCEnergyMFA:(CI)(OI)(F)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Field Services with (CI)(OI)(RX)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Field Services" /T /Q /Grant "tfa.Energy.READ:(CI)(OI)(RX)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Field Services\Energy Services with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Field Services"\"Energy Services" /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Field Services\Infrastructure with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Field Services"\Infrastructure /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
#

#-----
#Drafting
#
Write-Verbose "Removing Inheritance from R:\Energy-MP\Energy-Shared\Drafting"
& icacls.exe R:\Energy-MP\Energy-Shared\Drafting /inheritance:r /q /t
Write-Verbose "Granting permission for mfa.AllFolders.Full to R:\Energy-MP\Energy-Shared\Drafting with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\Drafting /T /Q /Grant "mfa.AllFolders.Full:(CI)(OI)(F)"
Write-Verbose "Granting permission for SVCEnergyMFA to R:\Energy-MP\Energy-Shared\Drafting with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\Drafting /T /Q /Grant "SVCEnergyMFA:(CI)(OI)(F)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Drafting with (CI)(OI)(RX)"
& icacls.exe R:\Energy-MP\Energy-Shared\Drafting /T /Q /Grant "tfa.Energy.READ:(CI)(OI)(RX)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Drafting with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Drafting /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
#

#-----
#Engineering
#
Write-Verbose "Removing Inheritance from R:\Energy-MP\Energy-Shared\Engineering"
& icacls.exe R:\Energy-MP\Energy-Shared\Engineering /inheritance:r /q /t
Write-Verbose "Granting permission for mfa.AllFolders.Full to R:\Energy-MP\Energy-Shared\Engineering with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\Engineering /T /Q /Grant "mfa.AllFolders.Full:(CI)(OI)(F)"
Write-Verbose "Granting permission for SVCEnergyMFA to R:\Energy-MP\Energy-Shared\Engineering with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\Engineering /T /Q /Grant "SVCEnergyMFA:(CI)(OI)(F)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Engineering with (CI)(OI)(RX)"
& icacls.exe R:\Energy-MP\Energy-Shared\Engineering /T /Q /Grant "tfa.Energy.READ:(CI)(OI)(RX)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Engineering\Administrative with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Engineering\Administrative /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Engineering\Agencies with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Engineering\Agencies /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Engineering\General Specifications\Active with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Engineering\"General Specifications"\Active /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Engineering\General Specifications\Archived with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Engineering\"General Specifications"\Archived /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Engineering\General Specifications\Information with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Engineering\"General Specifications"\Information /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Engineering\General Specifications\Pending with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Engineering\"General Specifications"\Pending /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Engineering\Guidelines with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Engineering\Guidelines /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Engineering\Programs with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Engineering\Programs /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Engineering\Technical Bulletins with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Engineering\"Technical Bulletins" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Engineering\Technical Information with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Engineering\"Technical Information" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Engineering\Vendor Data with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Engineering\"Vendor Data" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
#

#-----
#Fleet
#
Write-Verbose "Removing Inheritance from R:\Energy-MP\Energy-Shared\Fleet"
& icacls.exe R:\Energy-MP\Energy-Shared\Fleet /inheritance:r /q /t
Write-Verbose "Granting permission for mfa.AllFolders.Full to R:\Energy-MP\Energy-Shared\Fleet with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\Fleet /T /Q /Grant "mfa.AllFolders.Full:(CI)(OI)(F)"
Write-Verbose "Granting permission for SVCEnergyMFA to R:\Energy-MP\Energy-Shared\Fleet with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\Fleet /T /Q /Grant "SVCEnergyMFA:(CI)(OI)(F)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Fleet with (CI)(OI)(RX)"
& icacls.exe R:\Energy-MP\Energy-Shared\Fleet /T /Q /Grant "tfa.Energy.READ:(CI)(OI)(RX)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Fleet with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Fleet /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
#

#-----
#HSE
#
Write-Verbose "Removing Inheritance from R:\Energy-MP\Energy-Shared\HSE"
& icacls.exe R:\Energy-MP\Energy-Shared\HSE /inheritance:r /q /t
Write-Verbose "Granting permission for mfa.AllFolders.Full to R:\Energy-MP\Energy-Shared\HSE with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\HSE /T /Q /Grant "mfa.AllFolders.Full:(CI)(OI)(F)"
Write-Verbose "Granting permission for SVCEnergyMFA to R:\Energy-MP\Energy-Shared\HSE with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\HSE /T /Q /Grant "SVCEnergyMFA:(CI)(OI)(F)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\HSE with (CI)(OI)(RX)"
& icacls.exe R:\Energy-MP\Energy-Shared\HSE /T /Q /Grant "tfa.Energy.READ:(CI)(OI)(RX)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\HSE with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\HSE /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
#

#-----
#Management
#
Write-Verbose "Removing Inheritance from R:\Energy-MP\Energy-Shared\Management"
& icacls.exe R:\Energy-MP\Energy-Shared\Management /inheritance:r /q /t
Write-Verbose "Granting permission for mfa.AllFolders.Full to R:\Energy-MP\Energy-Shared\Management with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\Management /T /Q /Grant "mfa.AllFolders.Full:(CI)(OI)(F)"
Write-Verbose "Granting permission for SVCEnergyMFA to R:\Energy-MP\Energy-Shared\Management with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\Management /T /Q /Grant "SVCEnergyMFA:(CI)(OI)(F)"
Write-Verbose "Granting permission for tfa.Energy.Management.READ to R:\Energy-MP\Energy-Shared\Management with (CI)(OI)(RX)"
& icacls.exe R:\Energy-MP\Energy-Shared\Management /T /Q /Grant "tfa.Energy.Management.READ:(CI)(OI)(RX)"
Write-Verbose "Granting permission for tfa.Energy.Management.RWED to R:\Energy-MP\Energy-Shared\Management\Engineering with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Management\Engineering /T /Q /Grant "tfa.Energy.Management.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.Management.RWED to R:\Energy-MP\Energy-Shared\Management\Energy Services with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Management\"Energy Services" /T /Q /Grant "tfa.Energy.Management.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.Management.RWED to R:\Energy-MP\Energy-Shared\Management\Fleet with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Management\Fleet /T /Q /Grant "tfa.Energy.Management.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.Management.RWED to R:\Energy-MP\Energy-Shared\Management\General with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Management\General /T /Q /Grant "tfa.Energy.Management.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.Management.RWED to R:\Energy-MP\Energy-Shared\Management\Infrastructure with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Management\Infrastructure /T /Q /Grant "tfa.Energy.Management.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.Management.RWED to R:\Energy-MP\Energy-Shared\Management\Project Services with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Management\"Project Services" /T /Q /Grant "tfa.Energy.Management.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.Management.RWED to R:\Energy-MP\Energy-Shared\Management\Safety with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Management\Safety /T /Q /Grant "tfa.Energy.Management.RWED:(CI)(OI)(M)"
#

#-----
#Panel Shop
#
Write-Verbose "Removing Inheritance from R:\Energy-MP\Energy-Shared\Panel Shop"
& icacls.exe R:\Energy-MP\Energy-Shared\"Panel Shop" /inheritance:r /q /t
Write-Verbose "Granting permission for mfa.AllFolders.Full to R:\Energy-MP\Energy-Shared\Panel Shop with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Panel Shop" /T /Q /Grant "mfa.AllFolders.Full:(CI)(OI)(F)"
Write-Verbose "Granting permission for SVCEnergyMFA to R:\Energy-MP\Energy-Shared\Panel Shop with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Panel Shop" /T /Q /Grant "SVCEnergyMFA:(CI)(OI)(F)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Panel Shop with (CI)(OI)(RX)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Panel Shop" /T /Q /Grant "tfa.Energy.READ:(CI)(OI)(RX)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Panel Shop with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Panel Shop" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
#

#-----
#Temporary
#
Write-Verbose "Removing Inheritance from R:\Energy-MP\Energy-Shared\Temporary"
& icacls.exe R:\Energy-MP\Energy-Shared\Temporary /inheritance:r /q /t
Write-Verbose "Granting permission for mfa.AllFolders.Full to R:\Energy-MP\Energy-Shared\Temporary with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\Temporary /T /Q /Grant "mfa.AllFolders.Full:(CI)(OI)(F)"
Write-Verbose "Granting permission for SVCEnergyMFA to R:\Energy-MP\Energy-Shared\Temporary with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\Temporary /T /Q /Grant "SVCEnergyMFA:(CI)(OI)(F)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Temporary with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Temporary /T /Q /Grant "tfa.Energy.READ:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Temporary with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\Temporary /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
#

#-----
#Project Services
#
Write-Verbose "Removing Inheritance from R:\Energy-MP\Energy-Shared\Project Services"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services" /inheritance:r /q /t
Write-Verbose "Granting permission for mfa.AllFolders.Full to R:\Energy-MP\Energy-Shared\Project Services with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services" /T /Q /Grant "mfa.AllFolders.Full:(CI)(OI)(F)"
Write-Verbose "Granting permission for SVCEnergyMFA to R:\Energy-MP\Energy-Shared\Project Services with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services" /T /Q /Grant "SVCEnergyMFA:(CI)(OI)(F)"
Write-Verbose "Granting permission for tfa.Energy.READ to R:\Energy-MP\Energy-Shared\Project Services with (CI)(OI)(RX)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services" /T /Q /Grant "tfa.Energy.READ:(CI)(OI)(RX)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Administrative with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services"\Administrative /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Management Reports with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Management Reports" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Procurement\Subcontractor Management\Subcontractor Prequals with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Procurement\Subcontractor Management\Subcontractor Prequals" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Procurement\Supplier Management\Suppliers Performance with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Procurement\Supplier Management\Suppliers Performance" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Project Controls\Cost Control with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Project Controls\Cost Control" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Project Controls\Internal Report with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Project Controls\Internal Report" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Quality\Archived with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Quality\Archived" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Quality\ISO Standards with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Quality\ISO Standards" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Quality\Quality Forms with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Quality\Quality Forms" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Quality\Quality Manual with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Quality\Quality Manual" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Quality\Quality Policies with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Quality\Quality Policies" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Quality\Quality Procedures with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Quality\Quality Procedures" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Quality\Quality Records with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Quality\Quality Records" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Quality\Work Instructions with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Quality\Work Instructions" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Proposals\Tracking with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Proposals\Tracking" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Proposals\Resource Centre\Photos with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Proposals\Resource Centre\Photos" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Proposals\Resource Centre\Sample Proposals with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Proposals\Resource Centre\Sample Proposals" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Proposals\Resource Centre\Sample Write-up\Experiences-Capabilities with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Proposals\Resource Centre\Sample Write-up\Experiences-Capabilities" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Proposals\Resource Centre\Sample Write-up\Health Safety and Environment with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Proposals\Resource Centre\Sample Write-up\Health Safety and Environment" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Proposals\Resource Centre\Sample Write-up\Personnel with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Proposals\Resource Centre\Sample Write-up\Personnel" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Proposals\Resource Centre\Sample Write-up\Pre-Planning with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Proposals\Resource Centre\Sample Write-up\Pre-Planning" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Proposals\Resource Centre\Sample Write-up\Project Close-Out with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Proposals\Resource Centre\Sample Write-up\Project Close-Out" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Proposals\Resource Centre\Sample Write-up\Project Execution with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Proposals\Resource Centre\Sample Write-up\Project Execution" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"
Write-Verbose "Granting permission for tfa.Energy.RWED to R:\Energy-MP\Energy-Shared\Project Services\Proposals\Resource Centre\Sample Write-up\Quality with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Project Services\Proposals\Resource Centre\Sample Write-up\Quality" /T /Q /Grant "tfa.Energy.RWED:(CI)(OI)(M)"

#-----
#Testing and Commissioning
#

Write-Verbose "Removing Inheritance from R:\Energy-MP\Energy-Shared\Testing and Commissioning"
& icacls.exe R:\Energy-MP\Energy-Shared\"Testing and Commissioning" /inheritance:r /q /t
Write-Verbose "Granting permission for mfa.AllFolders.Full to R:\Energy-MP\Energy-Shared\Testing and Commissioning with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Testing and Commissioning" /T /Q /Grant "mfa.AllFolders.Full:(CI)(OI)(F)"
Write-Verbose "Granting permission for SVCEnergyMFA to R:\Energy-MP\Energy-Shared\Testing and Commissioning with (CI)(OI)(F)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Testing and Commissioning" /T /Q /Grant "SVCEnergyMFA:(CI)(OI)(F)"

Write-Verbose "Granting permission for tfa.Energy.TestingAndCommissioning.READ to R:\Energy-MP\Testing And Commissioning with (CI)(OI)(RX)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Testing And Commissioning" /T /Q /Grant "tfa.Energy.TestingAndCommissioning.READ:(CI)(OI)(RX)"
Write-Verbose "Granting permission for tfa.Energy.TestingAndCommissioning.RWED to R:\Energy-MP\Testing And Commissioning with (CI)(OI)(M)"
& icacls.exe R:\Energy-MP\Energy-Shared\"Testing And Commissioning" /T /Q /Grant "tfa.Energy.TestingAndCommissioning.RWED:(CI)(OI)(M)"

#
# SIG # Begin signature block
# MIIcFQYJKoZIhvcNAQcCoIIcBjCCHAICAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCA0xyLW+umR6pM3
# ahRRgZvVRgk61OnlPaAaPFozRZSE9KCCFsUwggMLMIIB86ADAgECAhAdBzYmM16G
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
# CSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMC8GCSqGSIb3DQEJBDEiBCD79sxic9LG
# x+CVo6YrV5ga1RikcTTW69xQkd34fHwuMTANBgkqhkiG9w0BAQEFAASCAQBXSsgL
# 9Lx18RYmRrg0aX9w2Rrxsl6sNv0+UEgXU9CnAJ6geWZVf6VnxWpxLsMHeqsnHh6G
# nzeKEJTHzx3kDkFUOgI3h6TeUBuoc6HFOuczxK6PtHmte+3eV7320h8BrXK4cibh
# AJz5ZWptnQ7gs2fxjYmAuvvXa6qRLTeANar7WQJV6A5CetPr2Qav4RB2mteJiNqw
# Z1eVb6neEruH3mdgNBW5lZGpc4CSQkqMePkpfPf2jMbuNfPz04PmAKPWghWRl5ZI
# 0lGgzXiTSIIGe8415lkUieMPoQOPTHgmzUgwBWNbaPmA7oMDKrnynRJnAjgMiX3p
# bf8ajqOxpHoh6RyhoYICuTCCArUGCSqGSIb3DQEJBjGCAqYwggKiAgEBMGswWzEL
# MAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMT
# KEdsb2JhbFNpZ24gVGltZXN0YW1waW5nIENBIC0gU0hBMjU2IC0gRzICDCRUuH8e
# FFOtN/qheDANBglghkgBZQMEAgEFAKCCAQwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
# DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkxMTE1MjExMTIxWjAvBgkqhkiG9w0BCQQx
# IgQg8wrAJDgFo3KKmautgEGiC8fJ7gnOyIyvxo7QqmTv3y0wgaAGCyqGSIb3DQEJ
# EAIMMYGQMIGNMIGKMIGHBBQ+x2bV1NRy4hsfIUNSHDG3kNlLaDBvMF+kXTBbMQsw
# CQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMo
# R2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0EgLSBTSEEyNTYgLSBHMgIMJFS4fx4U
# U603+qF4MA0GCSqGSIb3DQEBAQUABIIBALO5bUE5iro2q4UBYfU3EbfotUkV49bd
# +1THXZVu9nOOoRft9MHVNkLrtGsxW89eYdUXnqnK0s5Y+F+9AmLALb30C2fkvq5y
# 7KNgWFZTn2H/VI2jonshotbJ17P5hmMQhF/Aj7hX5lOCbywHzGlTmLMw9SAcjHlN
# rukPsSVPpLmYMYaytfQyRehk75ub6TgzWOfVoUZCV+t0s8/sPK1ElQEyrBqke+yB
# nJfaxAjIsiMxX/A4cj5FTyqCPDAguF2b8AJDLnS+aROmFcKaWDRso5arlNRxrhb+
# xonB7mSKaCFjXeHlLB/+hA+YpzViM92aGWPQNPcwC4sV6n4j0CpPoQs=
# SIG # End signature block
