JOB_Attrition=read.csv(file.choose(),header=TRUE)
View(JOB_Attrition)
JOB_Attrition$Attrition[JOB_Attrition$Attrition=="Yes"]=1
JOB_Attrition$Attrition[JOB_Attrition$Attrition=="No"]=0
JOB_Attrition$Attrition=as.numeric(JOB_Attrition$Attrition)
JOB_Attrition[,c(3,5,7,8,12,16,18,23)]=lapply(JOB_Attrition[,c(3,5,7,8,12,16,18,23)],as.factor)
JOB_Attrition$Over18[JOB_Attrition$Over18=="Y"]=1
JOB_Attrition$Over18=as.numeric(JOB_Attrition$Over18)
set.seed(1000)
ranuni=sample(x=c("Training","Testing"),size=nrow(JOB_Attrition),replace=T,prob=c(0.7,0.3))
TrainingData=JOB_Attrition[ranuni=="Training",]
TestingData=JOB_Attrition[ranuni=="Testing",]
nrow(TrainingData)
nrow(TestingData)


independentvariables=colnames(JOB_Attrition[,2:35])
independentvariables[1]="Age"
independentvariables
Model=paste(independentvariables,collapse="+")
Model
Model_1=paste("Attrition~",Model)
Model_1
class(Model_1)
formula=as.formula(Model_1)
formula
Trainingmodel1=glm(formula=formula,data=TrainingData,family="binomial")
Trainingmodel1=step(object = Trainingmodel1,direction = "both")
summary(Trainingmodel1)
#install.packages("pROC")
library("pROC")
troc=roc(response=Trainingmodel1$y,predictor = Trainingmodel1$fitted.values,plot=T)
troc$auc
trpred=ifelse(test=Trainingmodel1$fitted.values>0.5,yes = 1,no=0)
table(Trainingmodel1$y,trpred)



testpred=predict.glm(object=Trainingmodel1,newdata=TestingData,type = "response")
testpred
tsroc=roc(response=TestingData$Attrition,predictor = testpred,plot=T)
tsroc$auc
testpred=ifelse(test=testpred>0.5,yes=1,no=0)
table(TestingData$Attrition,testpred)
#install.packages("psych")
#install.packages("gmodels")
library("psych")
library("gmodels")
#install.packages('largesamplehl')
library('largesamplehl')
#install.packages("performance")
library(performance)
?performance_hosmer
performance_hosmer(Trainingmodel1)







# install.packages("MKmisc")
library("MKmisc")                   

