# Common SQL Commands in Azure



## Reanem a database 
```
ALTER DATABASE [OldDBName] MODIFY NAME = [NewDBName]];
```


## How to check if a database is Azure Database or not
```
PRINT 'Check if the database is SQL Azure database'
IF CAST(SERVERPROPERTY('Edition') as nvarchar (128)) NOT LIKE '%Azure%'
BEGIN
    PRINT 'This is NOT a SQL Azure Instance'
END
ELSE
BEGIN
    PRINT 'This IS a SQL Azure Instance'
END
```


