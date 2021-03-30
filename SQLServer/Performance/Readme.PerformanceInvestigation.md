Perfromance troubleshooting on SQL Server
=========================================


Verify Active blockings on server
---------------------------------
* Verify active running on Statements on given servers
	- [Active sql requests running on SQL Server](https://github.com/vijred/MSSQL/blob/master/Performance/01_ActiveSQLStatements_and_Blocking.sql)
* Find the lead blocker and start investigating the caue of Lead Blocker 




Knowledgebase
-------------
* Can a long running query on secondary replicate on Always-On cause performance impact on primary?
	- Yes, it can, this is documented at [Limitations and Restrictions](https://docs.microsoft.com/en-us/sql/database-engine/availability-groups/windows/active-secondaries-readable-secondary-replicas-always-on-availability-groups?redirectedfrom=MSDN&view=sql-server-ver15#bkmk_LimitationsRestrictions) 
	- Statement: `Because read operations are mapped to snapshot isolation transaction level, the cleanup of ghost records on the primary replica can be blocked by transactions on one or more secondary replicas. The ghost record cleanup task will automatically clean up the ghost records for disk-based tables on the primary replica when they are no longer needed by any secondary replica. This is similar to what is done when you run transaction(s) on the primary replica. In the extreme case on the secondary database, you will need to kill a long running read-query that is blocking the ghost cleanup. Note, the ghost clean can be blocked if the secondary replica gets disconnected or when data movement is suspended on the secondary database. Ghost records use physical space in a data file, this can cause space reuse issues, please see ghost cleanup for more information. This state also prevents log truncation, so if this state persists, we recommend that you remove this secondary database from the availability group. There is no ghost record cleanup issue with memory-optimized tables because the row versions are kept in memory and are independent of the row versions on the primary replica.`
