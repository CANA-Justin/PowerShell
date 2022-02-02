<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.159
	 Created on:   	03/14/2019 11:32 AM
	 Created by:   	Justin Holmes
	 Organization: 	CANA IT
	 Filename:     	Exchange-ExternalEmailWarning.ps1
	===========================================================================
	.DESCRIPTION
		This Exchange rule will give a visual indication that the senders email server failed an SPF check.

	.LINK
		https://blogs.perficient.com/2016/04/04/office-365-providing-your-users-visual-cues-about-email-safety/
#>

New-TransportRule -Name "T003: Outside organization sender" -Priority 0 -Comments "Message triggered by this rule were sent from an email address from outside CANA" -FromScope "NotInOrganization" -ApplyHtmlDisclaimerLocation "Prepend" -ApplyHtmlDisclaimerText "<div style=""background-color:#FFEB9C; width:100%; border-style: solid; border-color:#9C6500; border-width:1pt; padding:2pt; font-size:10pt; line-height:12pt; font-family:'Calibri'; color:Black; text-align: left;""><span style=""color:#9C6500; font-weight:bold;"">CAUTION:</span> This email originated from outside of the organization.  Do not click links or open attachments unless you recognize the sender and know the content is safe.</div><br>"
