# Launch apps, monitor logs, track resource usage
$processNames = @("notepad", "brave", "charmap", "waterfox", "snippingtool")
# launching apps
Write-Host "Launching" -ForegroundColor Cyan
foreach ($proc in $processNames) {
try {
Start-Process $proc -ErrorAction Stop
Write-Host "$proc launched" -ForegroundColor Green
} catch {
Write-Host "$proc not found" -ForegroundColor Red
}}
# wait 15s 
Write-Host "`Waiting" -ForegroundColor Yellow
Start-Sleep -Seconds 15
# kill them all!
Write-Host "`murdering in cold blood" -ForegroundColor Cyan
foreach ($proc in $processNames) {
$procs = Get-Process -Name $proc -ErrorAction SilentlyContinue
$terminated = 0
$failed = 0
foreach ($p in $procs) {
try {
Stop-Process -Id $p.Id -Force -ErrorAction Stop
Write-Host "$proc (PID $($p.Id)) stopped" -ForegroundColor Green
$terminated++
} catch {
Write-Host "$proc (PID $($p.Id)) already closed or protected" -ForegroundColor Gray
$failed++
}}
if ($procs.Count -gt 0) {
Write-Host "  Total: $terminated closed, $failed remaining" -ForegroundColor White
}}
# read the inner minds of the programs we murdered.
$currentPath = Get-Location
$logPath = Join-Path $currentPath "logid.txt"
Write-Host "reading the thoughtsof the programs corpses" -ForegroundColor Cyan
try {
$events = Get-WinEvent -FilterHashtable @{LogName='Application'; MaxEvents=20} -ErrorAction Stop
$eventList = foreach ($evt in $events) {
"$($evt.TimeCreated) - $($evt.ProviderName) - $($evt.LevelDisplayName)`r`n$(($evt.Message -replace '\r?\n', ' ').Substring(0,[Math]::Min(200,$evt.Message.Length)))`r`n"
} Out-String
} catch {
try {
$oldEvents = Get-EventLog -LogName Application -Newest 20 -ErrorAction Stop
$eventList = foreach ($e in $oldEvents) {
"$($e.TimeGenerated) - $($e.Source) - $($e.EntryType)`r`n$(($e.Message -replace '\r?\n', ' ').Substring(0,[Math]::Min(200,$e.Message.Length)))`r`n"
}  Out-String
} catch {
$eventList = "Failed to read logs: $($_.Exception.Message)`r`n"
}}
Set-Content -Path $logPath -Value $eventList
Write-Host "logid.txt file created: $logPath" -ForegroundColor Green
$content = Get-Content $logPath -ErrorAction SilentlyContinue
if ($content -and $content.Count -gt 0) {
$informationCount = ($content | Select-String -Pattern "Information").Count
$errorCount = ($content | Select-String -Pattern "Error").Count
$warningCount = ($content | Select-String -Pattern "Warning").Count
Write-Host "`Statistics:" -ForegroundColor Cyan
Write-Host " Information: $informationCount" -ForegroundColor White
Write-Host " Error: $errorCount" -ForegroundColor White
Write-Host " Warning: $warningCount" -ForegroundColor White
$errorLines = $content | Where-Object { $_ -match "Error|Warning" }
if ($errorLines -and $errorLines.Count -gt 0) {
Write-Host "`Error/Warning lines (${errorLines.Count}):" -ForegroundColor Red
$errorLines | ForEach-Object { Write-Host "  $_" -ForegroundColor Yellow }
}
} else {
Write-Host "logid.txt content is empty" -ForegroundColor Gray
}
#stare chrome in the eye and see what it do
Write-Host "`Monitoring Chrome resource usage (5 sec)" -ForegroundColor Cyan
$chromeStats = @()
$totalCPUSum = 0
$totalRAMSum = 0
$sampleCount = 0
for ($i = 0; $i -lt 5; $i++) {
$num = $i + 1
$chrome = Get-Process -Name chrome -ErrorAction SilentlyContinue
if ($chrome -and $chrome.Count -gt 0) {
$sumCPU = ($chrome | Measure-Object CPU -Sum).Sum
$sumRAM = ($chrome | Measure-Object WorkingSet -Sum).Sum
$percentRAM = [math]::Round(($sumRAM / 8GB) * 100, 2)
$totalMB = [math]::Round($sumRAM / 1MB, 0)
$entry = "[${num}/5] $(Get-Date -Format 'HH:mm:ss'): Chrome (${chrome.Count} processes) | CPU: ${sumCPU}s | RAM: ${percentRAM}% (${totalMB} MB)"
$totalCPUSum += $sumCPU
$totalRAMSum += $sumRAM
$sampleCount++
} else {
$entry = "[${num}/5] $(Get-Date -Format 'HH:mm:ss'): Chrome not running"
}
$chromeStats += $entry
Start-Sleep -Seconds 1
}
if ($sampleCount -gt 0) {
$avgCPU = [math]::Round($totalCPUSum / $sampleCount, 2)
$avgRAM = [math]::Round(($totalRAMSum / $sampleCount / 8GB) * 100, 2)
$summary = "`nSummary (${sampleCount} samples): Average CPU: ${avgCPU}s | Average RAM: ${avgRAM}%"
} else {
$summary = "`nSummary: Chrome was not open on any measurement"
}
$finalContent = ($chromeStats -join "`n") + $summary
$chromePath = Join-Path $currentPath "Chrome.txt"
Set-Content -Path $chromePath -Value $finalContent
Write-Host "`Chrome.txt file created: $chromePath" -ForegroundColor Green
Get-Content $chromePath | ForEach-Object { Write-Host $_ -ForegroundColor Magenta }
Write-Host "`nDone!" -ForegroundColor Green