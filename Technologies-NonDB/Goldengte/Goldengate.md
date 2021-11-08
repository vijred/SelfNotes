Goldengate
==========

* Goldengate on SQL Server
    - Goldengate can be configured on SQL Server as well, following steps to see infomration
```
# Login to location where goldengate is installed

#Start goldengate console
.\ggsci.exe

# Validate to make sure JAGENT, PMSRVR, E* Services are running on primary SQL server 

# Start the extract if needed from goldengate console 
start <extractname>
```

* How to delete CDC Cleanup job - This is used to delete default job for CDC
    -   `exec sys.sp_cdc_drop_job 'cleanup'`
    -   Note: Make sure to run the command against the database (not master or msdb)

* How to create a new GG Cleanup job
    -   `ogg_cdc_cleanup_setup.bat createJob SQLLoginName SQLLoginPassword Databasename SQLInstanceName SchemaName`

* How to check errors while starting Goldengate
    -   Details log files will be available in dirrpt folder, example: C:\gg\gginstance\dirrpt

* How to comment a line in mgr.prm
    -   use -- as prefix to comment a line - Example: 
        ```
        PORT 7809
        -- comment a line
        ```
* How to run .oby file in Goldengate 
    -   `GGSCI (ggs-source) 7> OBEY dirprm/exta.oby`


Commands on Goldengate console 
------------------------------

* How to view Goldengate Manager parameters 
    -   `edit params mgr`
* How to start Goldengate Service
    -   `start mgr`
* How to stop Golden Gate Manager
    -   `stop mgr!`
* How to add a table for 
    -   `add trandata dbo.vjtest1table`
* How to verify added table
    -   `info trandata dbo.vjtest*`
* How to add a new job 
    -   `shell ogg_cdc_cleanup_setup.bat createJob SQLLoginName SQLLoginPassword Databasename SQLInstanceName SchemaName`


* How to stop Goldengate Manager 
	-	`stop mgr `
	-	`stop mgr !` - ! avoids confirmation`

* Delete an extract 
	-	`Deleted EXTRACT Extractname`
	
* Delete Goldengate Service 
	-	`C:\goldengatepath\install.exe DELETESERVICE`

Delete a folder 
rm C:\gg\ntest6d\ -Recurse -Force
Remove-OdbcDsn -Name ntest7d -DsnType System


* Good reference for GG commands
	-	https://satya-dba.blogspot.com/2012/02/ggsci-goldengate-command-interpreter.html
