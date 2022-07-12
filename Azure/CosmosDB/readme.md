
========

APIs 
----
* SQL API  
* Cassandra API  
* Gremlin API  
* Table API  
* Azure Cosmos DB API for MongoDB



cosmosdb using powershell
-------------------------
* Module name - `cosmosdb`

* Sample cosmosdb commands 
    -   Get-CosmosDbAccount
    -   Get-CosmosDbAccount
    -   Get-CosmosDbCollection
    -   Get-CosmosDbDocument

* Example

```

$resourceGroupName = "sample-cosmos"
$cosmosDbAccountName = "sample-vj-cosmos"
$databaseName = "sample-db1"
$cosmosDbContext = New-CosmosDbContext -Account $cosmosDbAccountName -Database $databaseName -ResourceGroup $resourceGroupName    

Get-CosmosDbAccount
Get-CosmosDbAccount -Name "sample-cosmos" -ResourceGroupName $resourceGroupName 
Get-CosmosDbCollection -Context $cosmosDbContext
Get-CosmosDbDocument -Context $cosmosDbContext -CollectionId container2


# insert a document 
$document = @"
{
        "name": "vijay"
}
"@
New-CosmosDbDocument -Context $cosmosDbContext -CollectionId container2  -DocumentBody $document -Verbose -PartitionKey "vijay"


# Insert multiple documents 
for($i=0;$i -lt 1000; $i++)
{
    $partitionvalue = "vijay$($i)"
    $document=@"
    {
    "id": "$([Guid]::NewGuid().ToString())",
            "name": "$($partitionvalue)",
            "Insertdatetime": "$(get-date)"
    }
"@
    New-CosmosDbDocument -Context $cosmosDbContext -CollectionId container2  -DocumentBody $document -Verbose -PartitionKey $partitionvalue
}

# More examples: Get-help New-CosmosDbDocument -example 
```

* Cosmosdb documentation 
    -   https://docs.microsoft.com/en-us/azure/cosmos-db/ 

How to - CosmosDB
=================

* Cosmosdb Security 
    -   https://docs.microsoft.com/en-us/azure/cosmos-db/secure-access-to-data
* configure RBAC to cosmosdb
    -   https://docs.microsoft.com/en-us/azure/cosmos-db/how-to-setup-rbac#role-definitions
* Cosmosdb Roles and permissions 
    -   https://docs.microsoft.com/en-us/azure/role-based-access-control/resource-provider-operations#microsoftdocumentdb 
* List all CosmosDBs in all subscriptions you own and their capacity configuration
    -   https://github.com/vijred/SelfNotes/blob/master/Azure/CosmosDB/ListAllCosmosDBsnConfiguration.ps1 
 
 
