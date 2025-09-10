This is notes about Spark -

* Good reference video of spark architecture - https://www.youtube.com/watch?v=iXVIPQEGZ9Y
* How the work is distributed? - Jobs -> Stages -> Tasks
* Nodes: Driver Node + Worker node(s)
* Where to start the research -> Spark UI


Memory details 
==========
1. Executor Memory
2. Unified Memory
3. Off Heap Memory

A few tips that helped to troubleshoot the memory challenges - 
```
spark.driver.maxResultSize 8g
spark.conf.set("spark.sql.autoBroadcastJoinThreshold", "0")
spark.conf.set("spark.sql.join.preferSortMergeJoin", "true")
```


Ref: 
* https://blog.dataengineerthings.org/apache-spark-memory-management-fb677967246f 
* https://www.youtube.com/watch?v=sXL1qgrPysg
* 





