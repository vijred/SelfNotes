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
