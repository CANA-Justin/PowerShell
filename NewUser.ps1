<#	
	.NOTES
	===========================================================================
	 Created on:   	02/19/2019 11:58 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	NewUser.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

$GivenName="Dan"
$FirstName="Justin"
$SirName="Van Holmes"
$UserName
$namecheck



function Write-InVerboseMode
{
	[CmdletBinding()]
	Param
	(
		[parameter(Position = 0, Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[String]$text
	)
	Process
	{
		Write-Verbose $text
	}
}

#This function will take the $FirstName & #SirName and convert it to the username SirName+First Letter of First Name#
function MakeUsername ()
{
	
	[CmdletBinding()]
	PARAM ()
	Write-Debug "Given name is $($GivenName)"
	Write-Debug "First name is $($FirstName)"
	Write-Debug "Last name is $($SirName)"
	Write-Debug "User name is $($UserName)"
	
	$UserName = $SirName + $FirstName.substring(0, 1)
	
	Write-Debug "User name is now $($UserName)"
	Write-Verbose "User name is now $($UserName)"
	Write-Debug "Moving to function ValidateUserName"

}

#This function will check the username for whitespace or dashs.  White space will be removed, dashs just throw an information warning (as requested)#
function ValidateUserName {

	$UserName = $UserName.ToLower()
	if ($UserName -match "\s") { write-verbose "This User Name contains a white space" }
	if ($UserName -match "-") { Write-Information "The User Name $($UserName) contains a dash" }
	Write-Verbose $UserName
	
	$UserName = $UserName -replace '(\s)', ''
	
	Write-Verbose $UserName
	

}

#This function will check if the $UserName exists.  If it does it will add the 2nd letter from the $FirstName to the end of the $UserName#
function CheckUserName ()
{

	
try
	{
		$namecheck  = get-aduser -filter { samaccountname -like $UserName }
	}
	catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
	{ }
	
	if ($namecheck.Enabled -eq $true)
	{
		Write-Verbose "$UserName is in use"
		$UserName = $SirName + $FirstName.substring(0, 2)
		Write-Verbose "trying username $UserName"
		ValidateUserName
		
	}
	
	else
	{
		Write-Verbose "$UserName is avalable"
	}
	
}



