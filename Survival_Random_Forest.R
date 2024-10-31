data = read.csv(file.choose(),header = T)
View(data)
#str(data)
data$Attrition[data$Attrition=="Yes"]=1
data$Attrition[data$Attrition=="No"]=0
#str(data)
data$Attrition=as.numeric(data$Attrition)
#str(data)

data[,c(3,5,7,8,12,16,18,23,22)]=lapply(data[,c(3,5,7,8,12,16,18,23,22)],as.factor)
str(data)

# install.packages("randomForestSRC")
library(randomForestSRC)
library(survival)
?rfsrc

set.seed(1000)
train=sample(1:1470,1029,replace=FALSE)
TrainingData=data[train,]
TestingData=data[-train,]


nrow(TrainingData)
nrow(TestingData)
View(TrainingData)
View(TestingData)
sqrt(31)
?rfsrc
fit=rfsrc(Surv(YearsAtCompany, Attrition)~RelationshipSatisfaction+StandardHours+StockOptionLevel+TotalWorkingYears+TrainingTimesLastYear+WorkLifeBalance+YearsInCurrentRole+YearsSinceLastPromotion+YearsWithCurrManager+PerformanceRating+PercentSalaryHike+Age+BusinessTravel+DailyRate+Department+DistanceFromHome+Education+EducationField+EmployeeCount+EmployeeNumber+EnvironmentSatisfaction+Gender+HourlyRate+JobInvolvement+JobLevel+JobSatisfaction+MaritalStatus+MonthlyIncome +MonthlyRate+NumCompaniesWorked+OverTime, data=TrainingData, ntree=1000, mtry=6, nsplit=3, importance=TRUE)
fit
summary(fit)
plot(fit)
?vimp
?randomForestSRC::rfsrc
?randomForestSRC::vimp
vimp(fit, importance="permute")
vimp(fit, importance="permute")$importance
?var.select
var.select(object=fit,method="md")
?predict
pred=predict(fit,TestingData)
pred
1-0.08350962
head(pred$predicted,30)
head(pred$survival)
plot(pred)
plot.survival(pred)
?plot.survival


