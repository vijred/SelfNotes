Azure SQL Access related
=======================

* Creating new user and giving access to a database
```
USE Master
CREATE LOGIN newUser WITH PASSWORD = 'myNewPassword'
CREATE USER newUser FOR LOGIN newUser WITH DEFAULT_SCHEMA=[dbo]; 

User Database
CREATE USER newUser FOR LOGIN newUser WITH DEFAULT_SCHEMA=[dbo];
EXEC sp_addrolemember 'db_owner', 'newUser';
```

* Check if a login/User exists in master database
```
IF NOT EXISTS (select name from sys.sql_logins where name = 'LoginName')
BEGIN
    PRINT 'LoginName does not exists'
END


IF NOT EXISTS (select * from sys.database_principals where name = 'UserName' and type in ('S','U','G')
BEGIN
    PRINT 'USer does not exist'
END
```


* Update DBOwner in Azure Database 
```
ALTER AUTHORIZATION ON DATABASE::USERDATABASENAME to [ACCOUNTNAME]; 

-- NOTE: AFTER THE CHANGE, make sure to compare SID is same 
USE MASTER 
SELECT name, sid FROM sys.sql_logins where name = 'ACCOUNTNAME'
 
USE USERDATABASENAME 
SELECT name, sid FROM sys.sysusers where name = 'dbo'
```



-- if login @Guardium_user exists, create user @Guardium_user
	PRINT 'Add user @Guardium_user if it does not exist'
	SELECT  @executeString ='IF NOT EXISTS (select * from sys.database_principals where name = ''' + @Guardium_user + ''' and type in (''S'',''U'',''G'')) ' +
             'BEGIN ' +
             'PRINT ''==> Adding user [' + @Guardium_user + '] to database: ' + @databaseName + ''' ' +
			 'PRINT '' ''' +
             /* 'execute sp_adduser [' + @Guardium_user + '] ' +    This syntax no longer work for adding security group login to database  */
             'create user [' + @Guardium_user + '] ' + ' for login [' + @Guardium_user + '] ' + '
			 END'
		EXEC (@executeString)


