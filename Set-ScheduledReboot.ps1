<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2021 v5.8.194
	 Created on:   	09/07/2021 12:12 PM
	 Created by:   	Justin Holmes
	 Organization: 	CANA
	 Filename:     	Set-ScheduledReboot
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

$server = Read-Host "Servers Name (use Server01, Server02 for multi-server)"
$time = Read-Host "What time? (21:00:00 format)"
$date = Read-Host "What Date? (12/31/2032 format)"
$login = Get-Credential -Message "Enter your ADM login for PowerShell Remoting"

Enter-PSSession $server -Credential $login
Invoke-Command -ComputerName $server -ScriptBlock { schtasks /create /tn "Scheduled Reboot" /tr "shutdown /r /t 0" /sc once /st $time /sd $date /ru "System" }
Exit-PSSession
