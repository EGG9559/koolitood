$sourceFolder = "C:\Users\ege.guldere\Documents\backup source"
$backupRoot = "\\DC1\Backup\it25\NimelisedBackupid"
$targetFolder = "\\DC1\Backup\it25\NimelisedBackupid\egemarek"

if (-not (Test-Path -Path $sourceFolder)) {
    Write-Host "ERROR: Source folder does not exist" -ForegroundColor Red
    exit 1
}

try {
    if (-not (Test-Path -Path $targetFolder)) {
        New-Item -ItemType Directory -Path $targetFolder -Force | Out-Null
        Write-Host "Created backup folder: $targetFolder" -ForegroundColor Green
    }

    Copy-Item -Path "$sourceFolder\*" -Destination $targetFolder -Recurse -Force -ErrorAction Stop
    Write-Host "Backup completed successfully" -ForegroundColor Green
    
    $srcFiles = (Get-ChildItem -Path $sourceFolder -Recurse).Count
    $tgtFiles = (Get-ChildItem -Path $targetFolder -Recurse).Count
    
    if ($srcFiles -ne $tgtFiles) {
        Write-Host "WARNING: File count mismatch ($srcFiles vs $tgtFiles)" -ForegroundColor Yellow
        exit 2
    }

    exit 0
}
catch {
    Write-Host "ERROR: Insufficient permissions or network error" -ForegroundColor Red
    Write-Host $_.Exception.Message
    exit 1
}