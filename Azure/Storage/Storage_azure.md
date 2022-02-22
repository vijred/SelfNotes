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
