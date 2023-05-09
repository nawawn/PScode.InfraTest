$ProcessData = @{
    AllProcess =@(
        @{
            Role = 'ExchangeServer'
            Process = @()
        },
        @{
            Role = 'Hyper-V'
            Process = @()
        },
        @{
            Role = 'IIS'
            Process = @()
        },
        @{
            Role = 'SqlServer'
            Process = @()
        }
        
    )
}

Function Get-ServerProcess{
    Param(
        $Role
    )
    Process{
    
    }

}