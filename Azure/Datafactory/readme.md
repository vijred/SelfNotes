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


How to clone ADF Workspace to a new workspace?
* https://learn.microsoft.com/en-us/azure/data-factory/copy-clone-data-factory 

