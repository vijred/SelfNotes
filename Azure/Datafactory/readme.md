Azure Data Factory
===================

Self hosted Integration Runtime -
* There is an option to share Integration runtime between different ADF Workspaces
* Interesting, User needs to be the owner of ADF to give access to other ADF workspaces to share the Integration Runtime. Ref: https://learn.microsoft.com/en-us/azure/data-factory/create-shared-self-hosted-integration-runtime-powershell#known-limitations-of-self-hosted-ir-sharing 
* Self Hosted Integration Runtime - SHIR
  * How to Automate installation - Use base installation ocncept from https://github.com/Azure/Azure-DataFactory/tree/main/SamplesV2/SelfHostedIntegrationRuntime/AutomationScripts. build Automation using Puppet or Ansible!
  * Do I need to intall JRE? JER or Open JDK is needed to convert dataset into .Parquet files in the system. Ref:  https://learn.microsoft.com/en-us/azure/purview/scanning-shir-troubleshooting
    * Of JRE is installed, there is no dependency with JAVA_HOME, if Open JDK is installed add JAVA_HOME system variable referencing to jre location of OpenJDK. (Ref: https://learn.microsoft.com/en-us/azure/purview/manage-integration-runtimes#java-runtime-environment-installation)
  * How to reregister a SHIR Node - Edit Powershell Script (Example location: C:\Program Files\Microsoft Integration Runtime\5.0\PowerShellScript\RegisterIntegrationRuntime.ps1). Add $gatewayKey, and $NodeName parametes and run as Administrator.


* How to clone ADF Workspace to a new workspace?
  * https://learn.microsoft.com/en-us/azure/data-factory/copy-clone-data-factory 


* How to authenticate one of the ADF to access SHIR Created in a different ADF, following is sample Powershell Code (AZ cmdlet)
```
$ResourceGroupName = "rg-asfdsafsds-001"
$SharedDataFactoryName = "dataf-sadfdsafdsaf-001"
$SharedIntegrationRuntimeName = "ir-afdsfdsfdsf-001"

$SharedIR = Get-AzDataFactoryV2IntegrationRuntime -Name $SharedIntegrationRuntimeName -ResourceGroupName $ResourceGroupName -DataFactoryName $SharedDataFactoryName


$linkedObjectId = "sfdadsfdsafd-sdafds-dsaf-dsaf-dsafdsafdsafdsafdsa"   # This is the principalId of ADF Resource, you can see it in Portal json view 


New-AzRoleAssignment `
    -ObjectId $linkedObjectId `
    -RoleDefinitionName 'Contributor' `
    -Scope $SharedIR.Id
```


* ADF, what if you publish a componnet (Managed Private Endpoint) in live Mode? Assume the problem is to get the componnet information into ARM Template.
  * There is no easy way to bring this into Arm Template (Default in adf_publish branch). Fix is to update publish_config.json file in collaboration branch, update publishBranch value to new name like `"publishBranch":"adf_publish2"`. Now, refresh ADF Workspace and publish. This will publish ARM Templates into New Branch. Delete the old branch `adf_publish`. Now change publish_config.json to adf_publish. Now refresh Workspace and publish again that updates all components to ARM Template that can be used to deploy into other environments.


 * Howto pull data from Sharepoint into a desiation -
   * https://learn.microsoft.com/en-us/azure/data-factory/connector-sharepoint-online-list?tabs=data-factory#linked-service-properties works well! https://www.youtube.com/watch?v=FFfNu3cI-uw is a good example but has some errors, use microsoft documentation
   * Do not use the Password directly while building the strings. Use http method to pull secret from Keyvault using system Authentication, use the output in secured way while connecting.
   * Example: <img width="1403" height="1097" alt="image" src="https://github.com/user-attachments/assets/fcd3fcba-c762-4b69-978b-2cc9cc7d32a0" />

   

