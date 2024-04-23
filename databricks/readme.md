Databricks 
=========

* What is Databricks - An open and unified data analytics platform for data engineering, data science, machine learning, and analytics
* Learn more about Databricks - https://www.databricks.com/ 
* Where to start using Databricks
  * Create a Cluster 
  * Create a Notebook in workspace 
  * choose comfortable language (Python , SQL, Scala, R, Markdown) and start working on it
* Databricks UI - what to explore
  * Workspaces
  * Repos
  * Data
  * Compute 
  * Workflows 
  * Clusters 

## scala example 
* Example to display table results 
```
%scala

display(table("hive_metastore.default.quotes_csv"))
display(table("hive_metastore.default.quotes_csv").sort("REQUEST"))
```
* Create a delta table example - 
```
sql("drop table if exists target")
 
val target = Seq(
  Data("a", "0"),
  Data("b", "1"),
  Data("c", "2"),
  Data("d", "3")
).toDF().write.format("delta").mode("overwrite").saveAsTable("target")
 
display(table("target").orderBy("key"))
```

## SQL example 
```
SELECT * FROM hive_metastore.default.quotes_csv
insert into hive_metastore.default.quotes_csv values(53,2,2,2,'no');

CREATE OR REPLACE VIEW  IF NOT EXISTS databasename.viewname
    AS 
SELECT mycol from table
```
* List of spark SQL functions - https://spark.apache.org/docs/latest/api/sql/


## Databricks Datalakehouse 
Catalog: a grouping of databases.
Database or schema: a grouping of objects in a catalog. Databases contain tables, views, and functions.
Table: a collection of rows and columns stored as data files in object storage.
View: a saved query typically against one or more tables or data sources.
Function: saved logic that returns a scalar value or set of rows.


## Delta live table 
https://learn.microsoft.com/en-us/azure/databricks/workflows/delta-live-tables/ 

## Python
* Simplest way to query SQL tables in Python
```
df=spark.sql(f"""SELECT * FROM mydb.mytable""")
df.select("col1","col2").collect()
```
* How to run a file system commands - use `%fs` - Example: `%fs /tmp`
* how to set environmental variables and use it in SQL 
```
%python
myvar1 = "-4.0"
myvar2 = "0.1"

spark.conf.set("var.var1", myvar1)
spark.conf.set("var.var2", myvar2)
```
```
%sql

SELECT lat.col1, * 
from table where 
col3 between ${var.clientcountchangepercentlow} AND ${var.clientcountchangepercenthigh}
```
* How to use Cluster Tags in notebook
```
import json
all_tags = {}
for tag in json.loads(spark.conf.get("spark.databricks.clusterUsageTags.clusterAllTags")):
  all_tags[tag['key']] = tag['value']

notebookenv = all_tags.get('my_environment')
print(notebookenv)
```
* How to pass and access variables 
```
# Pass variables (argument, and argument2 with values data and data2
dbutils.notebook.run("notebookname2", 60, {"argument": "data", "argument2": "data2"})


#read variables
print('this is notebook 2')
try:
  val = print(dbutils.widgets.get("argument"))
except:
  val = 'parameter not passed'

# return a value
dbutils.notebook.exit([0,'val'])
```

* How to use Basic widgets 
```
# View widget UI on notebook - 
dbutils.widgets.text("myargument","initial variable value - this can be edited or passed","Variable Text to display")
dbutils.widgets.get("myargument")
curatedData=getArgument("myargument")

curatedData = curatedData + ' looks good'
print(curatedData)


# Remove the widget
dbutils.widgets.removeAll()

# Sample code to call the notebook by passing the argument
dbutils.notebook.run("vj_test_notebook1", 60, {"myargument": "Value_Passed", "argument2": "data2"})
```

* Databricks resources can be managed and viewed using CLI, CLI needs to be installed for the same. Ref: https://docs.databricks.com/dev-tools/cli/index.html 
  * Once the profile is configured, the detals will be stored in a hidden file. You can see the profile infomration using the powershell command - `Get-Content ~/.databrickscfg`

* Test MSSQL connection from Databricks 
```
driverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
jdbcHostname = "mysqlservername-001.database.windows.net"
#jdbcHostname = "10.10.10.10"
jdbcDatabase = "myDBName"
jdbcPort = "1433"


#jdbcHostname = databaseserver
#jdbcDatabase = databasename
jdbcUsername = "myloginname"
jdbcPassword = "myPasword"
driverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
    
    
jdbcUrlClient = "jdbc:sqlserver://{0}:{1};database={2}".format(jdbcHostname, jdbcPort, jdbcDatabase)
connectionPropertiesClient = {
  "user" : jdbcUsername
  ,"password" : jdbcPassword
  ,"driver" : driverClass
}

dataSourceClientCollection = spark.read.format("jdbc") \
    .option("url", jdbcUrlClient) \
    .option("user", jdbcUsername) \
    .option("password", jdbcPassword) \
    .option("query", f"SELECT * FROM SampleTable") \
    .load()

```

* How to get clusterName and clisterId in notebook
```
spark.conf.get("spark.databricks.clusterUsageTags.clusterName")
spark.conf.get("spark.databricks.clusterUsageTags.clusterId")
```

* Do I have powershell modeule for databricks? - Yes, https://github.com/gbrueckl/Databricks.API.PowerShell/blob/master/README.md 

* How to add a new Datalake mount point using Storage Key 
```

# Check mounts
dbutils.fs.mounts()

# Declare
storage_account_name = "myStorageaccountname"
storage_account_key = "123456789xTP123456789VA0aTrqrpZvEBbOgaO++434343434232323343/434343+354644++KK=="

storage_container_name = "mycontainerName"
mount_point = "/mnt/{}".format(storage_container_name)

# Unmount if necessary
# dbutils.fs.unmount(mount_point)

dbutils.fs.mount(
     source = "wasbs://{0}@{1}.blob.core.windows.net".format(storage_container_name, storage_account_name),
     mount_point = mount_point,
     extra_configs = {"fs.azure.account.key.{0}.blob.core.windows.net".format(storage_account_name): storage_account_key}
    )

# COMMAND ----------
dbutils.fs.mounts()
```

* How to access Datalake data using storage key, and spark.read (Ref: https://docs.databricks.com/storage/azure-storage.html#language-Account%C2%A0key)
```
spark.conf.set("fs.azure.account.key.myStorageaccountname.dfs.core.windows.net","1234567834dsgdsMYSTORAGEACCOUNTKEY+xMYSTORAGEACCOUNTKEYGoMYSTORAGEACCOUNTKEYSdMYSTORAGEACCOUNTKEY8MYSTORAGEACCOUNTKEYcixAA==")

df = spark.read.load('abfss://myContainerName@MyStorageAccountName.dfs.core.windows.net/folderstructure/year=2016/month=12/day=20161210/data_00*.json', format='json')
df.explain(True)
```


* How to access Datalake data using SAS key, and spark.read (Ref: https://docs.databricks.com/storage/azure-storage.html#language-Account%C2%A0key)
```
spark.conf.set("fs.azure.account.auth.type.vj3datalake.dfs.core.windows.net", "SAS")
spark.conf.set("fs.azure.sas.token.provider.type.vj3datalake.dfs.core.windows.net", "org.apache.hadoop.fs.azurebfs.sas.FixedSASTokenProvider")
spark.conf.set("fs.azure.sas.fixed.token.vj3datalake.dfs.core.windows.net", "sp=rwdle&st=2023-05-19T20:26:22Z&se=2024-05-20T04:26:22Z&spr=https&sv=2022-11-02&sr=c&sig=v%2Bm53tgHWOANRm%2Fomiab2Hux6bS1pDAYVWTUfWxMttY%3D")

df = spark.read.load('abfss://vj3datalakefs3@vj3datalake.dfs.core.windows.net/eventhubn1/2023-03-28/12/0_638156016000000000_1.json', format='json')
df.explain(True)
```


* Last way is to use Azure Service principal to acccess Azure Datalake 
```
service_credential = dbutils.secrets.get(scope="<scope>",key="<service-credential-key>")

spark.conf.set("fs.azure.account.auth.type.<storage-account>.dfs.core.windows.net", "OAuth")
spark.conf.set("fs.azure.account.oauth.provider.type.<storage-account>.dfs.core.windows.net", "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider")
spark.conf.set("fs.azure.account.oauth2.client.id.<storage-account>.dfs.core.windows.net", "<application-id>")
spark.conf.set("fs.azure.account.oauth2.client.secret.<storage-account>.dfs.core.windows.net", service_credential)
spark.conf.set("fs.azure.account.oauth2.client.endpoint.<storage-account>.dfs.core.windows.net", "https://login.microsoftonline.com/<directory-id>/oauth2/token")
```

* How to create a scope in Databricks Workspace? - https://databricks-instance-name#secrets/createScope
  * Ref: https://learn.microsoft.com/en-us/azure/databricks/security/secrets/secret-scopes
 
* How to list all secret scopes? dbutils.secrets.listScopes() 

* Tell me about Databricks CLI
  * Databricks Command-Line Interface is easy to use from Terminal  command prompt.
  * Databricks CLI needs to be installed on system and configured for given workspace
  * cli installation and configuration instructions can be found @ https://learn.microsoft.com/en-us/azure/databricks/dev-tools/cli/
  * How to view commands (help) - `databricks configure --help` or `databricks --help`
  * Default location of configuration file in windows - `%USERPROFILE%\.databrickscfg` (`~/.databrickscfg` in linux)
  * Sample command to give Scope Read access to a Databricks Group
  ```
  databricks groups list
  databricks secrets list-scopes
  databricks secrets put-acl --scope myScopeName --principal MyDatabricksGroupName --permission READ
  ```

* Is there any ODBC Driver for Databricks
  - Yes, Download from - https://www.databricks.com/spark/odbc-drivers-download 
  - What is the architecture - https://www.databricks.com/blog/2021/08/11/how-we-achieved-high-bandwidth-connectivity-with-bi-tools.html
  - Is there any opiton to switch to old architecture? Yes, use this parameter - `EnableQueryResultDownload="0"`
  - Ref: https://stackoverflow.com/questions/77723648/databricks-odbc-driver-fails-if-number-of-rows-are-exceeding-the-limit 

* Uncommon problems-
  - Web browser authentication issues while connecting from on-premise servers connecting to a secured private endpointed Databricks workspace.
    -  Fix using the recommendation listed in the documentation: https://learn.microsoft.com/en-us/azure/databricks/security/network/classic/private-link-simplified
    -  Create a forwarder to address the problem
   
* Sample code to install ODBC Drivers on a server, pull Databricks delta live table infomrtaion
```
Get-Date
$dnsName= "DevODBCConnectionName"
$user="token"
$password="dapidasdfdsfdsfdsfdsafdsfdsafdsf-3"
$sqlQuery= "select * from delta_lake_name.tablename limit 6"

$conn = New-Object Data.Odbc.OdbcConnection
$conn.ConnectionString= "dsn=$dnsName;uid=$user;pwd=$password;"
$conn.open()
$command =$conn.CreateCommand();
$command.CommandText=$sqlQuery

$dataAdapter = New-Object System.Data.Odbc.OdbcDataAdapter $command

$dataTable = new-object "System.Data.DataTable"
$dataAdapter.Fill($dataTable)
$conn.close()

$dataTable.rows.count
$dataTable.rows[4]
```
