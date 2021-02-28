Azure - Hybrid Worker
=====================

Hybrid workers are used to execute Azure Runbook on VM




* How to remove a VM from Hybrid Worker Workgroup
```
Import-Module .\HybridRegistration.psd1 # "C:\Program Files\Microsoft Monitoring Agent\Agent\AzureAutomation\7.3.837.0\HybridRegistration"
$UrlForAutomationAccount="https://asdfadsf.adsf.eus.azure-automation.net/accounts/asdfdsaf";
$KeyForAutomationAccount="sadfdsafdsafdsafdsfdsafdsfdsfdafdsafdsa";
$RemoveMachine="MYSERVERNAME.msft.com"
Remove-HybridRunbookWorker -Url $UrlForAutomationAccount -Key $KeyForAutomationAccount -MachineName $RemoveMachine
```
* Some times above mentioned process doens not work, following is workaroudn: 
    - If worker is not removed from Worker group one of the recommendation (un-official) is to remove registry entry @ HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\HybridRunbookWorker\* from hybrid worker 
    - Note: It might take up to 48 hours for the server to be removed from Hybrid worker Group while validating in portal 

* How to verify if a Runbook job is running on a Given Hybrid worker 
    -  Orchestrator.Sandbox.exe is the process that will be running on the hybrid worker 


* How to add a VM to Hybrid worker Workgroup
    - NameOfHybridWorkerGroup: portal (hrttps://portal.azure.com) → Automation Accounts -> Select correct subscription and Account → Hybrid worker groups → Group Name 
    - UrlForAutomationAccount: portal (hrttps://portal.azure.com) → Automation Accounts -> Select correct subscription and Account → Keys → URL 
    - KeyForAutomationAccount: portal (hrttps://portal.azure.com) → Automation Accounts -> Select correct subscription and Account → Keys → Primary access key / Secondary Access Key
```
Import-Module .\HybridRegistration.psd1 # "C:\Program Files\Microsoft Monitoring Agent\Agent\AzureAutomation\7.3.837.0\HybridRegistration"
$NameOfHybridWorkerGroup="MyHybridWorkers";
$UrlForAutomationAccount="https://asdfadsf.adsf.eus.azure-automation.net/accounts/asdfdsaf";
$KeyForAutomationAccount="sadfdsafdsafdsafdsfdsafdsfdsfdafdsafdsa";
Add-HybridRunbookWorker –Url $UrlForAutomationAccount -Key $KeyForAutomationAccount -GroupName $NameOfHybridWorkerGroup
```
