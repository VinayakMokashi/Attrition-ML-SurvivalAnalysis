# =============================================================================
# Random Survival Forest (RSF)
# -----------------------------------------------------------------------------
# Fits a Random Survival Forest for right-censored attrition data to rank
# variable importance and predict employee survival probabilities. Suited to
# high-dimensional data with non-linear covariate interactions.
#
# Input : Attrition_Data.csv (must be in the working directory)
# Output: - Fitted RSF model and OOB error
#         - Permutation variable importance (VIMP) and minimal-depth selection
#         - Predicted survival on the held-out test set
#
# Required packages: randomForestSRC, survival
# =============================================================================

library(randomForestSRC)
library(survival)

# ---- Load and prepare data --------------------------------------------------
data <- read.csv("Attrition_Data.csv", header = TRUE)

# Encode the event indicator: Yes -> 1 (event), No -> 0 (censored)
data$Attrition[data$Attrition == "Yes"] <- 1
data$Attrition[data$Attrition == "No"]  <- 0
data$Attrition <- as.numeric(data$Attrition)

# Convert categorical columns to factors
data[, c(3, 5, 7, 8, 12, 16, 18, 23, 22)] <-
  lapply(data[, c(3, 5, 7, 8, 12, 16, 18, 23, 22)], as.factor)
str(data)

# ---- Train / test split (1029 / 441) ----------------------------------------
set.seed(1000)
train <- sample(1:1470, 1029, replace = FALSE)
TrainingData <- data[train, ]
TestingData  <- data[-train, ]
nrow(TrainingData)
nrow(TestingData)

# ---- Fit the Random Survival Forest -----------------------------------------
fit <- rfsrc(
  Surv(YearsAtCompany, Attrition) ~ RelationshipSatisfaction + StandardHours +
    StockOptionLevel + TotalWorkingYears + TrainingTimesLastYear +
    WorkLifeBalance + YearsInCurrentRole + YearsSinceLastPromotion +
    YearsWithCurrManager + PerformanceRating + PercentSalaryHike + Age +
    BusinessTravel + DailyRate + Department + DistanceFromHome + Education +
    EducationField + EmployeeCount + EmployeeNumber + EnvironmentSatisfaction +
    Gender + HourlyRate + JobInvolvement + JobLevel + JobSatisfaction +
    MaritalStatus + MonthlyIncome + MonthlyRate + NumCompaniesWorked + OverTime,
  data = TrainingData, ntree = 1000, mtry = 6, nsplit = 3, importance = TRUE
)
fit
plot(fit)

# ---- Variable importance ----------------------------------------------------
vimp(fit, importance = "permute")$importance   # permutation VIMP
var.select(object = fit, method = "md")         # minimal-depth selection

# ---- Predict on the test set ------------------------------------------------
pred <- predict(fit, TestingData)
pred
head(pred$predicted, 30)
head(pred$survival)
plot.survival(pred)
