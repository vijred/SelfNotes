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

* How to Create a Service Principal in Azure
    - Service principal can be used to Authenticate and authorize a resource in Azure. This can be added as a member of an Azure group and access can be managed at the group level.
    - Most of the users can create a new Service Principal (Technically this is an application registration) and they can manage the passwords.
```
Open Azure portal → https://portal.azure.com
Open Microsoft Entra ID → (It used to be Active Directory)
Click on App registrations → (This lists all applications you own)
Click New Registration
    Name: 
    Supported account types: Accounts in this organizational directory only (Single Tenant)
    Redirect URI: (Leave blank)
    Click Register

    Application (client) ID and your Directory (tenant) ID will be used for identification of the accounbt. 
    Create a Secret for the Service Principal
        In the App Registration for the above app, click Certificates & secrets.
        Under Client secrets, click New client secret
        Description: 
        Expires: 
    Click Add

```
