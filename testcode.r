
#set.seed(7)

library(mlbench)
library(caret)
library(sp)
library(rgdal)
library(kernlab)

mydata <- read.csv("D:/SupportVectorRegression/Origin/TestDatasetR_1000.csv", header=TRUE)

mydata$meuse.xy <- mydata[, c("estate_Lng", "estate_Lat")]
mydata$estate_TotalPrice <- mydata$estate_TotalPrice

col_idx  <- grep("estate_TotalPrice", names(mydata))
df<- mydata[, c(col_idx, (1:ncol(mydata))[-col_idx])]







dealdata <- mydata[,-c(24:25,46)]

newdata <- cbind(mydata[,1:44],mydata$estate_TotalPrice)



rfectrl <- rfeControl(functions=lmFuncs, method="cv", number=10, repeats=3,verbose=TRUE,returnResamp = "final")
# run the RFE algorithm
results <- rfe(dealdata[1:43], dealdata[1:44],size=c(1:44),rfeControl=rfectrl,method = "svmRadial",metric = "Rsquared")
#,metric = "Rsquared"
# summarize the results
print(results)
# list the chosen features
predictors(results)
# plot the results
plot(results, type=c("g", "o"))