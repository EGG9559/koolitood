Clear-Host
Write-Host "=============================" -ForegroundColor Cyan
Write-Host " |SELECT AN APP TO INSTALL|" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan
Write-Host "1) Google Chrome"              
Write-Host "2) Firefox "           " /⁀\ "
Write-Host "3) Opera GX"           "/egg\"
Write-Host "4) Waterfox"           "\___/"
Write-Host "5) Brave"                
Write-Host "6) Exit"                 
Write-Host "=============================" -ForegroundColor Cyan
#added an egg into the script because why not
#the part of the script that asks you wut you want to install.
$choice = Read-Host -Prompt "choose what to install"
switch ($choice) {
    "1" { $appId = "Google.Chrome" }
    "2" { $appId = "Mozilla.Firefox"}
    "3" { $appId = "Opera.Opera" }
    "4" { $appId = "Waterfox.Waterfox" }
    "5" { $appId = "Brave.Brave" }
    "6" { Write-Host "Exiting."; exit }
Default { Write-Host "Invalid choice. Exiting script."; exit }
}
#the lines above are appids for the actual apps within winget to install
$isInstalled = winget list --id $appId --exact 2>$null | Select-String $appId
if ($LastExitCode -eq 0) {
Write-Host "[!] $appId on olemas, uuenduste kontroll." 
$upgradeCheck = winget upgrade --id $appId 2>$null
if ($upgradeCheck -match "No available upgrade found" -or $upgradeCheck -match "No newer package versions are available") {
Write-Host "kõige uuem versioon olemas" 
#checks for updates n shit and tells you if your up to date
} else {
winget show --id $appId
Write-Host "----------------------------------------" 
$valik = Read-Host "soovid uuendada? (1=uuenda, 2=jäta vahele)"
#asks if you want to update or not. next 6 lines are your options on updating and not updating.
if ($valik -eq "1") {
Write-Host "Uuendatakse rakendust $appId" 
winget upgrade --id $appId --silent --accept-source-agreements --accept-package-agreements
Write-Host "uuendatud" -ForegroundColor Green
} else {
Write-Host "ei aitäh." 
}}
#the part that actually installs the applications. accept source and package agreements get rid of prompts.
} else {
Write-Host "arvutile installimine $appId" 
winget install --id $appId --silent --accept-source-agreements --accept-package-agreements 
Write-Host "Tehtud!" -ForegroundColor Green
}
#checks if the steam file path exists. If it is reports that its installed. If not it installs. Then retests. If still not there it retries one more time. Then repoprts its done
Write-Host "steam kontroll." 
if (winget list --id Valve.Steam -e 2>$null | Select-String "Valve.Steam") {
Write-Host "Steam olemas" -foregroundcolor green
} else {
Write-Host "Steami installimine."
winget install --id valve.steam --silent --accept-source-agreements --accept-package-agreement
}
if (winget list --id Valve.Steam -e 2>$null | Select-String "Valve.Steam") {
write-host "Steam installitud korrektselt"
} else { 
write-host "steam ei ole korrektselt installitud"
}
Write-Host "tehtud" 
#From here on its just the plain raphire windows debloat script. Nothing in raphire was modified. Once user is prompted to start it they have 2 options. Press a button and raphire starts or kill process.
Read-Host "jätka raphire skriptiga? (powershell kinni kui ei enter kui ja)"
param (
    [switch]$Verbose,
    [switch]$WhatIf,
    [switch]$Dev,
    [switch]$CLI,
    [switch]$Silent,
    [switch]$Sysprep,
    [string]$LogPath,
    [string]$User,
    [Alias('NoRestartExplorer')]
    [switch]$SkipExplorerRestart,
    [switch]$CreateRestorePoint,
    [switch]$SkipRegistryBackup,
    [switch]$RunDefaults,
    [switch]$RunDefaultsLite,
    [switch]$RunSavedSettings,
    [string]$Config,
    [string]$Apps,
    [string]$AppRemovalTarget,
    [switch]$RemoveApps,
    [switch]$RemoveGamingApps,
    [switch]$RemoveHPApps,
    [switch]$ForceRemoveEdge,
    [switch]$DisableDVR,
    [switch]$DisableGameBarIntegration,
    [switch]$EnableWindowsSandbox,
    [switch]$EnableWindowsSubsystemForLinux,
    [switch]$DisableTelemetry,
    [switch]$DisableSearchHistory,
    [switch]$DisableFastStartup,
    [switch]$DisableBitlockerAutoEncryption,
    [switch]$DisableModernStandbyNetworking,
    [switch]$DisableNotifications,
    [switch]$DisableStorageSense,
    [switch]$DisableUpdateASAP,
    [switch]$PreventUpdateAutoReboot,
    [switch]$DisableDeliveryOptimization,
    [switch]$DisableDeviceAutoAppDownload,
    [switch]$DisableBing,
    [switch]$DisableStoreSearchSuggestions,
    [switch]$DisableDesktopSpotlight,
    [switch]$HideDesktopSpotlightIcon,
    [switch]$EnableDesktopSpotlight,
    [switch]$DisableLockscreenTips,
    [switch]$DisableSuggestions,
    [switch]$DisableLocationServices,
    [switch]$DisableFindMyDevice,
    [switch]$DisableEdgeAds,
    [switch]$DisableBraveBloat,
    [switch]$DisableSettings365Ads,
    [switch]$DisableSettingsHome,
    [switch]$ShowHiddenFolders,
    [switch]$ShowKnownFileExt,
    [switch]$HideDupliDrive,
    [switch]$EnableDarkMode,
    [switch]$DisableTransparency,
    [switch]$DisableAnimations,
    [switch]$TaskbarAlignLeft,
    [switch]$CombineTaskbarAlways, [switch]$CombineTaskbarWhenFull, [switch]$CombineTaskbarNever,
    [switch]$CombineMMTaskbarAlways, [switch]$CombineMMTaskbarWhenFull, [switch]$CombineMMTaskbarNever,
    [switch]$MMTaskbarModeAll, [switch]$MMTaskbarModeMainActive, [switch]$MMTaskbarModeActive,
    [switch]$HideSearchTb, [switch]$ShowSearchIconTb, [switch]$ShowSearchLabelTb, [switch]$ShowSearchBoxTb,
    [switch]$HideTaskview,
    [switch]$DisableStartRecommended,
    [switch]$DisableStartAllApps, [switch]$StartAllAppsCategory, [switch]$StartAllAppsGrid, [switch]$StartAllAppsList,
    [switch]$DisableStartPhoneLink,
    [switch]$DisableCopilot,
    [switch]$DisableRecall,
    [switch]$DisableClickToDo,
    [switch]$DisableAISvcAutoStart,
    [switch]$DisablePaintAI,
    [switch]$DisableNotepadAI,
    [switch]$DisableEdgeAI,
    [switch]$DisableSearchHighlights,
    [switch]$DisableWidgets,
    [switch]$HideChat,
    [switch]$EnableEndTask,
    [switch]$EnableLastActiveClick,
    [switch]$ClearStart,
    [string]$ReplaceStart,
    [switch]$ClearStartAllUsers,
    [string]$ReplaceStartAllUsers,
    [switch]$RevertContextMenu,
    [switch]$DisableDragTray,
    [switch]$DisableMouseAcceleration,
    [switch]$DisableStickyKeys,
    [switch]$DisableWindowSnapping,
    [switch]$DisableSnapAssist,
    [switch]$DisableSnapLayouts,
    [switch]$HideTabsInAltTab, [switch]$Show3TabsInAltTab, [switch]$Show5TabsInAltTab, [switch]$Show20TabsInAltTab,
    [switch]$HideHome,
    [switch]$HideGallery,
    [switch]$ExplorerToHome,
    [switch]$ExplorerToThisPC,
    [switch]$ExplorerToDownloads,
    [switch]$ExplorerToOneDrive,
    [switch]$AddFoldersToThisPC,
    [switch]$HideOnedrive,
    [switch]$Hide3dObjects,
    [switch]$HideMusic,
    [switch]$HideIncludeInLibrary,
    [switch]$HideGiveAccessTo,
    [switch]$HideShare,
    [switch]$ShowDriveLettersFirst,
    [switch]$ShowDriveLettersLast,
    [switch]$ShowNetworkDriveLettersFirst,
    [switch]$HideDriveLetters
)

# Check if current PowerShell environment is limited by security policies
if ($ExecutionContext.SessionState.LanguageMode -ne "FullLanguage") {
    Write-Error "Win11Debloat is unable to run on your system, PowerShell execution is restricted by security policies"
    Write-Output "Press any key to exit..."
    $null = [System.Console]::ReadKey()
    Exit 1
}

Clear-Host
Write-Output "-------------------------------------------------------------------------------------------"
Write-Output " Win11Debloat Script"
Write-Output "-------------------------------------------------------------------------------------------"

$tempRootPath = $env:TEMP
$tempWorkPath = Join-Path $tempRootPath 'Win11Debloat'
$tempArchivePath = Join-Path $tempRootPath 'win11debloat.zip'

# Download Win11Debloat from GitHub as a zip archive.
try {
    if ($Dev) {
        Write-Output "> Downloading development version of Win11Debloat..."
        $sourceUri = "https://github.com/Raphire/Win11Debloat/archive/refs/heads/master.zip"
    } else {
        Write-Output "> Downloading Win11Debloat..."
        $sourceUri = (Invoke-RestMethod https://api.github.com/repos/Raphire/Win11Debloat/releases/latest).zipball_url
    }
    Invoke-RestMethod $sourceUri -OutFile $tempArchivePath
}
catch {
    Write-Host "Unable to fetch required files from GitHub. Please check your internet connection and try again." -ForegroundColor Red
    Write-Error -ErrorRecord $_
    Write-Output ""
    Write-Output "Press enter to exit..."
    Read-Host | Out-Null
    Exit 1
}

# Remove old script folder if it exists, but keep configs, logs and backups
if (Test-Path $tempWorkPath) {
    Write-Output ""
    Write-Output "> Cleaning up old script files..."

    Get-ChildItem -Path $tempWorkPath -Exclude Config,Logs,Backups | Remove-Item -Recurse -Force
}

$configDir = Join-Path $tempWorkPath 'Config'
$backupDir = Join-Path $tempWorkPath 'ConfigOld'

# Temporarily move existing config files if they exist to prevent them from being overwritten by the new script files, will be moved back after the new script is unpacked
if (Test-Path "$configDir") {
    Write-Output ""
    Write-Output "> Backing up existing config files..."

    New-Item -ItemType Directory -Path "$backupDir" -Force | Out-Null

    $filesToKeep = @(
        'LastUsedSettings.json'
    )

    Get-ChildItem -Path "$configDir" -Recurse | Where-Object { $_.Name -in $filesToKeep } | Move-Item -Destination "$backupDir"

    Remove-Item "$configDir" -Recurse -Force
}

Write-Output ""
Write-Output "> Unpacking..."

# Unzip archive to Win11Debloat folder
Expand-Archive $tempArchivePath $tempWorkPath

# Remove archive
Remove-Item $tempArchivePath

# Move files
Get-ChildItem -Path (Join-Path $tempWorkPath '*Win11Debloat-*') -Recurse | Move-Item -Destination $tempWorkPath

# Add existing config files back to Config folder
if (Test-Path "$backupDir") {
    if (-not (Test-Path "$configDir")) {
        New-Item -ItemType Directory -Path "$configDir" -Force | Out-Null
    }

    Write-Output ""
    Write-Output "> Restoring existing config files..."

    Get-ChildItem -Path "$backupDir" -Recurse | Move-Item -Destination "$configDir"
    Remove-Item "$backupDir" -Recurse -Force
}

# Make list of arguments to pass on to the script (exclude the -Dev switch, which only affects this launcher)
$arguments = $($PSBoundParameters.GetEnumerator() | Where-Object { $_.Key -ne 'Dev' } | ForEach-Object {
    if ($_.Value -eq $true) {
        "-$($_.Key)"
    } 
    else {
         "-$($_.Key) ""$($_.Value)"""
    }
})

Write-Output ""
Write-Output "> Launching Win11Debloat..."

# Minimize the PowerShell window when no parameters are provided
if ($arguments.Count -eq 0) {
    $windowStyle = "Minimized"
}
else {
    $windowStyle = "Normal"
}

# Remove PowerShell 7 modules from path to prevent module loading issues in the script
if ($PSVersionTable.PSVersion.Major -ge 7) {
    $NewPSModulePath = $env:PSModulePath -split ';' | Where-Object -FilterScript { $_ -like '*WindowsPowerShell*' }
    $env:PSModulePath = $NewPSModulePath -join ';'
}

# Run Win11Debloat script with the provided arguments
$debloatScriptPath = Join-Path $tempWorkPath 'Win11Debloat.ps1'
$exitCode = 0
$debloatProcess = $null
try {
    $debloatProcess = Start-Process powershell.exe -WindowStyle $windowStyle -PassThru -ArgumentList "-executionpolicy bypass -File `"$debloatScriptPath`" $arguments" -Verb RunAs -ErrorAction Stop
}
catch {
    $exitCode = 1
    Write-Error "Failed to start Win11Debloat: $_"
}

# Wait for the process to finish before continuing
if ($null -ne $debloatProcess) {
    $debloatProcess.WaitForExit()
    $exitCode = $debloatProcess.ExitCode
}

# Remove all remaining script files, except for configs, logs and backups
if (Test-Path $tempWorkPath) {
    Write-Output ""
    Write-Output "> Cleaning up..."

    # Cleanup, remove Win11Debloat directory
    Get-ChildItem -Path $tempWorkPath -Exclude Config,Logs,Backups | Remove-Item -Recurse -Force
}

Write-Output ""
Exit $exitCode
