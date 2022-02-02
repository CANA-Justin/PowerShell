& icacls.exe R:\Fleet-MP\Fleet-Shared /inheritance:r
& icacls.exe R:\Fleet-MP\Fleet-Shared /T /GRANT "mfa.AllFolders.Full:(CI)(OI)(F)"
& icacls.exe R:\Fleet-MP\Fleet-Shared /GRANT "tfa.fleet.READ:(CI)(OI)(F)"
& icacls.exe R:\Fleet-MP\Fleet-Shared\Administration /inheritance:r
& icacls.exe R:\Fleet-MP\Fleet-Shared\Administration /GRANT "tfa.Fleet.Administration.RWED:(OI)(CI)(M)"
& icacls.exe R:\Fleet-MP\Fleet-Shared\Administration /GRANT "tfa.Fleet.Administration.READ:(OI)(CI)(RX)"
& icacls.exe "R:\Fleet-MP\Fleet-Shared\Driver Management" /inheritance:r
& icacls.exe "R:\Fleet-MP\Fleet-Shared\Driver Management" /GRANT "tfa.fleet.drivermanagment.RWED:(OI)(CI)(M)"
& icacls.exe "R:\Fleet-MP\Fleet-Shared\Driver Management" /GRANT "tfa.fleet.drivermanagment.READ:(OI)(CI)(RX)"
& icacls.exe "R:\Fleet-MP\Fleet-Shared\Shop Warehouse" /inheritance:r
& icacls.exe "R:\Fleet-MP\Fleet-Shared\Shop Warehouse" /GRANT "tfa.fleet.shopwarehouse.RWED:(OI)(CI)(M)"
& icacls.exe "R:\Fleet-MP\Fleet-Shared\Shop Warehouse" /GRANT "tfa.fleet.shopwarehouse.READ:(OI)(CI)(RX)"
& icacls.exe "R:\Fleet-MP\Fleet-Shared\General Fleet" /inheritance:r
& icacls.exe "R:\Fleet-MP\Fleet-Shared\General Fleet" /GRANT "tfa.fleet.RWED:(OI)(CI)(M)"
& icacls.exe "R:\Fleet-MP\Fleet-Shared\General Fleet" /GRANT "tfa.fleet.READ:(OI)(CI)(RX)"