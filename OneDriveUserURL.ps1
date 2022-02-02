

if (Get-Module -ListAvailable -Name Microsoft.Online.SharePoint.PowerShell) {
    Write-Host "SharePoint Online module found"
} 
else {
    try {
        Write-Verbose "SharePoint Online module not found"
        Write-Verbose "attempting to install Microsoft.Online.SharePoint.PowerShell"
        Write-Host "SharePoint Online module not found"
        Write-Host "attempting to install Microsoft.Online.SharePoint.PowerShell"
        Install-Module -Name Microsoft.Online.SharePoint.PowerShell -AllowClobber -Confirm:$False -Force  
    }
    catch [Exception] {
        $_.message 
        exit
    }
}

# Connect to SPO
Connect-SPOService -Url https://canagroup-admin.sharepoint.com

# Find Users OneDrive
read-host = enter the users email address
$Filter = "Url -like '-my.sharepoint.com/personal/' -and Owner -eq $UserEmail"
$UsersOneDrive = Get-SPOSite -IncludePersonalSite $True -Limit All -Filter $Filter 
$UsersOneDriveURL = $UsersOneDrive.URL

Write-Output $UsersOneDriveURL