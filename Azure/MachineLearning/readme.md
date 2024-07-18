Azure machine learning
======================

good place to start learning machine learning - https://docs.microsoft.com/en-us/learn/modules/introduction-to-machine-learning/

Python reference: https://azure.github.io/azureml-cheatsheets/
One of the use cases I started for a long time is to create a compute in AMLS and use it as a Linux machine! Best part of it is, inbuild stuff to run Jupyter notebooks on this compute!

* How to access the data store data from ML Notebooks -
```
import pandas as pd
df = pd.read_csv('azureml://subscriptions/adsfdsaf-saf-dsaf-sadf-adsfadf/resourcegroups/rg-adsf-dsaf-343/workspaces/myworkspace-001/datastores/workspaceblobstore/paths/mySampleData_202407181030.csv')
df.head()
```
