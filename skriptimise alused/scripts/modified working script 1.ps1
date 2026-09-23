$name = "Ege Marek" 
$email = "ege.marek.guldere@rak.ee"
$currentdate = Get-Date
$formatteddate = $currentdate.ToString("MM/dd/yyyy HH:mm:ss")
Write-Output "$name" 
Write-Output "$email"
Write-Output "$formatteddate"