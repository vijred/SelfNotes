Oracle
======


* Uesr Information
```
-- Find a user 
SELECT * FROM ALL_USERS
where USERNAME = 'OPS$USERNAME';

-- Find Current user , Login information
SELECT * FROM user_users;


-- All user details
SELECT * FROM DBA_USERS
ORDER BY created DESC;

```

* How to find all tables in all Schemas 
```
SELECT DISTINCT OWNER, OBJECT_NAME 
  FROM DBA_OBJECTS
 WHERE OBJECT_TYPE = 'TABLE'
 -- AND OBJECT_NAME = 'myTableName'
 ```

* Verify account last access date and Lock information
```
select username, account_status, lock_date ,last_Login from dba_users where account_status='LOCKED' order by lock_date desc;
```

* Find Oracle Server name
```
SELECT host_name
FROM v$instance;
```

* Unlock a user account
```
alter user MyUserName account unlock;
```

* USer Profile information - Example, number of attempts before account locks
```
SELECT resource_name, limit
FROM dba_profiles 
WHERE profile = 'DEFAULT'
AND resource_type = 'PASSWORD';
```

* List Audit sessions
```
select * from SYS.DBA_AUDIT_SESSION;
```


