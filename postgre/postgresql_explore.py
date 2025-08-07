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
