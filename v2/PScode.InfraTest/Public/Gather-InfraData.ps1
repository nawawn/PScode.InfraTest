Function Get-LoBProcess{
    Param(
        [String]$ComputerName
    )
    Begin{
        $DefaultProcess = (Get-CommonProcess) + (Get-IgnoreProcess)
    }
    Process{
        #PS v7 doesn't have ComputerName Parameter on Get-Process Cmdlet 
        Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            Get-Process | Where{$_.Name -notin $Using:DefaultProcess} | Select -ExcludeProperty Name
        }
    }
}

Function Get-LoBService{
    Param(
        [String]$ComputerName
    )
    Begin{
        $DefaultService = ((Get-CommonService).Name) + ((Get-IgnoreService).Name)
    }
    Process{
         #PS v7 doesn't have ComputerName Parameter on Get-Service Cmdlet
        Invoke-Command -ComputerName $ComputerName -ScriptBlock {
            Get-Service | Where{$_.Name -notin $Using:DefaultService} | Select Name,Status
        }
    }
}

Function Gather-InfraData{
    Param(
        [Parameter(ValueFromPipeline)]
        [String[]]$ComputerName
    )
    Begin{
        $InfraData = @{}
    }
    Process{
        Foreach($Node in $ComputerName){
            $IPaddress  = (Resolve-DnsName -Name $Node -Type A).Ip4Address
            $LoBProcess = Get-LoBProcess -ComputerName $Node
            $LoBService = Get-LoBService -ComputerName $Node

            $InfraData.Add('NodeName', $Node      )
            $InfraData.Add('IPAddress',$IPaddress )
            $InfraData.Add('Process',  $LoBProcess)
            $InfraData.Add('Service',  $LoBService)
            
            $InfraData
        }
    }
}