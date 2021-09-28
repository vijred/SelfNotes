Oracle Sessions
===============


* Use Toadd to find Sessions on Oracle database 
    - Database -> Monitor -> Session Browser
* Use SQL Statement to find Sessions
    - Table `select * from gv$session`
    - Sample : `select sid,program, 'SERIAL#' from gv$session  where upper(program) like 'RMAN%';`
    - Sample : `select username, inst_id,sid,serial# from gv$session where username='OPS$ORACLE'`
    - Example : Kill hung RMAN sessions (Backup orocess) 
* Kill a session
    - Use Toadd: Database -> Monitor -> Session Browser -> Right click and kill the session 
    - `ALTER SYSTEM KILL SESSION 'sid,serial#'`;
