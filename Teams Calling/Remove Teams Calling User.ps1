$UPNuser = read-host -prompt "Enter UPN"

set-csuser -Identity $UPNuser -EnterpriseVoiceEnabled $False -HostedVoiceMail $False
set-csuser -Identity $UPNuser -OnPremLineURI $null
Grant-CsOnlineVoiceRoutingPolicy -Identity $UPNuser -PolicyName $null
Grant-CsTenantDialPlan -Identity $upnuser -PolicyName $null
