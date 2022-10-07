Service principles in Azure - 
===================

Service principles can be created in Azure similar to users. Service principle can be configured in Devops and MAchine learning - This is a way to authenticate Devops/ML to access other resources in Azure.

* How to Create an Azure Resource Manager service connection with an existing service principal - 
  * https://learn.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure?view=azure-devops#create-an-azure-resource-manager-service-connection-with-an-existing-service-principal
* Validate Service Principal connectiviyt using postname / REST api - https://blog.jongallant.com/2021/02/azure-rest-apis-postman-2021/
* Creating / Deleting SP (Service principal using Azure CLI) - https://learn.microsoft.com/en-us/cli/azure/ad/sp?view=azure-cli-latest#az-ad-sp-list
* Example to cretae SP - `az ad sp create-for-rbac`
*  Example to list the SP created - `az ad sp list  --display-name "azure-cli-2022-10-07-15-11-33"`
*  List all SPs owned by you - `az ad sp list --show-mine`
*  Example to delete a SP, use AppID value as --id parameter - `az ad sp delete --id  "130306da-6f69-49f5-818b-fe4af5c50e16"`
  *  Note - Permissions on Devops projects needs to be explicitly cleand up 
*  
