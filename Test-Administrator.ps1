## Script to check if the current user has admin rights
## Passing a $TRUE vaule to the verable $VERBOSE will cause the positive acknowledgment to be printed
## A failed check of Admin rights will print a negitive acknowledgment and exit the script
##
## Auther Justin Holmes Jan 2019

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

## This is what will run if the fuction passes
10..0 | ForEach{"Launch in T minus $_";start-sleep -sec 1};"Blast-off!"
