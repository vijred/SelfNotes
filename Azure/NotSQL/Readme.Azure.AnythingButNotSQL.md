Azure Anything but not SQL 
==============


Tips and Tricks
--------------
* Best place to keep track of maintenance on your Azure resources: -> https://portal.azure.com/#blade/Microsoft_Azure_Health/AzureHealthBrowseBlade/plannedMaintenance


AzureRM Cmdlets were active early 2010's and starting ~2018 AZ modules are actively created and AzureRM is outdated.
---------------------------------

* Login to Azure
    - `Login-AzAccount`
* Get list of Subscriptions 
    - `Get-AzSubscription`
* Select a given Subscription
    - `Select-AzSubscription -Subscription 04jdfdbfdjhb-578e-4a76-2133-sdfasdfasfdas`
* How to install AZ modules if AzureRM modules are already installed on the server
    - use AllowClobber option with caution, Example: `Install-Module -Name Az.Accounts -MaximumVersion 2.1.0 -AllowClobber`
* How to check if you already logged in or not and login only if required
```
# Test if you're logged in
if ((Get-AzContext) -eq $null){
    Connect-AzAccount
}
```
