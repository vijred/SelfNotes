
* Simple and dirty way to read the data from a sample file and add it into deltalive table. 
```
datalakeStorage = 'fs.azure.account.key.myadraccountname.dfs.core.windows.net'
datalakeStorageShortName = 'myazureaccountname'
datalakeStorageKey = 'safdsaadsa/adsfdsfds/asdfdsafdsfdfadsafsdf+asfdsfds+sadf/af+afdfdsa=='
spark.conf.set(datalakeStorage,datalakeStorageKey)

myFile = spark.read.options(delimiter="|").csv("abfss://temp@" + datalakeStorageShortName + ".dfs.core.windows.net/path1/path2.csv", header=True)

#display(verifyFile)
myFile.write.mode("append").format("delta").saveAsTable("myTableName")
```

* Inteersting Demo and workshop material about Databricks Realtime decision making
  - https://now.informatica.com/data-engineering-summit-agenda.html?aliId=eyJpIjoiNDZPMjVra2dNZG90MFZkTSIsInQiOiJJUnVcL2VrRHBDNkRhNnlSV3ZYRkpvQT09In0%253D
  - Github repo erference - https://github.com/databricks/tmm/tree/main/Pipelines-Workshop

* Error while creating a table, Summary of error - `Unable to cretae table, the location already exists and it is not a delta table`
  * Fix is to manually delete the emptu location of the directory using `%rm -r "/dbfs/user/hive/warehouse/schemaname.db/tablename"`

* How to disable Deletion vector on a Delta table
```
ALTER TABLE <table_name> SET TBLPROPERTIES (delta.enableDeletionVectors=false)
REORG TABLE <table_name> APPLY(PURGE)
```

* SQL, how to write a qery on an aray - Example, Returns rows where at least one element in an array column matches any value in a target list
```
SELECT *
FROM your_table
WHERE arrays_overlap(
  to_email_list, 
  array('email1@domain.com', 'email2@domain.com', 'email3@domain.com')
)
```
