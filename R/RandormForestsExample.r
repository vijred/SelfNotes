# VJ
# setwd("C:/RCIS417/FinalExam")
getwd()


smb <- read.csv("SomeData.csv", stringsAsFactors = TRUE)
str(smb)



## Use column names directly without using smb#
attach(smb)


# Sample Data 
head(smb)

# distributions for the numerical variables
# distributions for the numerical variables
par(mfrow = c(4,4)) # creating plots in a 2 x 2 grid
hist(Sales, xlab = "Sales ($)")
hist(Ln_Sales, xlab = "Ln value of Sales")
hist(Total_Assets, xlab = "Total_Assets $")

# log() is the R way to calcualte ln, validated with sample data 
hist(log(Total_Assets), xlab = "Log of (Total_Assets)")

hist(Inc_Bef_Tax , xlab = "Income Before Tax")
hist(Inventory, xlab = "Inventory")
hist(log(Inventory), xlab = "Log(Inventory)")
hist(PL_Year, xlab = "Profit/Loss Ratio")
hist(Per_Exp, xlab = "fsddsad Expeniture Ratio")
hist(Liq_Assets, xlab = "fadf_Assets Ratio")
hist(Share_Eq, xlab = "Share Equity Ratio")
hist(Subs_Cap, xlab = "Subs_Cap    ")
hist(Mgmt_Tenure , xlab = "adsfds - Days")
hist(Mgmt_Avg_Age , xlab = "Mgmt_Avg_Age - Years")

par(mfrow = c(1,1)) # resetting the grid back

# Adding new columns as planned 
smb <- data.frame(smb[,1:4], Ln_Total_Assets = log(Total_Assets), smb[,5:6], Ln_Inventory = log(Inventory), smb[,7:ncol(smb)])
str(smb)

# Detach and attach for new variables 
detach(smb)
attach(smb)



# Explore categorical variables 
table(Mgmt_Young)
prop.table(table(Mgmt_Young))

table(Failed)
prop.table(table(Failed))



# Explore relationships  
par(mfrow = c(2,6)) # creating plots in a 2 x 6 grid
plot(Ln_Sales ~ Failed, xlab = "Ln_Sales", ylab = "Failed")
plot(Ln_Total_Assets ~ Failed, xlab = "Ln_Total_Assets", ylab = "Failed")
plot(Inc_Bef_Tax     ~ Failed, xlab = "Inc_Bef_Tax", ylab = "Failed")
plot(Ln_Inventory    ~ Failed, xlab = "dsafd_Inventory", ylab = "Failed")
plot(Inventory    ~ Failed, xlab = "Ln_Inventory", ylab = "Failed")
plot(PL_Year         ~ Failed, xlab = "PL_Year", ylab = "Failed")
plot(Per_Exp         ~ Failed, xlab = "Per_Exp", ylab = "Failed")
plot(Liq_Assets      ~ Failed, xlab = "Liq_Assets", ylab = "Failed")
plot(Share_Eq        ~ Failed, xlab = "eafdfd_Eq", ylab = "Failed")
plot(Subs_Cap        ~ Failed, xlab = "Subs_Cap", ylab = "Failed")
plot(Mgmt_Tenure     ~ Failed, xlab = "Mgmt_Tenure", ylab = "Failed")
plot(Mgmt_Avg_Age        ~ Failed, xlab = "Mgmt_Avg_Age", ylab = "Failed")

par(mfrow = c(1,1)) # resetting the grid back

# Young Management 
plot(Mgmt_Young      ~Failed, xlab = "Failed",      ylab = "Mgmt_Young", main = NULL, col = c("green","red")) 


# par(mfrow = c(3,3)) # creating plots in a 2 x 6 grid

# ggplot(smb, aes(x=Ln_Sales, fill=Failed)) +   geom_density(alpha = 0.4) +   scale_fill_manual(values = c("green", "red"))
# ggplot(smb, aes(x=Inc_Bef_Tax, fill=Failed)) +   geom_density(alpha = 0.4) +   scale_fill_manual(values = c("green", "red"))
# ggplot(smb, aes(x=PL_Year, fill=Failed)) +   geom_density(alpha = 0.4) +   scale_fill_manual(values = c("green", "red"))

# ggplot(smb, aes(x=Per_Exp, fill=Failed)) +  geom_density(alpha = 0.4) +  scale_fill_manual(values = c("green", "red"))
# ggplot(smb, aes(x=Share_Eq, fill=Failed)) +  geom_density(alpha = 0.4) +  scale_fill_manual(values = c("green", "red"))
# ggplot(smb, aes(x=Subs_Cap, fill=Failed)) +  geom_density(alpha = 0.4) +  scale_fill_manual(values = c("green", "red"))

# ggplot(smb, aes(x=Mgmt_Tenure, fill=Failed)) +  geom_density(alpha = 0.4) +  scale_fill_manual(values = c("green", "red"))
# ggplot(smb, aes(x=Mgmt_Avg_Age, fill=Failed)) +  geom_density(alpha = 0.4) +  scale_fill_manual(values = c("green", "red"))
# # plot(Mgmt_Young      ~Failed, xlab = "Failed",      ylab = "Mgmt_Young", main = NULL, col = c("green","red")) 

# par(mfrow = c(1,1)) # resetting the grid back


library(ggplot2)
library(gridExtra)

# 
plot1 <- ggplot(smb, aes(x=Ln_Sales, fill=Failed)) +   geom_density(alpha = 0.4) +   scale_fill_manual(values = c("green", "red")) + ggtitle("Ln_Sales")
plot2 <- ggplot(smb, aes(x=Inc_Bef_Tax, fill=Failed)) +   geom_density(alpha = 0.4) +   scale_fill_manual(values = c("green", "red"))  + ggtitle("Inc_Bef_Tax")
plot3 <- ggplot(smb, aes(x=PL_Year, fill=Failed)) +   geom_density(alpha = 0.4) +   scale_fill_manual(values = c("green", "red"))  + ggtitle("PL_Year")

plot4 <-  ggplot(smb, aes(x=Per_Exp, fill=Failed)) +  geom_density(alpha = 0.4) +  scale_fill_manual(values = c("green", "red")) + ggtitle("Per_Exp")
plot5 <-  ggplot(smb, aes(x=Share_Eq, fill=Failed)) +  geom_density(alpha = 0.4) +  scale_fill_manual(values = c("green", "red")) + ggtitle("Share_Eq")
plot6 <-  ggplot(smb, aes(x=Subs_Cap, fill=Failed)) +  geom_density(alpha = 0.4) +  scale_fill_manual(values = c("green", "red")) + ggtitle("Subs_Cap")

plot7 <-  ggplot(smb, aes(x=Mgmt_Tenure, fill=Failed)) +  geom_density(alpha = 0.4) +  scale_fill_manual(values = c("green", "red")) + ggtitle("Mgmt_Tenure")
plot8 <- ggplot(smb, aes(x=Mgmt_Avg_Age, fill=Failed)) +  geom_density(alpha = 0.4) +  scale_fill_manual(values = c("green", "red"))  + ggtitle("Mgmt_Avg_Age")
plot9 <- ggplot(smb, aes(x=Ln_Total_Assets, fill=Failed)) +  geom_density(alpha = 0.4) +  scale_fill_manual(values = c("green", "red"))  + ggtitle("Ln_Total_Assets")



# Arrange the plots in a grid
grid.arrange(plot1, plot2, plot3, plot4, plot5, plot6, plot7, plot8, plot9,  ncol = 3, nrow = 3)


ggplot(smb, aes(x = Ln_Total_Assets, y = PL_Year, shape = Failed, col = Failed)) + 
  geom_point() + 
  geom_smooth(method = lm, se = FALSE) 

summary(Share_Eq)




# Partitioning the data  
# Set seed for reproducibility
set.seed(123)

# # Determine the number of rows for training set
# train_rows <- round(0.80 * nrow(smb))
# # Randomly select rows for training set
# train_indices <- sample(1:nrow(smb), train_rows, replace = FALSE)

train_indices <- sample(1:nrow(smb), 0.80 * nrow(smb), replace = FALSE)

# Create training set
smb.trn <- smb[train_indices, ]

# Create validation set
smb.vld <- smb[-train_indices, ]

head(smb.trn)
head(smb.vld)


nrow(smb.trn)
nrow(smb.vld)


#####################
### Problem-2
##################### 
prop.table(table(smb.trn$Failed))
prop.table(table(smb.vld$Failed))


library(rpart) 
library(rpart.plot) 

# Creating a decision tree with default settings 
tree1 <- rpart(Failed~Sales + Ln_Sales + Total_Assets + Ln_Total_Assets + Inc_Bef_Tax + Inventory + Ln_Inventory + PL_Year + Per_Exp + Liq_Assets + Share_Eq + Subs_Cap + Mgmt_Tenure + Mgmt_Avg_Age + Mgmt_Young,  
               data = smb.trn, method = "class") 

# Understand error at different split levels, tree is created with nsplit value as 4 
tree1$cptable

talltree <- rpart(Failed~Sales + Ln_Sales + Total_Assets + Ln_Total_Assets + Inc_Bef_Tax + Inventory + Ln_Inventory + PL_Year + Per_Exp + Liq_Assets + Share_Eq + Subs_Cap + Mgmt_Tenure + Mgmt_Avg_Age + Mgmt_Young,  
                  data = smb.trn, method = "class", cp = 0, minsplit = 1) # create tree 

# Understand error at different split levels , Best Tree will be created with nsplit value as 7
talltree$cptable

bestcp <- which(talltree$cptable[,"xerror"] == min(talltree$cptable[,"xerror"]))
bestcp 

# complexity parameter in a variable 

makecp <- talltree$cptable[bestcp[1], "CP"] 
makecp

# pruning the tree with this cp value 
prunedtree <- prune(talltree, cp = makecp) # using the cp from above 
prp(prunedtree, type=2, extra=1, under=TRUE, varlen=0) 
preds.trn <- predict(prunedtree, smb.trn, type = "class") 

library(caret)  
confusionMatrix(preds.trn, smb.trn$Failed, positive = "Yes") 


# validation data 
preds.vld <- predict(prunedtree, smb.vld, type = "class") 

#prediction on validation data
probs.vld <- predict(prunedtree, smb.vld, type = "prob")

head(preds.vld)
head(probs.vld)

# validation data
cm.vld <- confusionMatrix(preds.vld, smb.vld$Failed, positive = "Yes")
cm.vld


#####################
### Problem-3
##################### 




logreg <- glm(Failed ~ Sales + Ln_Sales + Total_Assets + Ln_Total_Assets + Inc_Bef_Tax + Inventory + PL_Year + Per_Exp + Liq_Assets + Share_Eq + Subs_Cap + Mgmt_Tenure + Mgmt_Avg_Age + Mgmt_Young , 
              data = smb.trn, family = "binomial")

summary(logreg)




preds.trn <- predict(logreg, smb.trn, type = "response")
# View(preds.trn)

preds.vld <- predict(logreg, smb.vld, type = "response")
# View(preds.vld)


cutoff <- 0.5

## training data
labels.trn <- ifelse(preds.trn > cutoff, "Yes", "No") # predictions
trnpreds <- data.frame(Actual = smb.trn$Failed, Predicted = labels.trn)
# View(trnpreds) # looking at actual versus predictions

accuracy <- mean(trnpreds$Actual == trnpreds$Predicted)
print(paste("Accuracy on Training Data:",round(accuracy, 3)))

## validation data
labels.vld <- ifelse(preds.vld > cutoff, "Yes", "No") # predictions
vldpreds <- data.frame(Actual = smb.vld$Failed, Predicted = labels.vld)
# View(vldpreds) # looking at actual versus predictions

accuracy <- mean(vldpreds$Actual == vldpreds$Predicted)
print(paste("Accuracy on Validation Data:",round(accuracy, 3)))

# To compare to the accuracy of a naive model
# we can predict the majority class for everyone and
# see the accuracy of that model

prop.table(table(smb.vld$Failed))

# Creating a confusion matrix
table(Predictions = vldpreds$Predicted, Actuals = vldpreds$Actual)



## Use Best GLM 
#---- Variable Selection ----
library(bestglm)
str(smb.trn)
smb.trn <- data.frame(smb.trn[,1:15], Mgmt_Old = ifelse(smb.trn$Mgmt_Avg_Age >= 50, "Yes", "No"), smb.trn[,16:ncol(smb.trn)])
smb.trn$Mgmt_Old <- as.factor(smb.trn$Mgmt_Old)  
smb.vld <- data.frame(smb.vld[,1:15], Mgmt_Old = ifelse(smb.vld$Mgmt_Avg_Age >= 50, "Yes", "No"), smb.vld[,16:ncol(smb.vld)])
smb.vld$Mgmt_Old <- as.factor(smb.vld$Mgmt_Old)
str(smb.trn)

# Removing known low performing variable to avoid very long running times 
smb.trn.bestglm <- smb.trn[,c(-1,-2,-4,-6,-7,-8,-10,-11,-13,-15)]
str(smb.trn.bestglm)

# Failed is the last column and removing businessID, Ln_Inventory, mgmt_age from model search variable 
logitmodels <- bestglm(smb.trn.bestglm,
                       family = binomial,
                       IC = "BIC",
                       method = "exhaustive")
logreg2 <- logitmodels$BestModel
summary(logreg2)
summary(logreg) # for comparison

# Calculating accuracy of this model on the validation data set

preds.vld2 <- predict(logreg2, smb.vld, type = "response")
cutoff <- 0.5
labels.vld2 <- ifelse(preds.vld2 > 0.5, "Yes", "No") # predictions


## validation data
vldpreds2 <- data.frame(Actual = smb.vld$Failed, Predicted = labels.vld2)
accuracy <- mean(vldpreds2$Actual == vldpreds2$Predicted)
print(paste("Accuracy on Validation Data:",round(accuracy, 3)))

# To compare to the accuracy of a naive model
# we can predict the majority class for everyone and
# see the accuracy of that model

prop.table(table(smb.vld$Failed))

# Creating a confusion matrix
table(Predictions = vldpreds$Predicted, Actuals = vldpreds$Actual)


##---- ROC Curve ----
library(pROC)

roc_curve <- roc(ifelse(smb.vld$Failed == "Yes", 1, 0), preds.vld2)

plot(1-roc_curve$specificities,roc_curve$sensitivities,type="l",
     ylab="Sensitiviy = TPR",xlab="FPR = 1-Specificity",col="black",lwd=2,
     main = "ROC Curve")
abline(0,1, lty = 2) # This adds the reference line

auc(roc_curve) # area under the curve




###
# Assume Cost of FN = $10000
# Assume Cost of FP = $1000
# Find cut-off that minimizes the total expected cost per unit

q1 <- 10000  # cost of False negative
q2 <- 1000   # cost of False positive


cutoffs <- seq(from = 0.05, to = 1, by = 0.05) 

# initializing data frame to keep track of accuracy
expcost.df <- data.frame(Cutoff = cutoffs, 
                         Exp.Cost = rep(0, length(cutoffs)))


for (i in 1:length(cutoffs)){ 
  preds.val.result <- factor(ifelse(preds.vld2 <= cutoffs[i], "No", "Yes"),  
                             levels = c("No", "Yes")) 
  cm.trn <- confusionMatrix(preds.val.result, smb.vld$Failed, positive = "Yes") 
  fps <- cm.trn$table[2,1]  # FP is element [1,2] in the table 
  fns <- cm.trn$table[1,2]  # FN is element [2,1] in the table 
  tot <- cm.trn$table[1,1]+cm.trn$table[1,2]+cm.trn$table[2,1]+cm.trn$table[2,2]
  ecost <- (q1*fns + q2*fps)/tot # calculating expected cost per unit 
  expcost.df[i,2] <- ecost # storing expected cost per unit 
} 


expcost.df  # printing out the expected costs


# Deepdive for more accurate value around 0.1

cutoffs <- seq(from = 0.05, to = 0.20, by = 0.005) 

# initializing data frame to keep track of accuracy
expcost.df <- data.frame(Cutoff = cutoffs, 
                         Exp.Cost = rep(0, length(cutoffs)))


for (i in 1:length(cutoffs)){ 
  preds.val.result <- factor(ifelse(preds.vld2 <= cutoffs[i], "No", "Yes"),  
                             levels = c("No", "Yes")) 
  cm.trn <- confusionMatrix(preds.val.result, smb.vld$Failed, positive = "Yes") 
  fps <- cm.trn$table[2,1]  # FP is element [1,2] in the table 
  fns <- cm.trn$table[1,2]  # FN is element [2,1] in the table 
  tot <- cm.trn$table[1,1]+cm.trn$table[1,2]+cm.trn$table[2,1]+cm.trn$table[2,2]
  ecost <- (q1*fns + q2*fps)/tot # calculating expected cost per unit 
  expcost.df[i,2] <- ecost # storing expected cost per unit 
} 


expcost.df  # printing out the expected costs

#plotting the expected cost

plot(expcost.df$Cutoff, expcost.df$Exp.Cost, type="o", col="blue2", 
     lty=1, pch = 20, xlab="Cutoff", ylab="Cost", main="Misclassification Cost per Unit")
abline(h=min(expcost.df$Exp.Cost), lty =2, col = "red")

bestcutoff <- which.min(expcost.df[,2])
bestcutoff
cutoff <- expcost.df[bestcutoff,1]
cutoff

# confusion matrix 
preds.val.result <- factor(ifelse(preds.vld <= cutoff, "No", "Yes"),  
                           levels = c("No", "Yes")) 
cm.trn <- confusionMatrix(preds.val.result, smb.vld$Failed, positive = "Yes") 
cm.trn


#####################
### Problem-4
##################### 

smbep  <- read.csv("FinalExamPredictions.csv", header = TRUE, stringsAsFactors = TRUE) 
smbep$Mgmt_Old <- as.factor(ifelse(smbep$Mgmt_Avg_Age >= 50, "Yes", "No"))  
smbep$Ln_Total_Assets <- log(smbep$Total_Assets)

preds.smbep <- predict(logreg2, smbep, type = "response")

preds.smbep.results <- factor(ifelse(preds.smbep <= cutoff, "No", "Yes") ) 

smbep2 <- smbep

smbep2$Failed <- preds.smbep.results
summary(smbep2)
# predictions.df <- smbp2[,c("BusID","preds.smbp.results")]
predictions.df <- smbep2[,c("BusID","Failed")]
write.csv(predictions.df,"Kundanagurthi_VijayaBhaskar.csv")

detach(smb)
rm(list=ls())



