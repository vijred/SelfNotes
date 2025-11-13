# Databricks Cluster Notes

When using **Serverless Compute** instead of **All-Purpose Compute** (with your own subnet), connecting to other resources can be challenging — especially those within your subnet or on-premises.

At a high level, there are ways to connect Serverless Compute to your own domain.

A simple method is described here: [Custom DNS Routing](https://kb.databricks.com/cloud/custom-dns-routing.html) — it allows domain-specific DNS resolution to access on-prem or private resources.


* How to use Cluster Tags in notebook
```
import json
all_tags = {}
for tag in json.loads(spark.conf.get("spark.databricks.clusterUsageTags.clusterAllTags")):
  all_tags[tag['key']] = tag['value']

notebookenv = all_tags.get('my_environment')
print(notebookenv)
```

* How to get clusterName and clisterId in notebook
```
spark.conf.get("spark.databricks.clusterUsageTags.clusterName")
spark.conf.get("spark.databricks.clusterUsageTags.clusterId")
```

* Simple example to configure init script for a clusetr - 
```
#!/bin/bash
pip install webexteamssdk

echo "webexteamssdk library installation complete."
```
* How to validate if the cluster libraries are installed -
```
try:
    import webexteamssdk
    print("webexteamssdk library is successfully installed.")
except ImportError:
    print("webexteamssdk library is NOT installed.")
```
