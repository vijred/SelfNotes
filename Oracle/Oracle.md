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
