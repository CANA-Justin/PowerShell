$From = "EmailAddress@gmail.com"
$To = "SomeOtherAddress@whatever.com"
$Cc = "AThirdUser@somewhere.com"
$Attachment = "C:\users\Username\Documents\SomeTextFile.txt"
$Subject = "Here's the Email Subject"
$Body = "This is what I want to say"
$SMTPServer = "smtp.gmail.com"
$SMTPPort = "587"
Send-MailMessage -From $From -to $To -Cc $Cc -Subject $Subject -Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl -Credential (Get-Credential) -Attachments $Attachment –DeliveryNotificationOption OnSuccess