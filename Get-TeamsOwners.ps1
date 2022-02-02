<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2021 v5.8.196
	 Created on:   	01/04/2022 3:18 PM
	 Created by:   	admJustin
	 Organization: 	
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>



# Connect to Microsoft Teams
Connect-MicrosoftTeams
# Get all the teams from tenant
$teamColl = Get-Team

# Loop through the teams
foreach ($team in $teamColl)
{
	Write-Host -ForegroundColor Magenta "Getting all the owners from Team: " $team.DisplayName
	
	# Get the team owners
	$ownerColl = Get-TeamUser -GroupId $team.GroupId -Role Owner
	
	#Loop through the owners
	foreach ($owner in $ownerColl)
	{
		Write-Host -ForegroundColor Yellow "User ID: " $owner.UserId " User: " $owner.User " Name: " $owner.Name
	}
}