Snowflake - 

* Snowflake Data types - https://docs.snowflake.com/en/sql-reference/intro-summary-data-types
* How to find list of URLs that needs access - `select SYSTEM$ALLOWLIST_PRIVATELINK()` - Note: This is a SQL Statement
* Snowflake Platform Info to give network layer trust in Azure - `SELECT SYSTEM$GET_SNOWFLAKE_PLATFORM_INFO();`
* Sample SQL to create a table `create or replace TABLE DBName.SchemaName.TableName (ColName VARCHAR);`

* Sample code to create and use a function in a worksheet 
```
from snowflake.snowpark.functions import udf
from snowflake.snowpark.types import StringType

def main(session):

    # Inline function definition (inside main, or properly visible to Snowflake)
    def make_email(first_name: str, last_name: str) -> str:
        return f"{first_name.lower()}.{last_name.lower()}@example.com"

    # Create a UDF from the function
    make_email_udf = udf(make_email, return_type=StringType())

    # Create sample data
    data = [("John", "Doe"), ("Alice", "Smith")]
    df = session.create_dataframe(data, schema=["first_name", "last_name"])

    # Apply the UDF
    result = df.with_column("email", make_email_udf("first_name", "last_name"))

    return result
 ```


How to view Private link ID from Network Rule in Snowflake.
```
SELECT
    PARSED_JSON:"endpointId"::STRING AS ENDPOINT_ID,
    PARSED_JSON:"endpointIdType"::STRING AS ENDPOINT_TYPE,
    PARSED_JSON:"linkIdentifier"::STRING AS PRIVATE_LINK_IDENTIFIER,
FROM (
    SELECT
        PARSE_JSON(VALUE) AS PARSED_JSON
    FROM
        TABLE(FLATTEN(INPUT => PARSE_JSON(SYSTEM$GET_PRIVATELINK_AUTHORIZED_ENDPOINTS())))
); 
```

How to view the list of all databases with access to given users
```
-- Find databases where all 3 specified users have access
WITH user_roles AS (
    SELECT GRANTEE_NAME AS USER_NAME, ROLE AS ROLE_NAME
    FROM SNOWFLAKE.ACCOUNT_USAGE.GRANTS_TO_USERS
    WHERE DELETED_ON IS NULL
      AND GRANTEE_NAME IN ('asfdsfsdf@MYDOMAIN.COM', 'safsafsdf@MYDOMAIN.COM')
),
role_hierarchy AS (
    SELECT NAME AS ROLE_NAME, GRANTEE_NAME AS PARENT_ROLE
    FROM SNOWFLAKE.ACCOUNT_USAGE.GRANTS_TO_ROLES
    WHERE GRANTED_ON = 'ROLE'
      AND DELETED_ON IS NULL
),
all_user_roles AS (
    -- Direct roles assigned to each user
    SELECT USER_NAME, ROLE_NAME FROM user_roles
    UNION
    -- Inherited roles (one level deep)
    SELECT ur.USER_NAME, rh.ROLE_NAME
    FROM user_roles ur
    JOIN role_hierarchy rh ON ur.ROLE_NAME = rh.PARENT_ROLE
),
database_access AS (
    SELECT DISTINCT aur.USER_NAME, gtr.NAME AS DATABASE_NAME
    FROM all_user_roles aur
    JOIN SNOWFLAKE.ACCOUNT_USAGE.GRANTS_TO_ROLES gtr
      ON aur.ROLE_NAME = gtr.GRANTEE_NAME
    WHERE gtr.GRANTED_ON = 'DATABASE'
      AND gtr.PRIVILEGE IN ('USAGE', 'OWNERSHIP', 'ALL', 'ALL PRIVILEGES')
      AND gtr.DELETED_ON IS NULL
)

SELECT 
    da.DATABASE_NAME,
    d.DATABASE_OWNER,
    LISTAGG(da.USER_NAME, ', ') WITHIN GROUP (ORDER BY da.USER_NAME) AS USERS_WITH_ACCESS,
    COUNT(DISTINCT da.USER_NAME) AS USER_COUNT
FROM database_access da
LEFT JOIN SNOWFLAKE.ACCOUNT_USAGE.DATABASES d
    ON da.DATABASE_NAME = d.DATABASE_NAME
    AND d.DELETED IS NULL
WHERE  DATABASE_OWNER not in ('ROLE_SNFLK_APP_PISCES_APP_OWR_PR', 'ROLE_SNFLK_APP_PAW_APP_OWR_PR')
GROUP BY da.DATABASE_NAME, d.DATABASE_OWNER
ORDER BY da.DATABASE_NAME;
```
