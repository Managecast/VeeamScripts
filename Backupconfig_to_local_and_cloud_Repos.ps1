$Repo = Get-VBRBackupRepository -Name 'Workstation C Drive'
$Repo1 = Get-VBRBackupRepository -Name 'WorkstationAttachedStorage'

Set-VBRConfigurationBackupJob -Repository $Repo
Start-VBRConfigurationBackupJob
$lastresult=Get-VBRConfigurationBackupJob

Set-VBRConfigurationBackupJob -Repository $Repo1
Start-VBRConfigurationBackupJob
$lastresult1=Get-VBRConfigurationBackupJob

$EmailFrom = "Email@email.com"
$EmailTo = "Email.email.com"
$Subject = "Backup Config Status"


$body=" "
$body += "The backup configuration for the location "
$body += "$($lastresult.Target)"
$body += " has completed with a   "
$body+= "$($lastresult.LastResult)"

$body+= " and "

$body += " the backup configuration for the location "
$body += "$($lastresult1.Target)"
$body += " has completed with a "
$body+= "$($lastresult1.LastResult)"

$SMTPServer = "Enter SMTP Server"
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPClient.EnableSsl = $true
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("Email@email.com", "PASSWORD");

$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body) 