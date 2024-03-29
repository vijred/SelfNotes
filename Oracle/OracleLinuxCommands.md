Oracle Linux Commands
=====================


* select a databse 
    - `chdb`

* Change to oracle user 
```
sudo su - oracle
```

* List running databases 
```
ps -ef|grep pmon
```

* Oracle home
```
cat /etc/oratab
```

* List all listeners 
```
# Note; check form ASM Database selection uwsing chdb
lsnrctl status

#Start a listener 
snrctl start
```

* List rack systems
```
# Note execute after selecting ASM databse
olsnodes   
```

Check status of Scan Listener
```
# Select +ASM database 
srvctl status scan_listener
```

* List/Check Scan VIPs
```
# Run against +ASM database 
srvctl status scan
```

List all services
```
# Select +ASM database 
crsctl stat res -t
```

* Listener status
```
# ASM Database 
lsnrctl status <Listener Name>
```

* Check if databases are up and running 
```
srvctl config database

# replace <mydatabasename> with DBName
srvctl status service -d <mydatabasename>

```


* Tablespace troubleshooting SQL 
```
SELECT S.sid || ',' || S.serial# sid_serial, S.username, S.osuser, P.spid, S.module,
S.program, SUM (T.blocks) * TBS.block_size / 1024 / 1024 mb_used, T.tablespace,
COUNT(*) sort_ops
FROM gv$sort_usage T, gv$session S, dba_tablespaces TBS, gv$process P
WHERE T.session_addr = S.saddr
AND S.paddr = P.addr
AND T.tablespace = TBS.tablespace_name
GROUP BY S.sid, S.serial#, S.username, S.osuser, P.spid, S.module,
S.program, TBS.block_size, T.tablespace
ORDER BY sid_serial;
```
