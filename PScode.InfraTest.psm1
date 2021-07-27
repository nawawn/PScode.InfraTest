#Load Public Functions
Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1" |
    ForEach-Object {
        . $_.FullName
    }

#Export Functions
$FunctionsToExport = (Get-ChildItem -Path "$PSScriptRoot\Public\*.Ps1").BaseName
Export-ModuleMember -Function $FunctionsToExport