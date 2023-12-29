
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
