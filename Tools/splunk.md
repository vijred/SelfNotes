# Splunk Cheat Sheet

A concise reference guide for common Splunk queries.\
All examples use dummy domains, servers, and index names.

------------------------------------------------------------------------

## Table of Contents

-   [Indexing and Regex Manipulation](#indexing-and-regex-manipulation)
-   [SQLException Timechart](#sqlexception-timechart)
-   [Statistics and Time Manipulation](#statistics-and-time-manipulation)
-   [XY Series and Lookup Tables](#xy-series-and-lookup-tables)
-   [Conditions, Sorting, and Deduplication](#conditions-sorting-and-deduplication)
-   [Timechart and Eval Examples](#timechart-and-eval-examples)
-   [Regex and Replace](#regex-and-replace)
-   [Miscellaneous Commands](#miscellaneous-commands)
-   [Using AddInfo and Lookups](#using-addinfo-and-lookups)
-   [Comments and Index Listings](#comments-and-index-listings)
-   [Search by Multiple Fields -- Coalesce](#search-by-multiple-fields--coalesce)
-   [Additional Functions and mmands](#additional-functions-and-commands)
-   [Misc](#misc)
------------------------------------------------------------------------

## Indexing and Regex Manipulation

### Azure Alerts with Regex

``` spl
index=azure_alerts "portalLink":"https://example.com/#resource/subscriptions*" 
| eval host=_raw 
| rex mode=sed field=host "s/\"/\\\"/g"
```

------------------------------------------------------------------------

## SQLException Timechart

``` spl
index=myapp_prod SQLException Level=Error earliest=-7h 
| timechart span=60m distinct_count(Database) by DbServer limit=50
```

------------------------------------------------------------------------

### Stats and Regex

``` spl
index=myapp_prod Level=Error sqlException "Timeout expired." 
| rex field=_raw "Database=(?<dbname>.*)" 
| timechart span=10m count(dbname) by dbname
```

### Time Filtering

``` spl
earliest="02/19/2018:22:00:00" latest="02/20/2018:04:00:00"
```

------------------------------------------------------------------------

## XY Series and Lookup Tables

### Database Count with XYSeries

``` spl
index=some_prod sourcepath="C:\\Resources\\Directory\\*" "Timeout retry failed" 
| bucket span=10m _time 
| stats count by _time Database 
| where count > 15 
| xyseries _time, Database, count
```

### Lookup Table Search

``` spl
| from inputlookup:"DUMMY_CLIENT_LOOKUP.csv"
```

------------------------------------------------------------------------

## Conditions, Sorting, and Deduplication

### OR Condition Example

``` spl
(index=alerts NODEHINTS_HINT="TLO*" (NOT TITLE="Alerts") "Service stopped") 
OR 
(index=prod_start "Process starting" earliest=-12h Employee)
```

### Sorting

``` spl
| sort -_time   // Descending
| sort _time    // Ascending
```

### Deduplication

``` spl
| dedup host, Test
```

------------------------------------------------------------------------

## Timechart and Eval Examples

### Timechart Usage

``` spl
index=analytics body.records.operationName="Quota Utilization" 
| timechart span=1h limit=0 max(body.records.CurrentNodeCount) by body.records.ClusterName
```

### Eval to Update Columns

``` spl
| eval host=lower(host) 
| eval DisplayedErrorClient=if(displayed="true", clientId, null())
```

------------------------------------------------------------------------

## Regex and Replace

### Extract Host Prefix

``` spl
| rex field=host "(?<host>[^.]+)\."
```

### Replace Using Regex

``` spl
| rex field=Service mode=sed "s/\.example\.com*//g"
```

------------------------------------------------------------------------

## Miscellaneous Commands

### Replace Null Value

``` spl
| fillnull status value="missing"
```

### AppendPipe Example

``` spl
| appendpipe [ stats sum(value) AS value | eval row="Total" ]
```

### Search Splunk Saved Searches

``` spl
| rest splunk_server="local" "/servicesNS/-/-/saved/searches" 
| search search="*coalesce(*" 
| table title search
```

------------------------------------------------------------------------

## Using AddInfo and Lookups

### AddInfo for Time Details

``` spl
| makeresults 
| addinfo 
| fieldformat info_min_time=strftime(info_min_time, "%F %T")
```

### Lookup Example

``` spl
| inputlookup facts_lookup 
| search host = example_host_37*
```

------------------------------------------------------------------------

## Comments and Index Listings

### Add Comment

``` spl
`comment("To remove manual triggers")`
```

### List All Indexes

``` spl
| dbinspect index=* | stats count by index
```

------------------------------------------------------------------------

## Search by Multiple Fields -- Coalesce

``` spl
| eval src_ip = coalesce(ip1, ip2)
```

------------------------------------------------------------------------

## Additional Functions and Commands

### Stats / Streamstats

``` spl
| stats exactperc95(duration) 
| streamstats avg(duration) AS calc window=3
```

### mvexpand / mvzip

``` spl
| eval combined = mvzip(field1, field2, "~") 
| mvexpand combined
```

### Monitor Consecutive Events

``` spl
| bucket span=1m _time 
| stats dc(CustomerId) by _time, DbServer 
| streamstats window=4 values(dcnt) as counts
```

------------------------------------------------------------------------
## Misc

### How to view the source file 
Few of the events have an option to view the source. Look for Event Actions -> Shouw Source to see the sequence of the envets that lead to the search results from actual file.

------------------------------------------------------------------------
This cheat sheet provides commonly used Splunk patterns to speed up
troubleshooting, data exploration, and dashboard development.\
Replace dummy values as needed for your environment.
