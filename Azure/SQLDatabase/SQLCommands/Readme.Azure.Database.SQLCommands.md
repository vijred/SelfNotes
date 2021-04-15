# Common SQL Commands in Azure



## Reanem a database 
```
ALTER DATABASE [OldDBName] MODIFY NAME = [NewDBName]];
```


## How to check if a database is Azure Database or not
```
PRINT 'Check if the database is SQL Azure database'
IF CAST(SERVERPROPERTY('Edition') as nvarchar (128)) NOT LIKE '%Azure%'
BEGIN
    PRINT 'This is NOT a SQL Azure Instance'
END
ELSE
BEGIN
    PRINT 'This IS a SQL Azure Instance'
END
```



## Firewall rules management on given server
```
# Find all Firewall rules 
SELECT * FROM sys.firewall_rules ORDER BY name;

#Add a server-level IP firewall rule.
EXECUTE sp_set_firewall_rule @name = N'ContosoFirewallRule',
   @start_ip_address = '192.168.1.1', @end_ip_address = '192.168.1.10'

# Delete a server-level IP firewall rule, execute the sp_delete_firewall_rule stored procedure. The following example deletes the rule ContosoFirewallRule:
EXECUTE sp_delete_firewall_rule @name = N'ContosoFirewallRule'
```
