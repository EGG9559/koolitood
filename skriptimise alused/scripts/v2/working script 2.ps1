$emails = Get-Content -Path "C:\Users\vboxuser\Documents\emails.txt" -TotalCount 1
$emails = $emails.split(",")
$total = $emails.count
Write-host "Massiivis on kokku $total emaili"
$first = $emails[0]
$last = $emails[-1]
Write-Host $first $last