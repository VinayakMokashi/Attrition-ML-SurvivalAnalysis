# =============================================================================
# Logistic Regression for Attrition Classification
# -----------------------------------------------------------------------------
# Predicts the binary attrition outcome (Yes/No) using a stepwise-selected
# logistic regression model. Reports ROC/AUC and confusion matrices on both the
# training and testing splits, plus a Hosmer-Lemeshow goodness-of-fit test.
#
# Input : Attrition_Data.csv (must be in the working directory)
# Output: ROC curves, AUC, confusion matrices, Hosmer-Lemeshow statistic
#
# Required packages: pROC, performance
# =============================================================================

library(pROC)
library(performance)

# ---- Load and prepare data --------------------------------------------------
JOB_Attrition <- read.csv("Attrition_Data.csv", header = TRUE)

# Encode the binary outcome: Yes -> 1, No -> 0
JOB_Attrition$Attrition[JOB_Attrition$Attrition == "Yes"] <- 1
JOB_Attrition$Attrition[JOB_Attrition$Attrition == "No"]  <- 0
JOB_Attrition$Attrition <- as.numeric(JOB_Attrition$Attrition)

# Convert categorical columns to factors
JOB_Attrition[, c(3, 5, 7, 8, 12, 16, 18, 23)] <-
  lapply(JOB_Attrition[, c(3, 5, 7, 8, 12, 16, 18, 23)], as.factor)

# Over18 is constant ("Y") -> encode as numeric
JOB_Attrition$Over18[JOB_Attrition$Over18 == "Y"] <- 1
JOB_Attrition$Over18 <- as.numeric(JOB_Attrition$Over18)

# ---- Train / test split (70 / 30) -------------------------------------------
set.seed(1000)
ranuni <- sample(x = c("Training", "Testing"), size = nrow(JOB_Attrition),
                 replace = TRUE, prob = c(0.7, 0.3))
TrainingData <- JOB_Attrition[ranuni == "Training", ]
TestingData  <- JOB_Attrition[ranuni == "Testing", ]
nrow(TrainingData)
nrow(TestingData)

# ---- Build the model formula (all predictors) -------------------------------
independentvariables <- colnames(JOB_Attrition[, 2:35])
independentvariables[1] <- "Age"
formula <- as.formula(paste("Attrition ~", paste(independentvariables, collapse = "+")))
formula

# ---- Fit logistic regression with stepwise selection ------------------------
Trainingmodel1 <- glm(formula = formula, data = TrainingData, family = "binomial")
Trainingmodel1 <- step(object = Trainingmodel1, direction = "both")
summary(Trainingmodel1)

# ---- Training performance ---------------------------------------------------
troc <- roc(response = Trainingmodel1$y, predictor = Trainingmodel1$fitted.values, plot = TRUE)
troc$auc
trpred <- ifelse(test = Trainingmodel1$fitted.values > 0.5, yes = 1, no = 0)
table(Trainingmodel1$y, trpred)   # training confusion matrix

# ---- Testing performance ----------------------------------------------------
testpred <- predict.glm(object = Trainingmodel1, newdata = TestingData, type = "response")
tsroc <- roc(response = TestingData$Attrition, predictor = testpred, plot = TRUE)
tsroc$auc
testpred <- ifelse(test = testpred > 0.5, yes = 1, no = 0)
table(TestingData$Attrition, testpred)   # testing confusion matrix

# ---- Goodness of fit --------------------------------------------------------
performance_hosmer(Trainingmodel1)
