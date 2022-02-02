<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2021 v5.8.190
	 Created on:   	06/08/2021 2:06 PM
	 Created by:   	admJustin
	 Organization: 	
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>


$RegUninstallPaths = @(
	'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
	'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
)

$VersionsToKeep = @('Java 8 Update 261')

Get-CimInstance -ClassName 'Win32_Process' | Where-Object { $_.ExecutablePath -like '*Program Files\Java*' } |
Select-Object @{ n = 'Name'; e = { $_.Name.Split('.')[0] } } | Stop-Process -Force

Get-process -Name *iexplore* | Stop-Process -Force -ErrorAction SilentlyContinue

$UninstallSearchFilter = { ($_.GetValue('DisplayName') -like '*Java*') -and (($_.GetValue('Publisher') -eq 'Oracle Corporation')) -and ($VersionsToKeep -notcontains $_.GetValue('DisplayName')) }

# Uninstall unwanted Java versions and clean up program files

foreach ($Path in $RegUninstallPaths)
{
	if (Test-Path $Path)
	{
		Get-ChildItem $Path | Where-Object $UninstallSearchFilter |
		foreach {
			
			Start-Process 'C:\Windows\System32\msiexec.exe' "/X$($_.PSChildName) /qn" -Wait
			
		}
	}
}

New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
$ClassesRootPath = "HKCR:\Installer\Products"
Get-ChildItem $ClassesRootPath |
Where-Object { ($_.GetValue('ProductName') -like '*Java*') } | Foreach {
	Remove-Item $_.PsPath -Force -Recurse
}

$JavaSoftPath = 'HKLM:\SOFTWARE\JavaSoft'
if (Test-Path $JavaSoftPath)
{
	Remove-Item $JavaSoftPath -Force -Recurse
}
