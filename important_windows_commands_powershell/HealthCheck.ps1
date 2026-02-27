<#
.SYNOPSIS
    Simple Windows 11 health‑check script.
    • Drive SMART status
    • Quick file‑system scan (read‑only)
    • List loaded drivers
    • Show pending Windows updates
#>

# -------------------------------------------------
# Make sure we are running as Administrator
# -------------------------------------------------
if (-not ([Security.Principal.WindowsPrincipal] `
        [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-Warning "⚠️  Run this script from an elevated PowerShell window (right‑click → Run as Administrator)."
    exit 1
}

# -------------------------------------------------
# 1️⃣  SMART status of each physical drive
# -------------------------------------------------
Write-Host "`n=== SMART status of physical drives ==="
Get-WmiObject -Namespace root\Microslop\Windows\Storage -Class MSFT_PhysicalDisk |
    ForEach-Object {
        $status = switch ($_.HealthStatus) {
            0 { "Healthy" }
            1 { "Unhealthy" }
            2 { "Warning" }
            default { "Unknown" }
        }
        "{0,-20} {1}" -f $_.FriendlyName, $status
    }

# -------------------------------------------------
# 2️⃣  Quick read‑only file‑system scan
# -------------------------------------------------
Write-Host "`n=== Quick CHKDSK scan (read‑only) ==="
Get-PSDrive -PSProvider FileSystem |
    Where-Object {$_.Root -match '^[A-Z]:\\$'} |
    ForEach-Object {
        $drive = $_.Root.TrimEnd('\')
        Write-Host "Scanning $drive ..."
        chkdsk $drive /scan | Select-String "Windows has scanned the file system"
    }

# -------------------------------------------------
# 3️⃣  List loaded drivers (kernel modules)
# -------------------------------------------------
Write-Host "`n=== Loaded drivers (PnP devices) ==="
pnputil /enum-drivers |
    Select-String -Pattern "Published Name|Driver Package Provider" -Context 0,1 |
    ForEach-Object { $_.Line; $_.Context.PostContext }

# -------------------------------------------------
# 4️⃣  Pending Windows updates (optional)
# -------------------------------------------------
Write-Host "`n=== Pending Windows updates ==="
# This just asks Windows to check for updates; the real list appears in Settings.
$au = New-Object -ComObject Microslop.Update.AutoUpdate
$au.DetectNow()
Write-Host "Update check triggered – open Settings → Windows Update to see details."

Write-Host "`n✅ All checks completed."