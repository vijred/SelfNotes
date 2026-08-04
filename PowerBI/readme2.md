PowerBI
=======

* How to access PowerBI on cloud - https://app.powerbi.com/
* PowerBI app can be installed on Desktop for full stack usage 
* Azure cost analysis - Tag usage - How to use Tags 
  * Fix is to add a custom column with following equation `= "{"&[Tags]&"}"`
    * Ref: https://www.linkedin.com/pulse/convert-azure-tags-cost-reporting-power-bi-fix-anders-keis-hansen-/
* How to handle nulls while adding a new column to dataset
  * Sample - https://community.powerbi.com/t5/Desktop/Handle-null-values-in-custom-column/m-p/464852 
    ```
    if [ColumnA] = null or [ColumnB] = null then null
    else if  [ColumnA] < [ColumnB] then 0 
    else [ColumnA] - [ColumnB]`
    ````

* How to read multiple files but read only most recent file from each folder 
  * The process is well documented at https://www.heyniels.com/2020/07/how-can-i-process-last-file-from.html
  
 * How to create a report and push it to http://poweri.com
   * Use PowerBI Desktop version
   * Get data (Configure where to read the data from) 
   * Transform the data 
   * Edit the query to do anything that is required (Add calcualted columsn, join queries, remove columns, transform, calculate based on conditions, Machine Learning)
   * Create a report using the fields 
   * Publish the report to https://Powerbi.com
   * Refresh the data in https://Powerbi.com
   * Configure Auto-refresh if necessary

* Sample PowerBI Report for Azure costs (Old version, prior to May 2026)
```text
let
    Source = AzureStorage.DataLake("https://mydatalake.dfs.core.windows.net//Cost"),
    #"Merged Queries" = Table.NestedJoin(Source, {"Date modified", "Folder Path"}, LatestCreateDatePerFolder, {"Date modified", "Folder Path"}, "LatestCreateDatePerFolder", JoinKind.RightOuter),
    #"Filtered Hidden Files1" = Table.SelectRows(#"Merged Queries", each [Attributes]?[Hidden]? <> true),
    #"Invoke Custom Function1" = Table.AddColumn(#"Filtered Hidden Files1", "Transform File", each #"Transform File"([Content])),
    #"Renamed Columns1" = Table.RenameColumns(#"Invoke Custom Function1", {"Name", "Source.Name"}),
    #"Removed Other Columns1" = Table.SelectColumns(#"Renamed Columns1", {"Source.Name", "Transform File", "Date modified"}),
    #"Expanded Table Column1" = Table.ExpandTableColumn(#"Removed Other Columns1", "Transform File", Table.ColumnNames(#"Transform File"(#"Sample File"))),
    #"Changed Type" = Table.TransformColumnTypes(#"Expanded Table Column1",{{"Source.Name", type text}, {"InvoiceSectionName", type text}, {"AccountName", type text}, {"AccountOwnerId", type text}, {"SubscriptionId", type text}, {"SubscriptionName", type text}, {"ResourceGroup", type text}, {"ResourceLocation", type text}, {"Date", type date}, {"ProductName", type text}, {"MeterCategory", type text}, {"MeterSubCategory", type text}, {"MeterId", type text}, {"MeterName", type text}, {"MeterRegion", type text}, {"UnitOfMeasure", type text}, {"Quantity", type number}, {"EffectivePrice", type number}, {"CostInBillingCurrency", type number}, {"CostCenter", type any}, {"ConsumedService", type text}, {"ResourceId", type text}, {"Tags", type text}, {"OfferId", type text}, {"AdditionalInfo", type text}, {"ServiceInfo1", type any}, {"ServiceInfo2", type text}, {"ResourceName", type text}, {"ReservationId", type any}, {"ReservationName", type any}, {"UnitPrice", type number}, {"ProductOrderId", type any}, {"ProductOrderName", type any}, {"Term", type any}, {"PublisherType", type text}, {"PublisherName", type any}, {"ChargeType", type text}, {"Frequency", type text}, {"PricingModel", type text}, {"AvailabilityZone", type any}, {"BillingAccountId", Int64.Type}, {"BillingAccountName", type text}, {"BillingCurrencyCode", type text}, {"BillingPeriodStartDate", type date}, {"BillingPeriodEndDate", type date}, {"BillingProfileId", Int64.Type}, {"BillingProfileName", type text}, {"InvoiceSectionId", type any}, {"IsAzureCreditEligible", type logical}, {"PartNumber", type text}, {"PayGPrice", type number}, {"PlanName", type any}, {"ServiceFamily", type text}, {"CostAllocationRuleName", type any}, {"benefitId", type any}, {"benefitName", type any}}),
    #"Replace Null Tags with empty" = Table.ReplaceValue(#"Expanded Table Column1",null,"",Replacer.ReplaceValue,{"Tags"}),
    #"Added Custom" = Table.AddColumn(#"Replace Null Tags with empty", "JSONTags", each "{"&[Tags]&"}"),
    #"Parsed JSON" = Table.TransformColumns(#"Added Custom",{{"JSONTags", Json.Document}}),
    #"Expanded JSONTags" = Table.ExpandRecordColumn(#"Parsed JSON", "JSONTags", {"payx_application", "payx_environment", "payx_application_dbrcluster", "x_payx_application", "payx_application_dbpool"}, {"JSONTags.payx_application", "JSONTags.payx_environment", "JSONTags.payx_application_dbrcluster", "JSONTags.x_payx_application", "JSONTags.payx_application_dbpool"}),
    #"Added Conditional Column" = Table.AddColumn(#"Expanded JSONTags", "dae_payx_application", each if [JSONTags.payx_application_dbpool] = null then (if [JSONTags.payx_application_dbrcluster] = null then (if [JSONTags.x_payx_application] = null then [JSONTags.payx_application] else [JSONTags.x_payx_application]) else [JSONTags.payx_application_dbrcluster]) else [JSONTags.payx_application_dbpool]),
    #"Added Custom2" = Table.AddColumn(#"Added Conditional Column", "JSONAdditionalInfo", each if [AdditionalInfo] = "" then "{}" else [AdditionalInfo]),
    #"Parsed JSON2" = Table.TransformColumns(#"Added Custom2",{{"JSONAdditionalInfo", Json.Document}}),
    #"Expanded JSONTags2" = Table.ExpandRecordColumn(#"Parsed JSON2", "JSONAdditionalInfo", {"PoolName", "PoolAllocationMode", "ComputeTargetName"}, {"AdditionalInfo.PoolName", "AdditionalInfo.PoolAllocationMode", "AdditionalInfo.ComputeTargetName"}),
    #"Added Conditional Column1" = Table.AddColumn(#"Expanded JSONTags2", "MLComputeInstanceName", each if [AdditionalInfo.PoolName] = null then [AdditionalInfo.ComputeTargetName] else [AdditionalInfo.PoolName]),
    #"Merged Queries1" = Table.NestedJoin(#"Added Conditional Column1", {"MLComputeInstanceName"}, MLCompute2TagMapping, {"MLComputeName"}, "MLCompute2TagMapping", JoinKind.LeftOuter),
    #"Expanded MLCompute2TagMapping" = Table.ExpandTableColumn(#"Merged Queries1", "MLCompute2TagMapping", {"MLTag"}, {"ComputeMap.MLTag"}),
    Custom1 = Table.AddColumn(#"Expanded MLCompute2TagMapping", "mytag_application_2", each if [ComputeMap.MLTag] = null then [mytag_application] else [ComputeMap.MLTag])
in
    Custom1
```

* 
