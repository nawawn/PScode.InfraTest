﻿Function Get-CommonProcess{
    Process{
        return @(
            'ApplicationFrameHost'
            'backgroundTaskHost'
            'browser_broker'
            'cortana'
            'dwm'
            'explorer'
            'fontdrvhost'
            'Idle'
            'LockApp'
            'lsass'            
            'NisSrv'
            'RuntimeBroker'
            'SearchIndexer'
            'SearchUI'
            'SecurityHealthService'
            'services'
            'SettingSyncHost'
            'ShellExperienceHost'
            'sihost'
            'smartscreen'
            'smss'
            'spoolsv'
            'SgrmBroker'
            'svchost'
            'System'
            'SystemSettings'
            'Registry'
            'taskhostw'
            'TextInputHost'            
            'wininit'
            'winlogon'
            'wlanext'
            'WmiPrvSE'
            'WUDFHost'
            'YourPhone'
        )
    }
}