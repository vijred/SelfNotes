from pyspark.sql import SparkSession

spark = SparkSession.builder.getOrCreate()

results = []

# Step 1: Get all connections (position-based, no column assumptions)
conn_rows = spark.sql("SHOW CONNECTIONS").collect()
connections = [row[0] for row in conn_rows]  # safest

# Step 2: Get all catalogs
catalog_rows = spark.sql("SHOW CATALOGS").collect()
catalogs = [row[0] for row in catalog_rows]

for catalog in catalogs:
    try:
        desc_rows = spark.sql(f"DESCRIBE CATALOG EXTENDED {catalog}").collect()

        # Flatten metadata into one string
        blob = " ".join(
            [str(r[0]) + " " + str(r[1]) for r in desc_rows if len(r) > 1 and r[1] is not None]
        )

        # Step 3: Match connection names
        for conn in connections:
            if conn and conn in blob:
                results.append((catalog, conn))
                break

    except Exception as e:
        print(f"Skipping {catalog}: {str(e)}")

# Step 4: Output
if results:
    df = spark.createDataFrame(results, ["catalog", "connection"])
    display(df)

## How to dispaly all catalogs with `pict` in its name
## display(df[df['catalog'].rlike('(?i)pict')])
else:
    print("No catalogs using external connections found.")
