Oracle Performance related info
===============================


Tips:
-----
* How to use SET FEEDBACK to get SQL_ID of executed statement 
    - Syntax ` SET FEEDBACK {n | ON | OFF | ONLY} [SQL_ID]`
    - Example 
```
SQL> set feedback on sql_id
SQL> select * from dual;

D
-
X

1 row selected.

SQL_ID: b6hs9fhw2v0v3
```
