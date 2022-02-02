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
$ShareName="IT Storage"

#Set the discription for the Share
$ShareDiscription="IT Storage"

#Set the Source path
$SourcePath="E:\IT Storage"

#Set destination path
$DestinationPath="R:\IT Storage"

#Log location path
$LogLocation="R:\Logs\$ShareName.txt"

#Set file server name
$FileServer="VCANAFILE-01"

#Set the FQDN
$FQDN="canagroup.cana-group"

#Set the DFS Root
$DFSRoot="business"

#Do you want the job to run Verbose?
$verbose=$true

##---------------------------------------------##
## Do not edit below this point
##---------------------------------------------##

#Setting varable to Null
$TransferMode=$null

#Setting varable to agrument
$TransferMode=$args[0]

Write-Verbose "Listing current verables"
Write-Verbose "ShareName = $ShareName"
Write-Verbose "ShareDiscription = $ShareDiscription"
Write-Verbose "SourcePath = $SourcePath"
Write-Verbose "DestinationPath = $DestinationPath"
Write-Verbose "LogLocation = $LogLocation"
Write-Verbose "FileServer = $FileServer"
Write-Verbose "FQDN = $FQDN"
Write-Verbose "DFSRoot = $DFSRoot"
Write-Verbose "verbose = $verbose"
Write-Verbose "TransferMode = $TransferMode"
Write-Verbose "Line Arguments = $args[0] $args[1] $args[2] $args[3]"

#Checking for administrator privileges as running user
function Test-Administrator  
{  Write-Verbose "Running function Test-Administrator"

    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
    
    Write-Verbose  "function Test-Administrator done."
}

## If PASSED administrator privileges check
If (Test-Administrator -eq $True) {
	If ($verbose -eq $True)
        {Write-Verbose "Running user does have administrator privileges!"
        Check-Arguments
        }
    }
 ## If FAILED administrator privileges check
 Else { Write-Verbose "Failed administrator privileges check"
        Write-host "Running user" -NoNewline
        Write-host " Does Not " -ForegroundColor Red -NoNewline
        Write-host "have administrator privileges!"
        Write-host "Operation is aborting!"
        Check-Arguments
        Write-Verbose "Exiting"
        #Exit
        
        }

function Check-Arguments
    {

If ($TransferMode -eq $null) {
Write-Verbose "TransferMode was $TransferMode"
Write-Host "Would you like to do a Pre-Copy or a Final Copy?"
read-host "Enter PRE or FINAL" 
"PRE","FINAL" -notcontains $TEMPString
Check-Arguments

}
ElseIf ($TransferMode -eq "PRE")
        {Pre-Transfer}

ElseIf ($TransferMode -eq "FINAL")
        {Final-Transfer}

ElseIf ($TEMPString -eq $True)
        {Write-host "I did not understand your answer"
        Write-host "I was expecting PRE or FINAL"
        Write-host "You gave me $TransferMode"
        Write-host "Please try again"
        $TransferMode=$null
        Check-Arguments
        }
         

    }


function Pre-Transfer
{

#TEMP

Write-Host "I would run Pre-Transfer"

#Write-Verbose "Running robocopy of $SourcePath to $DestinationPath.  Logs written to $ROBOCOPYLOG" 
#Write-Verbose "This is the Pre-Transfer copy. This might take a long time..."
#$ROBOCOPYOPTIONS = @("/e","/zb","/r:1","/w:1","/copyall","/v") | out-null ## Robocopy is dumb and will only accept verables for everything, or nothing
#$ROBOCOPYLOG = "/log:R:\Logs\$ShareName.txt"                   | out-null ## Setting the varables for the switches and logfile location
#robocopy "$SourcePath" "$DestinationPath" $ROBOCOPYOPTIONS $ROBOCOPYLOG | out-null # Running robocopy
#Write-host "Done Pre-Transfer.  To review logs, look in $ROBOCOPYLOG"
#Exit
}


function Final-Transfer
{

#TEMP

Write-Host "I would run Pre-Transfer"


#Remove-SmbShare -Name $ShareName  -Confirm:$false | out-null #Removes the share from windows, forces confirm
#Write-Verbose "Removing Share $ShareName" 
#Set-DfsnFolderTarget -Path "\\$FQDN\$DFSRoot\$ShareName" -TargetPath "\\$FileServer\$ShareName" -State Offline | out-null # Offlining the DFS share, but leaving it intact
#Write-Verbose "Disabling DFS Share \\$FQDN\$DFSRoot\$ShareName" 
#$ROBOCOPYOPTIONS = @("/e","/zb","/r:1","/w:1","/copyall","/v") | out-null ## Robocopy is dumb and will only accept verables for everything, or nothing
#$ROBOCOPYLOG = "/log:R:\Logs\$ShareName.txt"                   | out-null ## Setting the varables for the switches and logfile location
#robocopy "$SourcePath" "$DestinationPath" $ROBOCOPYOPTIONS $ROBOCOPYLOG | out-null # Running robocopy
#Write-Verbose "Running robocopy of $SourcePath to $DestinationPath.  Logs written to $ROBOCOPYLOG" 
#New-SmbShare -Name $ShareName -Path $DestinationPath -Description $ShareDiscription -Confirm:$false | out-null # Recreating the new shares
#Write-Verbose "Creating Share $ShareName" 
#Grant-SmbShareAccess –Name $ShareName –AccountName Everyone –AccessRight Full -Force | out-null # Setting the Share permissions to Everyone Full
#Write-Verbose "Setting Share $ShareName access to Everyone to Full" 
#Set-DfsnFolderTarget -Path "\\$FQDN\$DFSRoot\$ShareName" -TargetPath "\\$FileServer\$ShareName" -State Online | out-null # Setting the DFS share to online
#Write-Verbose "Enabling DFS Share \\$FQDN\$DFSRoot\$ShareName" 
}