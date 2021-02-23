Azure - Hybrid Worker
=====================

Hybrid workers are used to execute Azure Runbook on VM


* How to remove a VM from Hybrid Worker Workgroup

        $UrlForAutomationAccount="https://asdfadsf.adsf.eus.azure-automation.net/accounts/asdfdsaf";
        $KeyForAutomationAccount="sadfdsafdsafdsafdsfdsafdsfdsfdafdsafdsa";
        $RemoveMachine="MYSERVERNAME.msft.com"
        Remove-HybridRunbookWorker -Url $UrlForAutomationAccount -Key $KeyForAutomationAccount -MachineName $RemoveMachine

* How to verify if a Runbook job is running on a Given Hybrid worker 

