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
