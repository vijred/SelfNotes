# Sample python for creating, exploring parquet file usign pyarrow
# reference - https://arrow.apache.org/docs/python/parquet.html 

import pyarrow.parquet as pq
import numpy as np
import pandas as pd
import pyarrow as pa

df = pd.DataFrame({'one': [-1, np.nan, 2.5],
    'two': ['foo', 'bar', 'baz'],
    'three': [True, False, True]},
    index=list('abc'))

table = pa.Table.from_pandas(df)

# Create a parquet file 
pq.write_table(table, 'example.parquet')

table3 = pq.read_table('example.parquet')
table3pandas = table3.to_pandas()

print ("Printing whole table")
print(table3pandas)

# # This works if we load data frame from actual dataset 
# print ("Printing first row of the table"), 
# print(table3pandas.loc[0])


parquet_file = pq.ParquetFile("example.parquet")

print("-- Printing Metadata")
print(parquet_file.metadata)

print("-- Printing schema")
print(parquet_file.schema)
