Azure Tools
==========

* Storage explorer
  - workaround to address certificate error - `& 'C:\Program Files (x86)\Microsoft Azure Storage Explorer\StorageExplorer.exe' --ignore-certificate-errors`
  - `"C:\Users\vijay\AppData\Local\Programs\Microsoft Azure Storage Explorer\StorageExplorer.exe" --ignore-certificate-errors`
  - Error: `UNABLE_TO_GET_ISSUER_CERT_LOCALLY`
  - Original reference to the troubleshooting and address Certificate problem: https://learn.microsoft.com/en-us/troubleshoot/azure/azure-storage/blobs/alerts/storage-explorer-troubleshooting?tabs=Windows#import-ssl-certificates 


* arm templates for deploying a resource 
  - Rood reference to fiurst time users - https://www.youtube.com/watch?v=MZTb9NtZOh4 
  - export arm templace from a resource - https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/export-template-powershell 
  - export template using portal - https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/export-template-portal
  - deploy arm template using Powershell - https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resources-powershell 
  
* azcopy is one more tool for copy blobs between different storage accotuns of local server
  - Ref - https://www.thomasmaurer.ch/2019/05/how-to-install-azcopy-for-azure-storage/ 

* Adding different tenant Subnets for `Enabled from selected virtual networks and IP addresses`
  - While authorizing other tenants to connect hte resources in your own subnet. You need to allow other tenant subnets access. This is not feasible on Azure due to missing read access. However AZ Cmdlets can be used get this done.
  - Ref: https://learn.microsoft.com/en-us/powershell/module/az.storage/add-azstorageaccountnetworkrule?view=azps-12.1.0
  - Sample :
```
az login
Connect-AzAccount
az account show --output table
az account list --output table
Set-AzContext -SubscriptionId asfdasf-saf-dsaf-dsaf-adsfdsafdsf -TenantId  dsafsdf-af-fdsa-asf-sadfdsafdsfds
Get-AzStorageAccountNetworkRuleSet -ResourceGroupName rg-fdsa-001 -Name datalakname
Get-AzStorageAccountNetworkRuleSet -ResourceGroupName rg-myresourcegroup -Name NyStorageName
# Last VNET is the 3rd party VNET ID
Add-AzStorageAccountNetworkRule -ResourceGroupName rg-myresourcegroup -Name NyStorageName -VirtualNetworkResourceId  "/subscriptions/asfdsfd-sadf-safdf-dsaf-safdsf/resourceGroups/prod-e..."
```


* What is the best way to removely login into a VM which is in a Subnet - BASTION
  * Hopw to login to a remove Linux server created in Azure - https://learn.microsoft.com/en-us/azure/virtual-machines/linux/use-remote-desktop?tabs=azure-cli 
