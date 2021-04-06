Azure SQL Access related
=======================

* [Microsoft documentation on Security catalog views](https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/security-catalog-views-transact-sql?view=sql-server-ver15)
* Basic tables that can be used to pull the infomration
    - Fundamental difference between 
```
-- Server Role permissions, not for Azure Database 
SELECT * FROM sys.server_principals -- Not aware of any usecase how this is used in Azure Database
SELECT * FROM sys.server_role_members -- Not aware of any usecase how this is used in Azure Database

-- Only on Master database, lists SQL Logins only (Not AD accounts) 
SELECT * FROM sys.sql_logins

-- Database level permissions
SELECT * FROM sys.database_principals 
SELECT * FROM sys.database_role_members 
SELECT * FROM sys.database_permissions 
```



Understand permissions with examples
------------------------------------
* List all users who have access to SQL Database 
```
select * from sys.database_principals 
where type in ('S','U','G','C','K','X') 
--A = Application role
--C = User mapped to a certificate
--E = External user from Azure Active Directory
--G = Windows group
--K = User mapped to an asymmetric key
--R = Database role
--S = SQL user
--U = Windows user
--X = External group from Azure Active Directory group or applicatio
```
* Find all user Role members 
```
SELECT DP1.name AS DatabaseRoleName,   
   isnull (DP2.name, 'No members') AS DatabaseUserName   
 FROM sys.database_role_members AS DRM  
 RIGHT OUTER JOIN sys.database_principals AS DP1  
   ON DRM.role_principal_id = DP1.principal_id  
 LEFT OUTER JOIN sys.database_principals AS DP2  
   ON DRM.member_principal_id = DP2.principal_id  
WHERE DP1.type = 'R'
ORDER BY DP1.name;  
```
* List all Object level permissions only 
```
SELECT pr.principal_id, pr.name, pr.type_desc,   
    pr.authentication_type_desc, pe.state_desc,   
    pe.permission_name, s.name + '.' + o.name AS ObjectName  
FROM sys.database_principals AS pr  
JOIN sys.database_permissions AS pe  
    ON pe.grantee_principal_id = pr.principal_id  
JOIN sys.objects AS o  
    ON pe.major_id = o.object_id  
JOIN sys.schemas AS s  
    ON o.schema_id = s.schema_id
```
* List all Schema level permisisons 
```
	SELECT pr.principal_id, pr.name, pr.type_desc,   
    pr.authentication_type_desc, pe.state_desc,   
    pe.permission_name, s.name as SchemaName
FROM sys.database_principals AS pr  
JOIN sys.database_permissions AS pe  
    ON pe.grantee_principal_id = pr.principal_id  
JOIN sys.schemas AS s  
    ON pe.major_id = s.schema_id
	ORDER BY 1 
```





Making changes
-------------
* Creating new SQL_user and giving access to db_owner role on a database
```
USE Master
CREATE LOGIN newUser WITH PASSWORD = 'myNewPassword'
CREATE USER newUser FOR LOGIN newUser WITH DEFAULT_SCHEMA=[dbo]; 

User Database
CREATE USER newUser FOR LOGIN newUser WITH DEFAULT_SCHEMA=[dbo];
EXEC sp_addrolemember 'db_owner', 'newUser';
```
* How to remove a uer from a given role
```
Use DatabaseName
EXEC sp_droprolemember 'db_owner', [UserName];
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





