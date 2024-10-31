library(survival)
library(KMsurv)



data=read.csv(file.choose(),header=TRUE)
View(data)
table(data$Attrition)
time<- data$YearsAtCompany
data$Attrition[data$Attrition=="Yes"]=1
data$Attrition[data$Attrition=="No"]=0
data$Attrition=as.numeric(data$Attrition)
delta<- data$Attrition
data1 <- data.frame(time,delta)
View(data1)

survobj1 <- Surv(data1$time,data1$delta)
#1b.Kaplan-Meier Estimator
fit1 = survfit(survobj1~1,data = data1)
summary(fit1)
sum(fit1$n.event)
plot(fit1$time,fit1$surv, xlab="Time", ylab="Survival",type="l")
#Survival Curve
ggsurvplot(fit1, data = data1, pval = TRUE)
?plot.sur