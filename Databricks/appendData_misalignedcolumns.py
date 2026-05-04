import json
from pyspark.sql.functions import col, lit


history_df = spark.sql(f"DESCRIBE HISTORY {target_table_name}")
earlier_version = history_df.head()[0]


# --------------------------------------------------
# Step 1: Read source data
# --------------------------------------------------
try:
    source_df = spark.read.parquet(
        "abfss://<container>@<storage-account>.dfs.core.windows.net/<input-path>/"
    )
except Exception as e:
    dbutils.notebook.exit(json.dumps({
        "status": "Error",
        "stage": "Read Source",
        "error": str(e)
    }))

# --------------------------------------------------
# Step 2: Align source schema to target table schema
# --------------------------------------------------
try:
    # Read target Delta table
    target_table_name = "<target_database>.<target_table>"
    target_df = spark.table(target_table_name)
    target_schema = target_df.schema

    # Map target column names to data types
    target_columns = {
        field.name: field.dataType
        for field in target_schema.fields
    }

    # Start with the source DataFrame
    aligned_df = source_df

    # Ensure all target columns exist and have correct data types
    for column_name, target_type in target_columns.items():
        if column_name in aligned_df.columns:
            # Cast existing columns to match target schema
            aligned_df = aligned_df.withColumn(
                column_name,
                col(column_name).cast(target_type)
            )
        else:
            # Add missing columns with NULL values
            aligned_df = aligned_df.withColumn(
                column_name,
                lit(None).cast(target_type)
            )

    # Select columns in target table order (required for Delta append)
    ordered_column_names = [field.name for field in target_schema.fields]
    final_df = aligned_df.select(*ordered_column_names)

    # --------------------------------------------------
    # Step 3: Append data to target Delta table
    # --------------------------------------------------
    final_df.write \
        .mode("append") \
        .format("delta") \
        .saveAsTable(target_table_name)

    # --------------------------------------------------
    # Step 4: Optional write verification
    # --------------------------------------------------
    history_df = spark.sql(f"DESCRIBE HISTORY {target_table_name}")
    latest_version = history_df.head()[0]

    # Compare latest_version - earlier_version

    dbutils.notebook.exit(json.dumps({
        "status": "Success",
        "table": target_table_name,
        "delta_version": latest_version
    }))

except Exception as e:
    dbutils.notebook.exit(json.dumps({
        "status": "Error",
        "stage": "Schema Alignment / Write",
        "table": "<target_table>",
        "error": str(e)
    }))

