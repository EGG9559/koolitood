
$eesnimi = "Ege Marek"
$perekonnanimi = "Güldere"
$sunniaasta = 2007
$praeguneAasta = (Get-Date).Year
$vanus = $praeguneAasta - $sunniaasta
$Kuupaev = Get-Date -Format "dd/MMMM/yyyy"
Write-Host "Tere $eesnimi $perekonnanimi Oled $vanus aastat vana. Täna on $Kuupaev."
if ($vanus -lt 18) {
    Write-Host "Sa oled alaealine."
} else {
    Write-Host "Sa oled täisealine."
}S