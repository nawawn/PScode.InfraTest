#Requires -Modules @{ ModuleName="Pester"; ModuleVersion="5.0.0" }
Param(
    [Parameter(Mandatory)]
    [String]$ComputerName = $Env:ComputerName ,
    [String]$ConfigFile   = 'C:\PSscripts\HomeScript\PScode.InfraTest\InfraTest\Service\NawAwn-SP3.psd1'
)

BeforeDiscovery{
    #$Config is only available in Discovery Mode
    $Config = Import-PowerShellDataFile -Path $ConfigFile
}

Describe 'Service Check on <ComputerName>' -Foreach $Config{    
    Context '<_> Test Case' -Foreach $($Config.Keys){
    BeforeAll{
        #Now $Status is available on Run Mode
        $Status = $_
    }         
        It "<_> should be $_" -Foreach $($Config[$_]){
            (Get-Service -Name $_ -ComputerName $ComputerName -ErrorAction 'SilentlyContinue').Status | Should -Be $Status
        }        
    }
}

<# This works using hard coded Context section
Describe 'Service Check on <ComputerName>' -Foreach $Config{    
    Context 'Running Cases'{           
        It '<_> should be Running' -Foreach $($Config.Running){
            (Get-Service -Name $_ -ComputerName $ComputerName).Status | Should -Be 'Running'
        }        
    }
    Context 'Stopped Cases'{           
        It '<_> should be Stopped' -Foreach $($Config.Stopped){
            (Get-Service -Name $_ -ComputerName $ComputerName).Status | Should -Be 'Stopped'
        }        
    }
}

# This Works with the data structure below
@{
    Services = @(   
	    @{Name = 'RpcSs';    Status = 'Running'}
    	@{Name = 'MPSsvc';   Status = 'Running'}
    	@{Name = 'Spooler';  Status = 'Stopped'}
    	@{Name = 'WerSvc';   Status = 'Stopped'}
    )
}
Describe 'Service Check on <ComputerName>' -Foreach $Config{     
    It '<Name> should be <Status>' -Foreach $($Config.Services){
        (Get-Service -Name $Name -ComputerName $ComputerName).Status | Should -Be $Status
    }
}
#>

<# Implementation of this logic in Pester v5
Foreach($Status in $Config.Keys){
    Foreach($Service in $($Config[$Status])){
        Get-Service -Name $Service -ComputerName $ComputerName
    }
}
#>

#$Data = @{ComputerName = 'NAWAWN-SP3'; ConfigFile = 'C:\PSscripts\HomeScript\PScode.InfraTest\InfraTest\Service\NawAwn-SP4.psd1' }
#$Containers = New-PesterContainer -Path 'Service.Tests.ps1' -Data $Data
#Invoke-Pester -Container $containers -Output Detailed
