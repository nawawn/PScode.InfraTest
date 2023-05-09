$ServiceData = @{
    AllService = @(
        @{
            Role = 'ExchangeServer'
            Service = @()
        },
        @{
            Role = 'Hyper-V'
            Service = @()
        },
        @{
            Role = 'IIS'
            Service = @()
        },
        @{
            Role = 'SqlServer'
            Service = @()
        }
    )
}

Function Get-ServerService{
    Param(
        $Role
    )
    Process{
    
    }

}