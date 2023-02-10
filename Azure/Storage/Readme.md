Azure Storage 
=============

* How to copy a blob from one container to other 
    -   Sample using Account Key 
    ```
    $srcstorageaccountkey= "MyAccountKeyadsfdsafdsafsadfsadf=="
    $srcstorageaccountname = "lakesource"
    $srcstoragecontainername = "container"
    $srcblobname = "path/filename.csv"

    $srcStorageContext = New-AzStorageContext -StorageAccountName $srcstorageaccountname -StorageAccountKey $srcstorageaccountkey
    $srcContainer = Get-AzStorageContainer -Name $srcstoragecontainername -Context $srcStorageContext
    $srcsrcblobs = Get-AzStorageBlob -Container  $srcContainer.Name -Context $srcStorageContext -MaxCount 10

    # Get-AzStorageBlob -Container  $srcContainer.Name -Context $srcStorageContext -MaxCount 10 -Blob $srcblobname
    $srcblob = Get-AzStorageBlob -Container  $srcContainer.Name -Context $srcStorageContext -Blob $srcblobname -MaxCount 10 


    $dststorageaccountkey= "MyAccountKeyadsfdsafdsafsadfsadf=="
    $dststorageaccountname = "lakedestination"
    $dststoragecontainername = "containerdest"
    $dstBlobName= "path/newfilename.csv"

    $dstStorageContext = New-AzStorageContext -StorageAccountName $dststorageaccountname -StorageAccountKey $dststorageaccountkey

    $dstContainer = Get-AzStorageContainer -Name $dststoragecontainername -Context $dstStorageContext
    $dstBlob = Get-AzStorageBlob -Container  $dstContainer.Name -Context $dstStorageContext -MaxCount 10 -Blob $dstBlobName
    $destBlob =  $srdBlob | Copy-AzStorageBlob  -DestContainer $dstContainer.Name -DestBlob $dstblobname
    ```    
    -   Ohter option is to use azcopy tool (https://github.com/Azure/azure-storage-azcopy/)
        -   Known issue to copy with firewalls : https://github.com/Azure/azure-storage-azcopy/issues/1673 

* How to find soft delete content usage - https://techcommunity.microsoft.com/t5/azure-paas-blog/azure-storage-blob-count-amp-capacity-usage-calculator/ba-p/3516855 

* Sample to map Cloud storage as a network drive on a windows machine
  * Ref: https://learn.microsoft.com/en-us/azure/storage/files/storage-how-to-use-files-windows 
```
$str = $MyCredentialsxyz.GetNetworkCredential().Password
$acctKey = ConvertTo-SecureString -String $str -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential -ArgumentList "Azure\stratustimeprodautomate", $acctKey

New-PSDrive -Name Z -PSProvider FileSystem -Root "\\myStorageAccountName.file.core.windows.net\containername" -Credential $credential -Persist
```
