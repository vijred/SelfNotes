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
* Trunst Gallary
    - `Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted`
