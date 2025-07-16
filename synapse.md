How to create External data source and external table in Synapse - 
Sample
```
CREATE EXTERNAL DATA SOURCE my_storage
WITH (
    LOCATION = 'https://mydatalakename.dfs.core.windows.net/containername'
);

CREATE EXTERNAL FILE FORMAT parquet_format
WITH (
    FORMAT_TYPE = PARQUET
);

CREATE EXTERNAL TABLE dbo.mytablename
(
    MDate DATETIME2,
    ContactR NVARCHAR(MAX),
    SystemStartDateTime DATETIME2,
    MySub NVARCHAR(MAX)
)
WITH (
    LOCATION = 'folderpath/foldersubpath',
    DATA_SOURCE = my_storage,
    FILE_FORMAT = parquet_format
);
```
