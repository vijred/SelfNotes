Azure CLI
=========

* Azure CLI documentation -> https://docs.microsoft.com/en-gb/cli/azure/
* Login
    - `az login`
* Find the subscription you are using
    - `az account show`
    - `az account show --output table`
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
