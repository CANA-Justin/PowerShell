<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.159
	 Created on:   	03/14/2019 11:32 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	Exchange-SPFFailWarning.ps1
	===========================================================================
	.DESCRIPTION
		This Exchange rule will give a visual indication that the senders email server failed an SPF check.

	.LINK
		https://blogs.perficient.com/2016/04/04/office-365-providing-your-users-visual-cues-about-email-safety/
#>

New-TransportRule -Name "T004: SPF Validation" -Priority 1 -Comments "Message triggered by this rule were sent from an email address whoes server failed an SPF check" -HeaderContainsMessageHeader "Authentication-Results" -HeaderContainsWords "spf=TempError", "spf=PermError", "spf=None", "spf=Neutral", "spf=SoftFail", "spf=Fail" -ApplyHtmlDisclaimerLocation "Prepend" -ApplyHtmlDisclaimerText "WARNING: The sender of this email could not be validated and may not match the person in the ""From"" field."
