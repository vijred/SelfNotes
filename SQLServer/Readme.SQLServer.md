SQL Server Info
===============


* [Data Types and its conversion options](https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver15)
* Always-ON -> How to add databases to AG -> https://github.com/vijred/MSSQL/blob/master/AlwaysOn/Add_Database2AG.sql 
* SQL Server Auditing reference
    - https://docs.microsoft.com/en-us/sql/relational-databases/security/auditing/sql-server-audit-database-engine?view=sql-server-ver15
    - https://docs.microsoft.com/en-us/sql/t-sql/statements/drop-server-audit-transact-sql?view=sql-server-2016
    - https://docs.microsoft.com/en-us/sql/t-sql/statements/drop-server-audit-specification-transact-sql?view=sql-server-ver15



T-SQL 101
---------
* List of all databases on SQL Instance
    - `select * from sys.databases`


Stored Procedure
---------
* Find Stored procedure execution history 
```
USE DatabaseName

DECLARE @ProdName NVARCHAR(240) = 'MyProdName'

SELECT TOP 10 d.object_id, d.database_id, OBJECT_NAME(object_id, database_id) 'proc name',   
    d.cached_time, d.last_execution_time, d.total_elapsed_time,  
    d.total_elapsed_time/d.execution_count AS [avg_elapsed_time],  
    d.last_elapsed_time, d.execution_count  
FROM sys.dm_exec_procedure_stats AS d  
WHERE OBJECT_NAME(object_id, database_id) = @ProdName
ORDER BY [total_worker_time] DESC;  
``` 


* SQLCMD reference -> https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility?view=sql-server-ver15
```
-- Sample to execute with Windows Authentication and Multisubnetfailover (-M indicates multisubnetfailover)

SQLCMD.EXE -S "SHP13IMPDB2LSTNR\SHPDB13_SVC,21186" -Q "select @@SERVERNAME" -M 

```

* Reporting Server default URL
    - https://servername.mydomain.com/reportserver
    - https://servername.mydomain.com/Reports


* Give me a good reference to connection strings
    -   https://www.connectionstrings.com/sql-server/
