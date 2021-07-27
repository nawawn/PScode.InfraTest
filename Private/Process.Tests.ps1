#Requires -Modules @{ ModuleName="Pester"; ModuleVersion="5.0.0" }
Param(
    [Parameter(Mandatory)]
    [String]$ComputerName = $Env:ComputerName ,
    [String]$ConfigFile   = 'C:\PSscripts\HomeScript\PScode.InfraTest\InfraTest\Process\NawAwn-SP3.psd1'
)

BeforeDiscovery{
    #$Config is only available in Discovery Mode
    $Config = Import-PowerShellDataFile -Path $ConfigFile
}

Describe 'Process Check on <ComputerName>' {
    IT '<_> Should exists' -Foreach $($Config.Name){
        $Proc = Get-Process -Name $_ -ComputerName $ComputerName -ErrorAction 'SilentlyContinue'
        $Proc.Count | Should -BeGreaterOrEqual 1
    }
}

#$Data = @{ComputerName = 'NAWAWN-SP3'; ConfigFile = 'C:\PSscripts\HomeScript\PScode.InfraTest\InfraTest\Process\NawAwn-SP3.psd1' }
#$Containers = New-PesterContainer -Path 'Process.Tests.ps1' -Data $Data
#Invoke-Pester -Container $containers -Output Detailed