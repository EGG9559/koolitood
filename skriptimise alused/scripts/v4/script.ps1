$content = Get-Content 'C:\Users\eggs\Documents\fix it\kasutajad.csv' -Raw
$entries = $content.Split(', ')
$people = @() 
$lastNameEndsWithE = 0
foreach ($entry in $entries) {
$parts = $entry.Trim().Split(';')
$firstName = $parts[0]
$lastName  = $parts[1]
if ($lastName.EndsWith('e', 'OrdinalIgnoreCase')) {
$lastNameEndsWithE++
}
$person = [PSCustomObject]@{
Name  = "$firstName" 
lastname = "$lastName"
Email = "$($firstName.ToLower()).$($lastName.ToLower())@rak.ee"
}
    $people += $person
}

$people | Format-Table -AutoSize
Write-Host "Total people: $($people.Count)"
Write-Host "Last names ending with 'e': $lastNameEndsWithE"