
$UPNuser = read-host -prompt "Enter UPN"
$phonenumber = read-host -prompt "Enterphone number eg tel:+15555551212"

set-csuser -Identity $UPNuser -EnterpriseVoiceEnabled $true -HostedVoiceMail $true
set-csuser -Identity $UPNuser -OnPremLineURI $phonenumber
Grant-CsOnlineVoiceRoutingPolicy -Identity $UPNuser -PolicyName "DRTeamsLocalVRP"
Grant-CsTenantDialPlan -Identity $upnuser -PolicyName "DRTEAMS"

Get-CsOnlineUser -Identity $UPNuser | select LineUri







