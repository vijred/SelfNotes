# Databricks notebook source
# MAGIC %md
# MAGIC Make sure to use this against standard cluster but not Serverless compute 
# MAGIC
# MAGIC Serverless compute can not access the dbfs as this is a shared compute!

# COMMAND ----------

# MAGIC %sh
# MAGIC rm -r /dbfs/delta_lab
# MAGIC mkdir /dbfs/delta_lab
# MAGIC wget -O /dbfs/delta_lab/products.csv https://raw.githubusercontent.com/kuljotSB/DatabricksUdemyCourse/refs/heads/main/DataAnalytics/products.csv

# COMMAND ----------

# MAGIC %sh
# MAGIC ls /dbfs

# COMMAND ----------

# MAGIC %sql 
# MAGIC
# MAGIC CREATE OR REFRESH LIVE TABLE raw_products_data
# MAGIC COMMENT "Products sample dataset"
# MAGIC AS
# MAGIC SELECT
# MAGIC  ProductID,
# MAGIC  ProductName,
# MAGIC  Category,
# MAGIC  ListPrice
# MAGIC FROM read_files('dbfs:/delta_lab/products.csv', format => 'csv', header => true)

# COMMAND ----------

# MAGIC %sql
# MAGIC CREATE OR REFRESH LIVE TABLE aggregated_products_data
# MAGIC COMMENT "Aggregated data"
# MAGIC AS
# MAGIC SELECT
# MAGIC    Category,
# MAGIC    sum(ListPrice) as Total_Price
# MAGIC FROM live.raw_products_data
# MAGIC GROUP BY Category;

# COMMAND ----------

df = spark.read.format("delta").load('/pipelines/delta_lab/tables/aggregated_products_data')
display(df)