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
