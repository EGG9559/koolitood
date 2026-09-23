$path = 'C:\Users\ege\Documents\script 6'
$logFile = Join-Path $path 'logid.txt'
$outFile = Join-Path $path 'hoiatused.txt'
$failures = @{}
$processed = 0
Get-Content $logFile -Encoding UTF8 | ForEach-Object {
$line = $_.Trim()
if ($line) {
$parts = $line.Split(';')
if ($parts.Count -ge 3) {
$user = $parts[1]
$action = $parts[2]
Write-Host "Found: User='$user', Action='$action'" 
if ($action -like '*Vale*' -or $action -like '*Wrong*') {
if ($failures.ContainsKey($user)) {
$failures[$user] = $failures[$user] + 1
} else {
$failures[$user] = 1
}}
$processed++  }}}
Write-Host "log lines found: $processed"
Write-Host "fail counts:" 
$failures.GetEnumerator() | ForEach-Object {
Write-Host "  $($_.Key): $($_.Value)" -ForegroundColor red
}
$warnings = @()
foreach ($key in $failures.Keys) {
if ($failures[$key] -gt 3) {
$warnings += "User $key is potentially suspicious – $($failures[$key]) failed logins."
}}
if ($warnings.Count -eq 0) {
Write-Host "0 warns - all under 3 fails" -ForegroundColor green
Clear-Content $outFile
} else {
$warnings | Out-File $outFile -Encoding UTF8
Write-Host "Wrote $($warnings.Count) warning(s) to $outFile" -ForegroundColor Green
#note to self - later at school build mega file of scripts i make and explanations on what does what.
#major shit i learned - getenumerator and clear content tends to be useful with these kinds of scripts.
}