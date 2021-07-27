Function Test-Computer{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName, Position=0)]
        [Alias("Cn")][String]$ComputerName,
        [Alias("AsCn")][String]$AsComputerName,
        [ValidateSet('Diagnostic', 'Detailed', 'Normal', 'Minimal', 'None')]
        [String]$Output = 'Detailed'
    )
    Begin{
        #$ConfigPath = Join-Path -Path (Split-Path $PSScriptRoot -Parent) -ChildPath 'InfraTest'
        $ConfigPath = Join-Path -Path (Split-Path -Path $((Get-Module PScode.InfraTest -ListAvailable).Path) -Parent) -ChildPath 'InfraTest'
        If ($AsComputerName){
            $ConfigFiles = Get-ChildItem -Path $ConfigPath -Name "$AsComputerName.psd1" -Recurse 
        }
        Else {       
            $ConfigFiles = Get-ChildItem -Path $ConfigPath -Name "$ComputerName.psd1" -Recurse
        }
    }
    Process{
        If ($null -eq $ConfigFiles){ 
            return 
        }
        If (-Not(Test-Connection -ComputerName $ComputerName -Count 2 -Quiet)){
            Write-Warning "$ComputerName seems to be offline!"
            return
        }
        Foreach($ConfigFile in $ConfigFiles){
            If ($ConfigFile.StartsWith("Service")){
                Write-Verbose "Call Service.Tests.ps1"                
                $Data = @{
                    ComputerName = $ComputerName
                    ConfigFile   = Join-Path -Path $ConfigPath -ChildPath $ConfigFile
                }
                $ScriptPath = "..\Private\Service.Tests.ps1"                
                $Container  = New-PesterContainer -Path $ScriptPath -Data $Data
                
                Invoke-Pester -Container $Container -Output $Output
            }
            If($ConfigFile.StartsWith("Process")){
                Write-Verbose "Call Process.Tests.ps1"                
                $Data = @{
                    ComputerName = $ComputerName 
                    ConfigFile   = Join-Path -Path $ConfigPath -ChildPath $ConfigFile
                }
                $ScriptPath = "..\Private\Process.Tests.ps1"                
                $Container  = New-PesterContainer -Path $ScriptPath -Data $Data
                
                Invoke-Pester -Container $Container -Output $Output
            }            
        }
    }
    End{}
}

   