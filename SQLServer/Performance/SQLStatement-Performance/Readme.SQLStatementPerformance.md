MSSQL Server - Performance on given SQL Statement
=================================================





Useful tips
-----------
* [quickly retrieve accurate row count for table](https://docs.microsoft.com/en-gb/archive/blogs/martijnh/sql-serverhow-to-quickly-retrieve-accurate-row-count-for-table)
    - `Select (*) from Tablename` needs table Scan; Following 2 statements can quickly provide approximate number of rows on a given table 
```
SELECT SUM (row_count) 
FROM sys.dm_db_partition_stats
WHERE object_id=OBJECT_ID('Transactions')   
AND (index_id=0 or index_id=1);

-- Approximate number but very fast
SELECT CONVERT(bigint, rows)
FROM sysindexes
WHERE id = OBJECT_ID('Transactions')
AND indid < 2

```


