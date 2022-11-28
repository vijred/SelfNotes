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
 ```
 scatterplotMatrix(~APR+FICO+HomeValue+Income+LTV, regLine=FALSE, smooth=FALSE, diagonal=list(method="density"), data=Dataset)
 ```
![Scatter plot matrix](Images/scatterplotmatrix.png?raw=true "Scatter plot matrix")


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


### Linear regression
```
# Sample to create Linear regression model
lrModel <- lm(APR~LTV+FICO+Income+HomeValue, data=Dataset)
summary(lrModel)
coef(lrModel)
anova(lrModel)
residuals(lrModel)
```

Sample response and usage of regression model 
```
lm(formula = APR ~ LTV + FICO + Income + HomeValue, data = Dataset)

Residuals:
    Min      1Q  Median      3Q     Max 
-2.1392 -0.8797 -0.2024  0.6258  7.1070 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept) 23.7253652  0.6859028  34.590   <2e-16 ***
LTV         -1.5888430  0.5197123  -3.057   0.0024 ** 
FICO        -0.0184318  0.0013502 -13.652   <2e-16 ***
Income       0.0004032  0.0033266   0.121   0.9036    
HomeValue   -0.0007521  0.0008186  -0.919   0.3589    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 1.244 on 367 degrees of freedom
Multiple R-squared:  0.4631,	Adjusted R-squared:  0.4573 
F-statistic: 79.14 on 4 and 367 DF,  p-value: < 2.2e-16
```
* Intercept = 23.7253652:
* R-squared: Percent of variation explained by the model. This is between 0,1 and higher the better for the model 
* Residual standard error/RMSE/ Standard Error of the regression: Units is same as Respones variable (In our case APR).  This is also called RMSE (Root Mean Squared Error). This is on average how much error exists in response.
