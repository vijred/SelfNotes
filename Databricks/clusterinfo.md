# Databricks Cluster Notes

When using **Serverless Compute** instead of **All-Purpose Compute** (with your own subnet), connecting to other resources can be challenging — especially those within your subnet or on-premises.

At a high level, there are ways to connect Serverless Compute to your own domain.

A simple method is described here: [Custom DNS Routing](https://kb.databricks.com/cloud/custom-dns-routing.html) — it allows domain-specific DNS resolution to access on-prem or private resources.
