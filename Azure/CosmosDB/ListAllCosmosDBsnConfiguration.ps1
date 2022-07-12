
# Pull list of CosmosDBs and their capacity configuration

$cosmosDBArray = @()
$cosmosContainerArray = @()

$arraysubscriptions = Get-AzSubscription
foreach($subscriptionName in $arraysubscriptions.Name){

    Select-AzSubscription -Subscription $subscriptionName

    write-host "Subscription - $subscriptionName"

    $rgs = Get-AzResourceGroup
    foreach ($itemrg in $rgs) {
        # write-host "Resource gorup - $($itemrg[0].ResourceGroupName)"
        $Cosmosdbaccounts = Get-AzCosmosDBAccount -ResourceGroupName $itemrg.ResourceGroupName
        if($null -ne $Cosmosdbaccounts){
            Write-Host "Resource gorup - $($itemrg.ResourceGroupName)"
            foreach ($itemCosmosDBAccount in $Cosmosdbaccounts){
                #$itemCosmosDBAccount.Name
                write-host "CosmosDB Account - $($itemCosmosDBAccount.Name)"
                write-host "CosmosDB Account ReadLocations count - $($itemCosmosDBAccount.ReadLocations.Count)"
                write-host "CosmosDB Account WriteLocations count - $($itemCosmosDBAccount.WriteLocations.Count)"
                $cosmosDBs = $itemCosmosDBAccount | Get-AzCosmosDBSqlDatabase
                foreach($ItemCosmosDB in $cosmosDBs){
                    write-host "CosmosDatabase - $($ItemCosmosDB.Name) "
                    try {
                        $tp = Get-AzCosmosDBSqlDatabaseThroughput -ResourceGroupName $($itemrg.ResourceGroupName) -AccountName $($itemCosmosDBAccount.Name) -Name $($ItemCosmosDB.Name) -WarningAction Ignore  -ErrorAction Ignore
                        if($null -ne $tp){
                            write-host "Database Throughput - $($tp.Throughput)"
                            write-host "Database Throughput.AutoscaleSetting.MaxThroughput - $($tp.AutoscaleSettings.MaxThroughput)"        
                            $objCosmosDB = New-Object -TypeName PSObject;
                            Add-Member -InputObject $objCosmosDB -MemberType NoteProperty -Name SubscriptionName -Value $subscriptionName;
                            Add-Member -InputObject $objCosmosDB -MemberType NoteProperty -Name CosmosDBAccountName -Value $($itemCosmosDBAccount.Name);
                            Add-Member -InputObject $objCosmosDB -MemberType NoteProperty -Name CosmosDBAccountReadRegions -Value $($itemCosmosDBAccount.ReadLocations.Count);
                            Add-Member -InputObject $objCosmosDB -MemberType NoteProperty -Name CosmosDBAccountWriteRegions -Value $($itemCosmosDBAccount.WriteLocations.Count);
                            Add-Member -InputObject $objCosmosDB -MemberType NoteProperty -Name CosmossqlDatabasename -Value $($ItemCosmosDB.Name);
                            Add-Member -InputObject $objCosmosDB -MemberType NoteProperty -Name Throughput -Value $($tp.Throughput);
                            Add-Member -InputObject $objCosmosDB -MemberType NoteProperty -Name AutoscaleMaxThroughput -Value $($tp.AutoscaleSettings.MaxThroughput);
                            $cosmosDBArray += $objCosmosDB
                        } else {
                            $objCosmosDB = New-Object -TypeName PSObject;
                            Add-Member -InputObject $objCosmosDB -MemberType NoteProperty -Name SubscriptionName -Value $subscriptionName;
                            Add-Member -InputObject $objCosmosDB -MemberType NoteProperty -Name CosmosDBAccountName -Value $($itemCosmosDBAccount.Name);
                            Add-Member -InputObject $objCosmosDB -MemberType NoteProperty -Name CosmosDBAccountReadRegions -Value $($itemCosmosDBAccount.ReadLocations.Count);
                            Add-Member -InputObject $objCosmosDB -MemberType NoteProperty -Name CosmosDBAccountWriteRegions -Value $($itemCosmosDBAccount.WriteLocations.Count);
                            Add-Member -InputObject $objCosmosDB -MemberType NoteProperty -Name CosmossqlDatabasename -Value $($ItemCosmosDB.Name);
                            Add-Member -InputObject $objCosmosDB -MemberType NoteProperty -Name Throughput -Value 0;
                            Add-Member -InputObject $objCosmosDB -MemberType NoteProperty -Name AutoscaleMaxThroughput -Value 0;
                            $cosmosDBArray += $objCosmosDB
                        }
                        }
                        catch {
                            write-host "Database Throughput - Not Configured"
                        }
        
                    $CosmosDBsqlContainers = $ItemCosmosDB| Get-AzCosmosDBSqlContainer
                    foreach ($itemCosmosDBsqlContainer in $CosmosDBsqlContainers) {
                        write-host "sqlContainer - $($itemCosmosDBsqlContainer.Name)" 

                        try{
                            $tp = $itemCosmosDBsqlContainer | Get-AzCosmosDBSqlContainerThroughput -WarningAction Ignore -ErrorAction Ignore
                            if($null -ne $tp){
                                write-host "Container Throughput - $($tp.Throughput)"
                                write-host "Container Throughput.AutoscaleSetting.MaxThroughput - $($tp.AutoscaleSettings.MaxThroughput)"        
                                $objCosmosDBContainer = New-Object -TypeName PSObject;
                                Add-Member -InputObject $objCosmosDBContainer -MemberType NoteProperty -Name SubscriptionName -Value $subscriptionName;
                                Add-Member -InputObject $objCosmosDBContainer -MemberType NoteProperty -Name CosmosDBAccountName -Value $($itemCosmosDBAccount.Name);
                                Add-Member -InputObject $objCosmosDBContainer -MemberType NoteProperty -Name CosmosDBAccountReadRegions -Value $($itemCosmosDBAccount.ReadLocations.Count);
                                Add-Member -InputObject $objCosmosDBContainer -MemberType NoteProperty -Name CosmosDBAccountWriteRegions -Value $($itemCosmosDBAccount.WriteLocations.Count);
                                Add-Member -InputObject $objCosmosDBContainer -MemberType NoteProperty -Name CosmossqlDatabasename -Value $($ItemCosmosDB.Name);
                                Add-Member -InputObject $objCosmosDBContainer -MemberType NoteProperty -Name CosmosContainerename -Value $($itemCosmosDBsqlContainer.Name);
                                Add-Member -InputObject $objCosmosDBContainer -MemberType NoteProperty -Name Throughput -Value $($tp.Throughput);
                                Add-Member -InputObject $objCosmosDBContainer -MemberType NoteProperty -Name AutoscaleMaxThroughput -Value $($tp.AutoscaleSettings.MaxThroughput);
                                $cosmosContainerArray += $objCosmosDBContainer   
                            } else {
                                $objCosmosDBContainer = New-Object -TypeName PSObject;
                                Add-Member -InputObject $objCosmosDBContainer -MemberType NoteProperty -Name SubscriptionName -Value $subscriptionName;
                                Add-Member -InputObject $objCosmosDBContainer -MemberType NoteProperty -Name CosmosDBAccountName -Value $($itemCosmosDBAccount.Name);
                                Add-Member -InputObject $objCosmosDBContainer -MemberType NoteProperty -Name CosmosDBAccountReadRegions -Value $($itemCosmosDBAccount.ReadLocations.Count);
                                Add-Member -InputObject $objCosmosDBContainer -MemberType NoteProperty -Name CosmosDBAccountWriteRegions -Value $($itemCosmosDBAccount.WriteLocations.Count);
                                Add-Member -InputObject $objCosmosDBContainer -MemberType NoteProperty -Name CosmossqlDatabasename -Value $($ItemCosmosDB.Name);
                                Add-Member -InputObject $objCosmosDBContainer -MemberType NoteProperty -Name CosmosContainerename -Value $($itemCosmosDBsqlContainer.Name);
                                Add-Member -InputObject $objCosmosDBContainer -MemberType NoteProperty -Name Throughput -Value 0;
                                Add-Member -InputObject $objCosmosDBContainer -MemberType NoteProperty -Name AutoscaleMaxThroughput -Value 0;
                                $cosmosContainerArray += $objCosmosDBContainer   
                            }
                        }
                        catch{
                            write-host "Container Throughput - Not Configured"
                        }
                    }
                }
            }
        #break;
        }
    }
}

$cosmosDBArray | export-csv -Path "c:\temp\Databases2.csv"
$cosmosContainerArray | export-csv -Path "c:\temp\Containers2.csv"
