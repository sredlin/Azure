﻿function Set-AzureVMLanguage{
    [cmdletbinding()]

    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('Standard','German')]
        [string]$Language

    )

    Switch ($Language){
    

        'Standard' {
        $LanguageSetting = "en-US"
        $GeoIDSetting = "244"
        $TimeZoneSetting = "Greenwich Standard Time"

        $regionalsettingsURL = "https://raw.githubusercontent.com/sredlin/Azure/master/AzureVMRegionalSettings/Settings/AzureVMLanguageStandard.xml"
        $RegionalSettings = "D:\AzureVMLanguageStandard.xml"
        #downdload regional settings file
        $webclient = New-Object System.Net.WebClient
        $webclient.DownloadFile($regionalsettingsURL,$RegionalSettings)


        # Set Locale, language etc. 
        & $env:SystemRoot\System32\control.exe "intl.cpl,,/f:`"$RegionalSettings`""

        # Set languages/culture. Not needed perse.
        Set-WinSystemLocale $Language
        Set-WinUserLanguageList -LanguageList $Language -Force
        Set-Culture -CultureInfo $Language
        Set-WinHomeLocation -GeoId $GeoID
        Set-TimeZone -Name $TimeZone

        # restart virtual machine to apply regional settings to current user. You could also do a logoff and login.
        Start-sleep -Seconds 40
        Restart-Computer
        
        
        }
        'German' {
        $LanguageSetting = "de-DE"
        $GeoIDSetting = "94"
        $TimeZoneSetting = "W. Europe Standard Time"
        $regionalsettingsURL = "https://raw.githubusercontent.com/sredlin/Azure/master/AzureVMRegionalSettings/Settings/AzureVMLanguageDE.xml"
        $RegionalSettings = "D:\AzureVMLanguageDE.xml"
       
        #downdload regional settings file
        $webclient = New-Object System.Net.WebClient
        $webclient.DownloadFile($regionalsettingsURL,$RegionalSettings)


        # Set Locale, language etc. 
        & $env:SystemRoot\System32\control.exe "intl.cpl,,/f:`"$RegionalSettings`""

        # Set languages/culture. Not needed perse.
        Set-WinSystemLocale $Language
        Set-WinUserLanguageList -LanguageList $Language -Force
        Set-Culture -CultureInfo $Language
        Set-WinHomeLocation -GeoId $GeoID
        Set-TimeZone -Name $TimeZone

        # restart virtual machine to apply regional settings to current user. You could also do a logoff and login.
        Start-sleep -Seconds 40
        Restart-Computer
        
        }
    }
}


