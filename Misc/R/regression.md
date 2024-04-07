*Example of Linear regression - 
```
reg <- lm(charges~., data = ins)
reg  # a quick snapshot of the coefficients
summary(reg) # printing out the regression report

str(reg) # looking at the structure of the reg model object

# pulling out various pieces of the regression model object

names(reg)
# things you can get from the regression object

reg$coefficients # returns coefficients as named vector
reg$coef # same as above

summary(reg)$coef   # if you want all columns

names(summary(reg)) # all the things in this summary
summary(reg)$r.squared # to get r-squared
summary(reg)$adj.r.squared # to get adjusted r-squared
summary(reg)$sigma    # gives RMSE

reg$residuals # gives residuals
reg$fitted.values # gives fitted values


# We can also use "extractor functions" to get
# stuff out of a regression model object

coef(reg)  # gives coefficients
confint(reg)  # gives confidence intervals for coefficients

fitted(reg) # gives fitted values

rsd <- resid(reg)  # gives residuals
hist(rsd)  # doing a histogram of residuals

plot(reg)  # gives diagnostic plots of residuals

#predict() function can be used to produce predictions
#we'll see that shortly

```

* Fitting a new regression model with additional predictor
```
# Fitting a new regression model with the additional predictor
# obese as well as interactions
reg2 <- lm(charges ~ .+smoker*bmi+smoker*obese, data = ins)
summary(reg2)
```

* How to predict a value for a given set of values
```
# Producing predictions using the predict() function
# predict(regression model object, dataframe)

# Creating a new observation

newobs <- data.frame(age = 40, sex = "male", bmi = 32, children = 0, 
                     smoker = "yes", region = "northwest", obese = "yes")


predict(reg2, newobs)

#predicting charges for this person (including 95% prediction interval)
predict(reg2, newobs, int = "p", level = 0.95)
  # "p" indicates prediction interval for a user

predict(reg2, newobs, int = "c", level = 0.95)
  # "c" indicates confidence interval for average users. On Average, users with these values have a value between thees intervals 


```
* Measuring performance of a prediction - 
```
# Measuring prediction performance
# First let us produce predictions for all rows in our data

reg2.predictions <- predict(reg2, ins) 

# To calculate accuracy measures, we need the forecast package
library(forecast)
accuracy(reg2.predictions, ins$charges)

# To product a naive prediction, we use mean(charges)
# as prediction for each of the 1338 observations
# and then compute the accuracy of these predictions
naive <- rep(mean(ins$charges), nrow(ins))
accuracy(naive, ins$charges)

```

* Partitioning the data, using different datasets to train and predict
```
## ---- Partitioning the data ----
# We'll partition the dataset randomly so that
# 60% of the records are in the training data set and
# 40% are in the holdout data set. We'll call this the validation set

set.seed(123) # to ensure that the same random numbers are generated every time
trn.rows <- sample(rownames(ins), nrow(ins)*0.6) # randomly sampling 60% of rows
ins.trn <- ins[trn.rows, ] # create the training data set

vld.rows <- setdiff(rownames(ins), trn.rows) # find the remaining rows
ins.vld <- ins[vld.rows, ] # create the validation data set

#---- Training & Evaluation ----

#Training the model on the training data set
reg3 <- lm(charges ~ .+smoker*bmi+smoker*obese, data = ins.trn)
summary(reg3)

#Accuracy on the training data
trn.preds <- predict(reg3, ins.trn)
accuracy(trn.preds, ins.trn$charges)

# Accuracy on the hold-out data
vld.preds <- predict(reg3, ins.vld)
accuracy(vld.preds, ins.vld$charges)
```

Partitionin data using method-2 
```
# Set seed for reproducibility
set.seed(123)

# Determine the number of rows for training set
train_rows <- round(0.75 * nrow(house_prices))

# Randomly select rows for training set
train_indices <- sample(1:nrow(house_prices), train_rows, replace = FALSE)

# Create training set
train_data <- house_prices[train_indices, ]

# Create validation set
validation_data <- house_prices[-train_indices, ]
```


* -
```
#---- Feature Selection ----
# Stepwise regression to select the "best" model
# The step() function uses "AIC" as the criterion
# Default direction is "both" but can be set to
# "backward" if starting from full model

reg4 <- step(reg3, direction = "both")
summary(reg4)
# This returned the same model as reg3
```





