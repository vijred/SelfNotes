NOTE: exploreparquetfile.py can be referenced to read data from parquet file or create a parquet file 


Python FAQ
----------
* How to address certificate issues with module installations
    -   Use trusted hosts to address the issue - `--trusted-host pypi.org --trusted-host files.pythonhosted.org`
    -   example: `pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org  --pre azure-cosmos`
    -   Example2: Install pyarrow package- `pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org --pre pyarrow`

* What is most easy way to start with Python with no installaion or anything 
    -    Colaboratory, or "Colab" for short, allows you to write and execute Python in your browser, with - https://colab.research.google.com/

* Example of dataset joins 
    -   `https://www.datasciencemadesimple.com/join-merge-data-frames-pandas-python/ `

* Example of using join on Data Frames 
```
%python
import pandas as pd
import numpy as np
 
# data frame 1
d1 = {'Customer_id':pd.Series([1,2,3,4,5,6]),
  'Product':pd.Series(['Oven','Oven','Oven','Television','Television','Television'])}
df1 = pd.DataFrame(d1)
 
 

d2 = {'Customer_id':pd.Series([2,4,6,7,8]),
    'State':pd.Series(['California','California','Texas','New York','Indiana'])}
df2 = pd.DataFrame(d2)


inner_join_df= pd.merge(df1, df2, on='Customer_id', how='outer')

inner_join_df.sample()
```

Dataframe sample from Databricks 
```
# Pick small set of rows from existing data frame for analysis 
dfe = df_explination.head(4)
display(dfe)

data = [[1001457489, "Elia"], [1576674295, "Teo"], [1387463875, "Fang"]]

pdf = pd.DataFrame(data, columns=["w_id", "name"])

df1 = spark.createDataFrame(pdf)
df2 = spark.createDataFrame(data, schema="wr_id LONG, name STRING")

display(df1)
display(df2)

df3 = spark.createDataFrame(dfe)

display(df3)

unioned_df = df1.union(df2)
display(unioned_df)

joined_df = df1.join(df3, how="inner", on="w_id")
display(joined_df)

joined_df_filter = joined_df.where("Name <> 'Teo'")
display(joined_df_filter)

joined_df_filter_col = joined_df_filter.select("w_id","name","gcc_id","variable","value")
display(joined_df_filter_col)

joined_df_filter_col.printSchema()


## Write dataframe as a table 
# df.write.saveAsTable("<table_name>")

##Write dataframe as collection of files 
# df.write.format("json").save("/tmp/json_data")


display(joined_df_filter_col.selectExpr("w_id", "upper(name) as big_name", "lower(name) as small_name"))

# # Select data from a table
# table_name = "my_table"
# query_df = spark.sql(f"SELECT * FROM {table_name}")

```

* Python command prompt - `py`
  *  use `py --list` to view list of python versions installed on the system

* How to ensure working pip on windows server
  * `py --version, py -m pip --version` commands can be used. Ref: https://pip.pypa.io/en/stable/getting-started/
  * How to install a package - `py -m pip install sampleproject` ,`py -m pip install azure-storage-file-datalake`
   * Ref: https://packaging.python.org/en/latest/tutorials/installing-packages/

* Documentation
 * The Python Tutorial : https://docs.python.org/3.11/tutorial/index.html
 * Python Documentation: https://docs.python.org/3.11/index.html
 * Using Python on Windows: https://docs.python.org/3.11/using/windows.html
 * Azureml python cheatsheet: https://azure.github.io/azureml-cheatsheets/ 

