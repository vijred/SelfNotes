
# Azure SQL Database - Readme


## Good blog with 150+ Lessons learned 
https://techcommunity.microsoft.com/t5/azure-database-support-blog/bg-p/AzureDBSupport

## Very good reference to frequently used SQL commands 
https://vijredblog.wordpress.com/2016/10/27/sql-commands-in-azure/


## Azure Database configurations
* How to viw the configurations
```
select * from sys.database_scoped_configurations
select * from sys.configurations
```
* How to update database configurations
    - `ALTER DATABASE SCOPED CONFIGURATION`; Ref:  https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-database-scoped-configuration-transact-sql?view=sql-server-ver15



