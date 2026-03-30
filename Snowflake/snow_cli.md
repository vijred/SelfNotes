SNOW CLI 
=======


A quick way to get the list of sample select statements on a sample tables.

```powershell
# We force PowerShell to treat the JSON as an array by using @(...) 
$tables = (snow sql -c "myConnection_name" -q "SHOW TABLES IN ACCOUNT" --format json | ConvertFrom-Json)

# Now we loop through only the first 3
$tables | Select-Object -First 3 | ForEach-Object {
    "Select * from $($_.database_name).$($_.schema_name).$($_.name) LIMIT 2;"
}
```

Sample Connection file (Sample location: C:\Users\username\AppData\Local\snowflake\config.toml)
```
[connections.SampleConnectionname]
account = "gfa12121.east-us-2.azure"
user = "myusername"
password = "UserPAT"
database = "myDatabase"
schema = "MySchema"
warehouse = "MyWarehosue"
role = "MyRole"
```

Sample SNOW Command to query data 
`snow sql -c "myconnection" -q "Select * from myDB.mySchema.myTable LIMIT 2;"`


* How to add anew conneciton
```
snow connection add my_conn \
  --account myaccount \
  --user myuser \
  --role SYSADMIN \
  --warehouse COMPUTE_WH \
  --database DEMO_DB \
  --schema PUBLIC
```
* Test Connection
`snow connection test my_conn`

### Run SQL 
* Show existing connection details
```
snow sql -q "
USE ROLE SYSADMIN;
USE WAREHOUSE COMPUTE_WH;
USE DATABASE DEMO_DB;
USE SCHEMA PUBLIC;

SELECT 
    CURRENT_USER(),
    CURRENT_ROLE(),
    CURRENT_WAREHOUSE(),
    CURRENT_DATABASE(),
    CURRENT_SCHEMA();
" --connection my_conn
```
* Execute SQL from a file
`snow sql -f create_tables.sql --connection my_conn`

###File Management
* Upload a local file to Staging
```
snow stage put ./data/sales.csv @my_stage --connection my_conn
snow stage put ./data/*.csv @my_stage --connection my_conn
```
* List files in stage
`snow stage list @my_stage --connection my_conn`
* Load data from a stage into a table
```
snow sql -q "
COPY INTO sales
FROM @my_stage/sales.csv
FILE_FORMAT = (TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY='\"')
" --connection my_conn
```
* Download a file from Stage
`snow stage get @my_stage/sales.csv ./downloads --connection my_conn`

### List Snowflake Objects
* List Stages, tables, etc
```
snow sql -q "SHOW STAGES" --connection my_conn
snow sql -q "SHOW TABLES" --connection my_conn
snow sql -q "SHOW SHARES" --connection my_conn
snow sql -1 "SHOW DATABASES" --connection my_con

```
* 
* 
* 
