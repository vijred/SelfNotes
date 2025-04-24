
How to view the access granted to Unity Catalog items -

```
-- Catalog Permissions 
SELECT DISTINCT grantee, privilege_type, table_catalog
FROM system.information_schema.table_privileges
where inherited_from = 'CATALOG'
and grantee = '3ewfdsaffdsafdf-233232-f43ffdf-34fdsf-fds432rewsfsfdsfsfadsfdsafds'
 
;
SELECT distinct grantee, privilege_type, catalog_name
FROM system.information_schema.schema_privileges
where inherited_from = 'CATALOG'
and grantee = '3ewfdsaffdsafdf-233232-f43ffdf-34fdsf-fds432rewsfsfdsfsfadsfdsafds'
;

SELECT distinct grantee, privilege_type, catalog_name
FROM system.information_schema.catalog_privileges
wHERE inherited_from = 'NONE'
and grantee = 'myalias@mydomain.com'
;


-- Schema permissions 
SELECT distinct grantee, privilege_type, table_catalog, table_schema
FROM system.information_schema.table_privileges
where grantee = '3ewfdsaffdsafdf-233232-f43ffdf-34fdsf-fds432rewsfsfdsfsfadsfdsafds'
and inherited_from = 'SCHEMA'
;

SELECT distinct grantee, privilege_type, catalog_name, schema_name
FROM system.information_schema.schema_privileges
where inherited_from = 'CATALOG'
and grantee = '3ewfdsaffdsafdf-233232-f43ffdf-34fdsf-fds432rewsfsfdsfsfadsfdsafds'



SELECT distinct grantee, privilege_type, table_catalog, table_schema, table_name
FROM system.information_schema.table_privileges
where grantee = '3ewfdsaffdsafdf-233232-f43ffdf-34fdsf-fds432rewsfsfdsfsfadsfdsafds'
and inherited_from = 'NONE' 


SELECT * -- distinct grantee, privilege_type, table_catalog, table_schema, table_name
FROM system.information_schema.schema_privileges
where grantee = '3ewfdsaffdsafdf-233232-f43ffdf-34fdsf-fds432rewsfsfdsfsfadsfdsafds'





SELECT * FROM system.information_schema.table_privileges
where table_catalog = 'mycatalog_name'
and grantee = '3ewfdsaffdsafdf-233232-f43ffdf-34fdsf-fds432rewsfsfdsfsfadsfdsafds'
```
