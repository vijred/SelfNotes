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

