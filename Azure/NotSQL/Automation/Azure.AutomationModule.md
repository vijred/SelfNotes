Azure Automation Modules Info
===============


Samples
------


### Find the list of Modules installed on a given Automation Account
* **Purpose:** Get the list of modules installed on Azure Automation account:    
```
Login-AzAccount
Get-AzSubscription
Select-AzSubscription -Subscription afddsaf-234r-asfd-1234-adsfadsf
Import-Module Az.Automation
$mods=Get-AzAutomationModule -ResourceGroupName myResourceGroupName -AutomationAccountName MyAutomationAccountName
$mods | Export-Csv -Path c:\temp\modules.csv
```
* **Use case:** List of modules on Automation account needs to be installed on Hybrid Worker server along with its Max version:
    - Example `Install-Module -Name AzureRM.Automation -MaximumVersion 6.1.1`


