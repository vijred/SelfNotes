MSSQL Server Log file size related info
=======================================





How to remove additional log file from a database
-------------------------------------------------
* Just release the storage from SQL Log file to OS with minimal to no impact  
    - 
        USE [DatabaseName]
        GO
        DBCC SHRINKFILE (N'LogFileName' , 0, TRUNCATEONLY)
 
 * Shrink SQL Log file , move data from Log file to a different logfile 
    - 
        USE [DatabaseName]
        GO
        DBCC SHRINKFILE (N'LogFileName', EMPTYFILE);
        GO

* Remove Log File from SQL Database 
    - 
        USE master;
        GO
        ALTER DATABASE [DatabaseName] REMOVE FILE LogFileName;
        GO

