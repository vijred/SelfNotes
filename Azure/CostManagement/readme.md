Cost management in Azure 
=========================


Cost management is very critical to understand in cloud environment. Here are a few ideas to keep a tab!

* Cost analysis in portal: Open subscription, click on `cost analysis`. Perfect place to research and understand costs in detail. Use different views for analysis.
  * There is option to create a subscription of the report in mail, getting a mail every day of every week is nice way to keep track.
* Use Tags on each resource. Most organizations use tags to aligh the cost to given application, environment, cost center etc. Above reports can be split using tags.  
* Export of Cost details.
  * Cost details can be exported to datalake and generate your own reports using PowerBI.
  * This is my recommendation for a few reasons. (Implement logic to overwrite tags with custom rules)
* Collect costs every day and manage in your own database. I used powershell to find resources in given resource types.
  * I end up creating a solution to understand what changed every day. Now I have great summary of growth in last 5+ years.
* Review architecure and cost once every 1-3 years. I know a customer who started pushing logs into datalake for debugging but never turned off or archived. This turned about to be 10s of TB data and unnecessary costs.



While designing architecure use best practices, These blog series is a nice reference:
* https://automation.baldacchino.net/cost-optimising-your-architecture-on-azure-practical-design-steps-for-builders-to-cost-optimise-your-tech-stack/
* https://automation.baldacchino.net/cost-optimising-your-architecture-on-azure-practical-design-steps-for-builders-to-cost-optimise-your-tech-stack-part-2/
* https://automation.baldacchino.net/part-3-cost/
