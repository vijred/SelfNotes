Azure Powersehell Cmdlet info 
==============


AzureRM Cmdlets were active early 2010's and starting ~2018 AZ modules are actively created and AzureRM is outdated.



* Login to Azure
    - `Login-AzAccount`
* Get list of Subscriptions 
    - `Get-AzSubscription`
* Select a given Subscription
    - `Select-AzSubscription -Subscription 04jdfdbfdjhb-578e-4a76-2133-sdfasdfasfdas`
* How to install AZ modules if AzureRM modules are already installed on the server
    - use AllowClobber option with caution, Example: `Install-Module -Name Az.Accounts -MaximumVersion 2.1.0 -AllowClobber`