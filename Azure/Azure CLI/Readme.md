Azure CLI
=========

* Azure CLI documentation -> https://docs.microsoft.com/en-gb/cli/azure/
* Login
    - `az login`
* Find the subscription you are using
    - `az account show`
    - `az account show --output table`
* How to set the context?
    - AZ way - `Connect-AzAccount -Tenant 12345678-abcd-4f97-4444-rrrr55555d83` - Where tenantid can be found from az account command.
    - If you are using Powershell Cmdlets, you need to use different command. `Get-AzSubscription -SubscriptionId "sadfdsaf-ads-asdf-44-casdfdsf33fe39" -TenantId "fsdf-sfd-dsfdf-34543-fewr4ewr3ggrf" | Set-AzContext`
* List all subscriptions
    - `az account list --output table`
* Select a subscription
    - `az account set --subscription "My Demos"`
* How to install Azure CLI
    - `winget install -e --id Microsoft.AzureCLI`
    - `Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'`

FAQ
====
* Subscription is missing from az account list but I can see it from Portal
    -   Refresh the list using connecd `az account list --refresh`
