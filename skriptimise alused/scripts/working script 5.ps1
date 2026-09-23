$name = hostname
Write-Host "\\name//"
Write-Host "pc name is: $name"
Write-Host ""
$logicaldrivesdata = Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 }
$logicaldrivescount = $logicaldrivesdata.Count
Write-Host "\\drives//"
if ($logicaldrivesCount -gt 1) {
Write-Host "system has $logicaldrivescount logical drives."
} else {
Write-Host "system has 1 logical drive."}
Write-Host ""
Write-Host "\\space stats//"
foreach ($drive in $logicalDrivesData) {
$driveLetter = $drive.DeviceID
$totalSpace = [math]::Round($drive.Size / 1GB, 2)
$freeSpace = [math]::Round($drive.FreeSpace / 1GB, 2)
if ($driveLetter -ne $null -and $totalSpace -gt 0) {
$freeSpacePercent = ([math]::Round(($freeSpace / $totalSpace) * 100, 1))
if ($freeSpacePercent -lt 50) {
Write-Host "over half full."
} else {
Write-Host "drive $driveLetter has $freeSpacePercent% space free"}}}