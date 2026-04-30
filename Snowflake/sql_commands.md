Common SQL Command
=======

##Commn SQL Commands

All grants granted to a user, Role -
```
SHOW GRANTS TO USER "Username@Org.COM";

# To get the list of tables the role has access to
SHOW GRANTS TO ROLE RoleName;

# To gind Role and users who can use this Role
SHOW GRANTS OF ROLE RoleName;
```


RESULT_SCAN() Quick Guide
===============
What is RESULT_SCAN()?
RESULT_SCAN() lets you capture results from SHOW commands and use them like a regular table.

1. LAST_QUERY_ID() - Gets the ID of your most recent query.
Example:
```
SHOW DATABASES;
SELECT LAST_QUERY_ID();
```

2. RESULT_SCAN(query_id) - Gets the results from a previous query using its ID.
Example:
```
SHOW WAREHOUSES;
SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
```


3. TABLE() - Makes RESULT_SCAN output queryable (lets you use WHERE, JOIN, etc).
Example:
```
SHOW GRANTS TO ROLE PUBLIC;
SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())) WHERE "granted_on" = 'DATABASE';
```

Samples - 
```
-- First, run a SHOW command
SHOW DATABASES;

-- Get the query ID
SET my_query_id = LAST_QUERY_ID();

-- Later, retrieve those results using the query ID
SELECT * FROM TABLE(RESULT_SCAN($my_query_id));
```
