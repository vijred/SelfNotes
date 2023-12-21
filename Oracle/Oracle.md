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


* SQL statemetns for Storage 
```
select sum(bytes)/1024/1024 size_in_mb from dba_data_files
select * from dba_segments order by BYTES DESC
```

* Sample trigger to capture login failures
```
DROP TABLE OPS$ORACLE.STATS$USER_LOGINFAIL CASCADE CONSTRAINTS;

CREATE TABLE OPS$ORACLE.STATS$USER_LOGINFAIL
(
  USER_ID             VARCHAR2(100 BYTE),
  HOST                VARCHAR2(255 BYTE),
  OS_USERNAME         VARCHAR2(255 BYTE),
  EXTENDED_TIMESTAMP  DATE
)
;


CREATE OR REPLACE TRIGGER ops$oracle.failed_logon_trg
  AFTER SERVERERROR ON DATABASE
WHEN (
ora_server_error(1)=1017
      )
BEGIN
   insert into stats$USER_LOGINFAIL
      (user_id, host, os_username, extended_timestamp)
   values
      (SYS_CONTEXT ('USERENV','AUTHENTICATED_IDENTITY'),
      SYS_CONTEXT('USERENV','host'),
      SYS_CONTEXT('USERENV','OS_USER'),
      sysdate);
      COMMIT;
END failed_logon_trg
;

```
* Toad - Can be configured to execute the SQL Statements in threads, background threads. This allows to execute multiple statements. Settigns cna be found in View -> Toad Options -> Oracle -> Transactions -> [Execute queries in threads (creates seperate session)]

* Learning Oracle pointers 
  - https://education.oracle.com/
  - https://learn.oracle.com/ols/learning-path/become-an-oci-architect-associate/35644/98012
  
