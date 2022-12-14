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
