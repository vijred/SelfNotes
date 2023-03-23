Azure Devops 
============

Release pipelines
-----------------

* How to enable debug mode on Release pipeline 
    -   Add a new variable `System.Debug` wiht value `True` This runs the release in debug mode 

* Wha is the url - 
    -   dev.azure.com

* Sample way to add a Service Connection
    1. Open Project, Settings , Pipelines , Service connections 
    2. New Service Connection, Azure Resource Manager, Service principal (Automatic) 
    3. Subscription , Resource Group, SP name, Security (Grant acess permissions to all pipelines)
    4. Manage Permissions for the new Service principle created 


* Sample Terraform Execution Pipeline
    1. Create an artifact, a Devops repo can be used 
    2. Agent can be configured to run on windows-2010
    3. Task-1: Azure CLI, install Azure CLI 
        * 


* How to log commands or update variables or communicat3e between tasks in Devops Tasks 
    -   https://docs.microsoft.com/en-us/azure/devops/pipelines/scripts/logging-commands?view=azure-devops&tabs=powershell
    -   Ex: `Write-Host "##vso[task.setvariable variable=mykeyvar]$mykey"`

* How to access Devops using REST API (Example use postman)
    - https://www.sanderh.dev/call-Azure-DevOps-REST-API-Postman/


* DevOps AgentPools and Self-Hosted Windows agents can be used to offload the work to specific machine. Ref: https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/v2-windows
  * When to use this? If there is any  requirement to run Devops workload from existing server, this is possible option. Quick to install, configure and easy to uninstall aswell! 

