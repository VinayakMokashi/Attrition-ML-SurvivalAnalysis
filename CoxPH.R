library(survival)
library(KMsurv)
library(survminer)
library(JM)
library(pec)
library(riskRegression)
data3 = read.csv(file.choose(),header = T)
str(data3)
data3$Attrition[data3$Attrition=="Yes"]=1 #Conv Yes No to 1 0 since aage status variable needs nymeric vectors
data3$Attrition[data3$Attrition=="No"]=0
str(data3)
data3$Attrition=as.numeric(data3$Attrition)
?lapply
str(data3)

data3[,c(3,5,7,8,12,16,18,23,22)]=lapply(data3[,c(3,5,7,8,12,16,18,23,22)],as.factor)
str(data3)


#
test_ph <- cox.zph(cox.model)
test_ph
cox.model <- coxph(Surv(YearsAtCompany,Attrition)~RelationshipSatisfaction+StandardHours+StockOptionLevel+TotalWorkingYears+TrainingTimesLastYear+WorkLifeBalance+PerformanceRating+PercentSalaryHike+BusinessTravel+DailyRate+Department+DistanceFromHome+Education+EmployeeCount+EmployeeNumber+EnvironmentSatisfaction+Gender+HourlyRate+JobInvolvement+JobLevel+JobSatisfaction+MonthlyIncome +MonthlyRate+OverTime,data=data3)
summary(cox.model)
cox.model$formula
SurvObject1=Surv(data3$YearsAtCompany,data3$Attrition)
?survfit
fit1=survfit(SurvObject1~1,data=data3)
summary(fit1)
library(survminer)
plot(fit1,  xlab="Time", ylab="Survival")
summary(cox.model)
?basehaz
basehaz(cox.model,centered=TRUE)
?cox.zph
?cox.zph

library(survival)
library(KMsurv)









new=data3
surv_time_Cox = survfit(fit2, new)
surv_time_Cox
colnames(data3)
cox.model <- coxph(Surv(YearsAtCompany,Attrition)~Department+BusinessTravel+Gender+Age+ DistanceFromHome+ Education+ EducationField+ EnvironmentSatisfaction +JobInvolvement+ JobLevel+ JobRole +JobSatisfaction +MaritalStatus+ MonthlyIncome+ NumCompaniesWorked+ OverTime+ PercentSalaryHike+ PerformanceRating+ RelationshipSatisfaction+ TotalWorkingYears+ YearsInCurrentRole+ YearsSinceLastPromotion+ YearsWithCurrManager ,data=data3,x=TRUE)
?predictSurvProb
cox.model$timefix
S=survfit(cox.model)
S$surv
pred<-predict(S,type='expected')
basehaz(cox.model)
surv_prob<-exp(-pred)
t=data3$YearsAtCompany[(data3$Attrition==0 | data3$Attrition==1 )]
Pred_Prob <- predictSurvProb(cox.model,newdata=data3[,c(-2,-32)], times = t)
View(Pred_Prob)
ggcoxzph(test_ph)


