R Language - 
-----------

* Install location - https://www.r-project.org/.
* Install Rcmdr package - ` install.packages("Rcmdr")`
* Start Rcmdr - ` library(Rcmdr)`
* Reinstalling a package - `install.packages("Rcmdr", dependencies = TRUE)`



## Useful commands 

### Basic Commands 
* setwd("C:/Users/somename")
* getwd()
* ` library(Rcmdr)`

### Dataset commands 
* Read dataset
  * Sample  to read dataset from .csv file 
  ```
  > Dataset <- read.table("C:/Users/insurance.csv", header=TRUE, stringsAsFactors=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)
  ```
  * Sample  to read dataset from Excel file 
  ```
  > Dataset <- readXL("C:/Users/data/insurance.xlsx", rownames=FALSE, header=TRUE, na="", sheet="insurance", stringsAsFactors=TRUE)
  ```
* View variables in Dataset - `names(Dataset)`
* Structure of dataset - `str(dataset)`
* convert one of the column/factor (Vctor) into different type `Insurance$Smoker <- as.factor(Insurance$Smoker)`



## Concepts 

### Graphs

* Histogram
```
# Graphs -> Histogram 
# Sample 
with(Dataset, Hist(APR, scale="frequency", breaks="Sturges", col="darkgray"))
```
* Bar graph
* (Plot Discrete Numaric variable) 
* Normal Quantile Plot - This can be used to check if the data is normally distributed.
```
# Graphs -> Normal Quantile Plot
with(Dataset, qqPlot(APR, dist="norm", id=list(method="y", n=2, labels=rownames(Dataset))))
```
![Normal Quantil Plot](Images/normalquantileplot.png?raw=true "Normal Quantil Plot")
* Scatterplot matrix
  * Graphs -> Scatterplot matrix 
![Normal Quantil Plot](Images/scatterplot.png?raw=true "Normal Quantil Plot")


### Statistics
* Frequency Distribution
* Numerical Summaries 
  * skewed (Positively, negatively skewed)
* Corelation 
  * Statistics -> Summaries -> Correlation matrix
  * `cor(Dataset[,c("APR","FICO","HomeValue","Income","LTV")], use="complete")`
  * `cor(Dataset)`
* Covariance
  * `cov(Dataset)`
