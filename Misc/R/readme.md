R Language - 
-----------

* Install location - https://www.r-project.org/.
* Install Rcmdr package - ` install.packages("Rcmdr")`
* Start Rcmdr - ` library(Rcmdr)` (Load a package)
* Reinstalling a package - `install.packages("Rcmdr", dependencies = TRUE)` (Install a package)
* How to search for documentation - `?library` (This searches for documenation reltaed to liubrary)
* How to use sessions in .R files, use `##----sessionName-------` is a good way to define sessions



## Useful commands 

### Basic Commands 
* setwd("C:/Users/somename")
* getwd()
* ` library(Rcmdr)`
* `class` used to find the type of a variable , `typoeof()` can be used too. Example - `Class(VarName)`
* Order of operations -Left to right,  P E MD AS
* Logical comparision operations, `== , > , < , !=, <=, |, &`
* `as.numeric(TRUE)`, converts other possible types to numeric
* How to remove variables - `rm(var1, var2)`. To remove all variables `rm(list= ls())`
* concatinate function - `c(val1, val2, val3)`; First element is index of 1. meaning vectorvar[1] = val1
* `summary(df)` - get the summary of the data frame
* How to create a matrix using vectors -> `mat1 = cbing(vector1, vector2)`; other way `mat2 <- matrix(vector1m, nrow=4, ncol=3, byrow = TRUE )`; One more - `max.matrix( mat3[,2:4])`
* How to get dimention of matrix - `dim(mat1)`
* Transpose of matrix = `t(matrix3)`
* Missing values or null values - Represented as `NA`
* Option to address missing values : `mean(varname, na.rm=TRUE)`
* `is.na()` function to see if ther eis a missing value; To find number of nulls, `sum(is.na())`
* factors - are special variables used to deal with catagorical variables. Ex: `pgm <- as.factor(pgm)`
  * Levels and level values will be involved in storing categorical variables
  * `levels(pgm)` is a way to check levels of a factor variables. Levels can be manually defined that may not be in alphabetical order- `pgm2 <- factor(pgm, levels = c("val1", "val3", "val2"))`
  * To change just first level, `relevel(pgm2, "val3")`
* Data Frames - `vect1 <- c("a", "b", "c"); vect2 <- c("MBA", "EMBA", "PMBA"); df <- data.frame(vect1, vect2)`
  * Dimentions of df - `dim(df)`; Names of variables - `names(df)`; Structure of df - `str(df)`; See data of df - `View(df)`
  * Both these formats returns a vector - `df[1,], df[,1]`; `df$vect1` returns vector too
  * To return a df, you need to use something like `df["vect1"]; df[c("vect1","vect2")]`
  * How to read with string as factor - `getdf <- read.csv("Telco_Churn1.csv", stringsAsFactors = TRUE)`
  * Assign one column as a factor - `df$AreaCode <- as.factor(df$AreaCode)`
* Exploring dataframe
  * counts - `tables(df$col1)`; Percentages - `prop.table(table(df$col1, df$col2))`
  * Example to select only numarical values - `library(dplyr); df.num <- select_if(df, is.numeric)`
  * Mean of given columns - `means <- apply(df.num, 2, mean)`
  * graph funcitons - `plot()`; histogram - `hist()`; boxplot `boxplot(df$col, horizontal = TRUE)`
  * Advanced graphics - `librar(ggplot2)`; add a line - `+ geom_smooth()`; all pointes - `+ geom_point()`; density - `+ geom_density()`


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

* produsing simple graphs -> https://sites.harding.edu/fmccown/r/

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


------------------------------------------
DETAILED use cases 

* How to remove all variable from environment - `rm(list = ls())`
* How to read data from a frame - `df <- read.csv("ChurnData.csv", stringsAsFactors = TRUE)`
* Structure of the data - `str(df) `
* Make a column as a factor - `df$AreaCode <- as.factor(df$AreaCode) # make area code into a factor`
* See first and last few rows of a dataframe - `head(df) # tail(df)`
* Remove column 1, 4 from dataframe - `df <- df[,c(-1,-4)]`
* Summart of a df - `summary(df)`
* Column counts - `table(df$Churn)`
* Column percentages - `prop.table(table(df$Churn))`
* Create a new DF from existing one with only numaric values -
```
library(dplyr) 
df.num <- select_if(df, is.numeric) # new dataframe with numeric only columns
str(df.num) # a quick look. Notice includes both integer and real columns
```
* Calculate mean and median by column and also merge factors into a dataframe -
```
means <- apply(df.num, 2, mean) # calculating the means by column
medians <- apply(df.num, 2, median) # calculating the medians by column
sds <- apply(df.num, 2, sd) # calculating the SDs by column
cbind(Mean = means, Median = medians, SD = sds) # putting them together for display
```
* Plot a bar graph based on number of items - `plot(df$Churn, xlab = "Churn", ylab = "Count", col = "red4")`
* Histogram of a distribution -
```
hist(df$TotalDayMinutes, xlab = "Total Daily Mins", 
     main = "Distribution of Total Daily Mins")
```
* Distribution by 2 categorical variables
```
#Distribution of Churn by other categorical variables
plot(df$Churn ~ df$InternationalPlan, 
     xlab = "International Plan", ylab = "Churn", 
     col = c("red4", "palegreen3"))
```
* Distribution based on numarical variables
```
# Relationships between numerical variables
plot(df$TotalEveMinutes ~ df$TotalDayMinutes, 
     pch = 20, col = "blue",
     xlab = "Total Day Minutes", ylab = "Total Evening Minutes")
```
* Relation b/n categorical and numaric variables -
```
# Relationships between numerical variables & categorical variables
plot(df$TotalDayMinutes ~ df$Churn, xlab = "Churn", 
     ylab = "Total Day Minutes", col = "slategray3")
```
* Explore GGPLOT2
```
library(ggplot2)

ggplot(df, aes(x = TotalDayCharge, y = TotalEveCharge)) + 
  geom_point() #scatterplot


ggplot(df, aes(TotalDayCharge)) + 
  geom_histogram() # histogram

ggplot(df, aes(TotalDayCharge)) + geom_density() # densityplot

ggplot(df, aes(x = Churn, y = TotalDayCharge)) + geom_boxplot() +
  labs(x = "Churn", y = "Total Day Charges") # side by side boxplots

ggplot(df, aes(x = AreaCode, y = mean(AccountLength))) +
  geom_col(fill = "red4") +
  labs(x = "Area Code", y = "Avg. of Account Length") # Column plot showing averages

```
* How to draw a graph using different color for factor1 and different shape for factor2 and axis X and Y for different numaric values?
```
# Create the ggplot object
p1 <- ggplot(df_insurance, aes(x = age, y = charges, color = smoker, shape = highbmi))

# Add the geometry layer (points)
p1 + geom_point() + 
  labs(title = "Charges and Age") +
  scale_shape_manual(values = c("F" = 16, "T" = 17))  # Mapping shapes to highbmi values

```
* Last option is to add facet_wrap, that creates multiple graphs next to each other for each factor
```
# Create the ggplot object
p1 <- ggplot(df_insurance, aes(x = age, y = charges, color = smoker, shape = highbmi))

# Add the geometry layer (points) and facet by children
p1 + geom_point() + 
  labs(title = "Charges and Age") +
  scale_shape_manual(values = c("F" = 16, "T" = 17)) +  # Mapping shapes to highbmi values
  facet_wrap(~children)  # Faceting by children factor
```
* Continues distribution of a numaric and a factorial columns
```
## -- A graph of 2 continuos distriutions together
# Density Graph: Age by Survived
ggplot(df_titanic, aes(x = Age, fill = Survived)) +
  geom_density(alpha = 0.4) +
  labs(title = "Distribution of Passenger's Age by Survived", x = " Age",
       y = "Density")

```
* 
