#this chunk actually gets the resource usage statistics.
$memoryData = Get-Counter '\Memory\Available MBytes' -SampleInterval 2 -MaxSamples 1
$processorData = Get-Counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 2 -MaxSamples 1
$diskreads = "\LogicalDisk(C:)\Disk Reads/sec"
$diskData = Get-Counter -Counter $diskreads -maxsamples 2
#the start of printing the output into a text file
$output = @"
=== Monitor Data ===
Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

#prints the memory stats

MEMORY (Available MBytes):
$($memoryData.CounterSamples | ForEach-Object { $_.CookedValue })

#prints processor stats

PROCESSOR (% Processor Time):
$($processorData.CounterSamples | ForEach-Object { $_.CookedValue })

#prints disk stats

DISK READS (C: Disk Reads/sec):
$($diskData.CounterSamples | ForEach-Object { $_.CookedValue })

=== End of Data ===
"@
#spits out the actual file to the correct location.
$output | Out-File -FilePath "\\DC1\Backup\it25\NimelisedBackupid\egemarek\monitor\data.txt" -Encoding UTF8
clear
#script done