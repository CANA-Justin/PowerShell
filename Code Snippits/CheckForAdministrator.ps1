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
