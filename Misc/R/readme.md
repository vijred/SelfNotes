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
* Bar graph
* (Plot Discrete Numaric variable) 



### Statistics
* Frequency Distribution
* Numerical Summaries 
  * skewed (Positively, negatively skewed)
  