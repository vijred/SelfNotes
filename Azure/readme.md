Azure 
=====

* Azure Devops URL
    - https://dev.azure.com/
* Azure data factory URL
    - https://adf.azure.com/ 

* Core architectural components of Azure - https://docs.microsoft.com/en-us/learn/modules/describe-core-architectural-components-of-azure/ 

* Idle way to connect to a tenant using Poewrshell! 
```
Import-Module -Name C:\Program Files\WindowsPowerShell\Modules\Az.Accounts\2.9.1\Az.Accounts.psd1 -Global
Clear-AzContext -Scope CurrentUser -Force -ErrorAction SilentlyContinue
Clear-AzContext -Scope Process
Connect-AzAccount -ServicePrincipal -Tenant ABC123A1-ABCD-1234-1234-dsfdsfd90d8fds97 -Credential System.Management.Automation.PSCredential -Environment AzureCloud @processScope
Set-AzContext -SubscriptionId afdsdsf-fdsads-afdf-sdfd-dsfdsfdsfew314red -TenantId sdf43wr-vfdsf432-gfj53-b53-365ttrg
```
