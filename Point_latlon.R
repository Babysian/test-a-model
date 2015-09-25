#set.seed(7)
# load the library
library(mlbench)
library(caret)
# load the data
data(PimaIndiansDiabetes)
# define the control using a random forest selection function
mydata <- read.csv("D:/SupportVectorRegression/Origin/TestDatasetR_1000.csv", header=TRUE)
dealdata<-data.frame(mydata[,1:23],mydata[,26:46])
location = data.frame(mydata[, c("estate_Lng", "estate_Lat")])
newdata<-cbind.data.frame(dealdata[,1:44])
#data.matrix(location),
rfectrl <- rfeControl(functions=lmFuncs, method="cv", number=10, repeats=3,verbose=TRUE,returnResamp = "final")
# run the RFE algorithm
results <- rfe(data.matrix(location), newdata[,44], rfeControl=rfectrl,method = "svmRadial",metric = "Rsquared")
#,metric = "Rsquared"
# summarize the results
print(results)
# list the chosen features
predictors(results)
# plot the results
plot(results, type=c("g", "o"))