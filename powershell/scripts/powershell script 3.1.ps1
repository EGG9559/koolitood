#test if path exists. if it does not exist it ignores the command below it and goes to the next if.
if (!(Test-Path -PathType Container -Path 'C:\Users\Public\IT-KURSUS')) {
    New-Item -ItemType Directory -Path 'C:\Users\Public\IT-KURSUS'
}
#same thing as before but for subfolders
if (!(Test-Path -PathType Container -Path 'C:\Users\Public\IT-KURSUS\IT24')) {
    New-Item -ItemType Directory -Path 'C:\Users\Public\IT-KURSUS\IT24'
}
#twice
if (!(Test-Path -PathType Container -Path 'C:\Users\Public\IT-KURSUS\IT25')) {
    New-Item -ItemType Directory -Path 'C:\Users\Public\IT-KURSUS\IT25'
}
#goes into the parent folder aka where it25/24 is.
cd 'C:\Users\Public\IT-KURSUS'
#does the funi random file content and name bullshiz
$filerandom = "$(Get-Random)" + ".txt"
Set-Content -Path "IT25\$filerandom" -Value "$(Get-Random)"
Write-Output "Created file: $filerandom"

#giving permissions to it25
icacls "IT25" /reset
icacls "IT25" /grant "LABOR\IT25:(OI)(CI)M"
icacls "IT25" /grant "LABOR\IT24:(OI)R"

#giving permissions to it24
icacls "IT24" /reset
icacls "IT24" /grant "LABOR\IT24:(OI)(CI)M"
icacls "IT24" /grant "LABOR\IT25:(OI)R"
#dis shows permission state. in other words what group can fuck with what.
icacls 'C:\Users\Public\IT-KURSUS\IT25'
icacls 'C:\Users\Public\IT-KURSUS\IT24'
cd $env:USERPROFILE
#permissions to look for at the end>
#(OI) - object inherit aka all files in that subfolder share permissions
#(CI) - subfolders inherit the following rule. in my case its the modify rule aka permission to modify.
#M = modify
#R = read only
#/grant gives permissions. 
#all notes above this is for myself to use.



#note for teacher - ai was used but not to generate any code and rather hint at things and diagnose errors and suggest some changes to adopt like cding back to the default folder after script done.
#things i learned - giving the if commands something to do if the if condition wasnt fulfilled is not necessary for the rest of the script to work properly. 
