SQL Server Contained Database Users
===================================

Contained Database option enables database users to authenticate SQL Server and SQL Database connections at the database level removing dependency on master database, and the database can be managed and moved across servers easily.


Reference: https://docs.microsoft.com/en-us/sql/relational-databases/security/contained-database-users-making-your-database-portable?view=sql-server-ver15


* How to enalbe contained database authentication option
```
sp_configure 'contained database authentication', 1;  
GO  
RECONFIGURE;  
GO  
```

