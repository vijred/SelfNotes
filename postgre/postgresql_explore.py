## Following is a code sample that is tested to explore postgre sql database, This is tested from Databricks 

## Install libraries if not already done
# %python
# %pip install psycopg2-binary


import psycopg2

#define variables 
user="payxadmin"  # ✅ must include @server
apassword=dbutils.secrets.get(scope="myKVName", key="myPW")
host="postgresqlservername.postgres.database.azure.com"
port=5432
database="azure_sys"
asslmode="require"  # ✅ Azure requires SSL


import psycopg2
import pandas as pd

def get_connection_uri(database):
    dbhost = host  # env_vars.db_host
    dbname = database  # env_vars.db_name
    dbuser = user  # urllib.parse.quote(env_vars.db_user)
    password = apassword  # env_vars.db_password
    sslmode = asslmode  # env_vars.db_sslmode
    return {
        "host": dbhost,
        "dbname": dbname,
        "user": dbuser,
        "password": apassword,
        "sslmode": asslmode
    }

# Functions
def exec_postgre_sql_to_df(database, sqlstatement):
    try:
        db_params = get_connection_uri(database)
        with psycopg2.connect(**db_params) as conn:
            df = pd.read_sql_query(sqlstatement, conn)
        print("✅ Connected! Query executed successfully.")
        return df
    except Exception as e:
        print("❌ Local Postgres connection test failed.")
        print("❌ Connection failed:", str(e))
        return pd.DataFrame()

# # Execute the query and load results into a DataFrame
# df = exec_postgre_sql_to_df("SELECT * FROM information_schema.tables")

# # Display the DataFrame
# print(df)


## Insert a record, index, primary key or create a table
def exec_postgre_sql(database, sqlstatement, params=None):
    """
    Execute a SQL command that does not return a DataFrame result.
    Example: CREATE TABLE, INSERT, UPDATE, DELETE, CREATE INDEX, etc.

    :param database: Database name
    :param sqlstatement: SQL string
    :param params: Optional tuple of parameters for parameterized queries
    """
    try:
        db_params = get_connection_uri(database)
        with psycopg2.connect(**db_params) as conn:
            with conn.cursor() as cur:
                if params:
                    cur.execute(sqlstatement, params)
                else:
                    cur.execute(sqlstatement)

            conn.commit()  # commit is required for DDL/DML operations

        print("✅ SQL executed successfully.")
        return True

    except Exception as e:
        print("❌ SQL execution failed:", str(e))
        return False

# sql = """
# CREATE TABLE IF NOT EXISTS demo_table (
#     id SERIAL PRIMARY KEY,
#     name TEXT NOT NULL,
#     created_at TIMESTAMP DEFAULT NOW()
# )
# """
# exec_postgre_sql("mydb", sql)




# Sample execution of SQL Statemetns 
# Execute the query and load results into a DataFrame
df = exec_postgre_sql_to_df("mydbname",
f"""
SELECT datname 
FROM pg_database 
WHERE datistemplate = false;
""")
# Display the DataFrame
display(df.astype(str))



# Execute the query and load results into a DataFrame
df = exec_postgre_sql_to_df("mydbname",
f"""
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'mytablename';
""")
# Display the DataFrame
display(df.astype(str))


# Mostly user tables
df = exec_postgre_sql_to_df("postgres",
f"""
SELECT *
FROM information_schema.tables 
WHERE table_schema = 'public';
""")
# Display the DataFrame
display(df.astype(str))
