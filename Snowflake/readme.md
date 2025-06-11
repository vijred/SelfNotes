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

