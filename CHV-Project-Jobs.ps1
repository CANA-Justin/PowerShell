## This script will turn off access to a share, robocopy the files to the new location,
## then turn the share back on.
## The share security is reset to Everyone Full, the folder secureity is not changed
## as robocopy will copy all the NTFS ACLs over to the destination.
##
## Auther: Justin Holmes Jan 2019


##---------------------------------------------##
## Edit these varables for your job
##---------------------------------------------##
#Set the Share name.  This assumes the source and destination share are the same
$ShareName="CHV-Project-Jobs"

#Set the discription for the Share
$ShareDiscription="CHV-Project-Jobs"

#Set the Source path
$SourcePath="H:\Project-Jobs"

#Set destination path
$DestinationPath="R:\CHV-Project-Jobs"

#Set file server name
$FileServer="VCANAFILE-01"

#Set the FQDN
$FQDN="canagroup.cana-group"

#Set the DFS Root
$DFSRoot="business"

#Do you want the job to run Verbose?
$verbose=$false

##---------------------------------------------##
## Do not edit below this point
##---------------------------------------------##

function Test-Administrator  
{  
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
}

## If PASSED administrator privileges check
If (Test-Administrator -eq $True) {
	If ($verbose -eq $True)
        {    
        Write-host "Running user" -NoNewline
        Write-host " Does " -ForegroundColor Green -NoNewline
        Write-host "have administrator privileges!"}
    }
 ## If FAILED administrator privileges check
 Else {Write-host "Running user" -NoNewline
        Write-host " Does Not " -ForegroundColor Red -NoNewline
        Write-host "have administrator privileges!"
        Write-host "Operation is aborting!"
        
        Exit
        
        }


Remove-SmbShare -Name $ShareName  -Confirm:$false #Removes the share from windows, forces confirm
Set-DfsnFolderTarget -Path "\\$FQDN\$DFSRoot\$ShareName" -TargetPath "\\$FileServer\$ShareName" -State Offline # Offlining the DFS share, but leaving it intact
$ROBOCOPYOPTIONS = @("/e","/zb","/r:1","/w:1","/copyall","/v") ## Robocopy is dumb and will only accept verables for everything, or nothing
$ROBOCOPYLOG = "/log:R:\Logs\$ShareName.txt"                   ## Setting the varables for the switches and logfile location
robocopy "$SourcePath" "$DestinationPath" $ROBOCOPYOPTIONS $ROBOCOPYLOG # Running robocopy
New-SmbShare -Name $ShareName -Path $DestinationPath -Description $ShareDiscription -Confirm:$false # Recreating the new shares
Grant-SmbShareAccess –Name $ShareName –AccountName Everyone –AccessRight Full -Force; # Setting the Share permissions to Everyone Full
Set-DfsnFolderTarget -Path "\\$FQDN\$DFSRoot\$ShareName" -TargetPath "\\$FileServer\$ShareName" -State Online # Setting the DFS share to online
