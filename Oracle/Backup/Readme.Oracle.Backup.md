Oracle Backup information
=========================



* Command for Oracle backups -> `rman`
* check if a backup is in progress -> `ps -ef |grep -i rman`
* Check from DB is backup/rman is running -> `select sid,program from gv$session  where upper(program) like 'RMAN%';`
* Kill a session using Toadd or using SQL `ALTER SYSTEM KILL SESSION 'sid,serial#'`

Credit: [Vijay Kundanagurthi](http://twitter.com/vijred)
