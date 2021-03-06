Powershell Productivity tips usecases 
======================


* Copy history of cmdlets to Clipboard 
    - `Get-History -Count 46 | Set-Clipboard`
        - This is very helpful to document one time experiments
* Importing a module 
    - `Import-Module Az.Automation`
* Get list of commands 
    - `Get-Command -Module Az.Automation`
* Uninstall a module
    - `Get-Module AzureRM.profile -ListAvailable | Uninstall-Module`
* Trust Gallary
    - `Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted`
* How to assign a variable with multiple special characters
``` 
$var= @"
{"instname":"MySQLInstance","version":"12.0.6433.1","patchstatus":"current"}
"@
```
* Easiest way to keep track of Powershell console output, using transcript (Loggin)
```
Start-Transcript "Transcript_$(Get-Date -f MM-dd-yyyy_HHmmss).txt"
Stop-transcript 
```

