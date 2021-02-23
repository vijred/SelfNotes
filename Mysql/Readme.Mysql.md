MySql basic infomration
=======================

* Connect to MySQL Server
    - `mysql -u UserName -p`
* Basics Commands 
    - `Show databases `
    - `Use databasename`
    - `Show tables`
    - Sample select statement 
```
        SELECT  h.name  ,fn.name ,fv.value 
        FROM fact_values fv, hosts h , fact_names fn
            where fv.host_id=h.id 
            and fn.id = fv.fact_name_id
            and h.name = 'ServerName'
            and fn.name = 'FactName'
            limit 0,5 ; 
```

* Replication status 
    - `SHOW MASTER STATUS \G;`
    - `SHOW SLAVE STATUS \G;`

