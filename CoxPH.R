# =============================================================================
# Cox Proportional Hazards (Cox-PH) Model
# -----------------------------------------------------------------------------
# Models the hazard of employee attrition as a function of demographic, job and
# work-experience covariates, using YearsAtCompany as the survival time and
# Attrition as the event indicator.
#
# Input : Attrition_Data.csv (must be in the working directory)
# Output: - Cox-PH model coefficients / hazard ratios (summary)
#         - Proportional-hazards assumption check (cox.zph + ggcoxzph)
#         - Baseline cumulative hazard and predicted survival probabilities
#
# Required packages: survival, survminer, pec
# =============================================================================

library(survival)
library(survminer)
library(pec)            # predictSurvProb()

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

# ---- Fit the Cox-PH model ---------------------------------------------------
# x = TRUE retains the model matrix, which predictSurvProb() requires later.
cox.model <- coxph(
  Surv(YearsAtCompany, Attrition) ~ Department + BusinessTravel + Gender + Age +
    DistanceFromHome + Education + EducationField + EnvironmentSatisfaction +
    JobInvolvement + JobLevel + JobRole + JobSatisfaction + MaritalStatus +
    MonthlyIncome + NumCompaniesWorked + OverTime + PercentSalaryHike +
    PerformanceRating + RelationshipSatisfaction + TotalWorkingYears +
    YearsInCurrentRole + YearsSinceLastPromotion + YearsWithCurrManager,
  data = data, x = TRUE
)
summary(cox.model)

# ---- Check the proportional-hazards assumption ------------------------------
test_ph <- cox.zph(cox.model)
test_ph
ggcoxzph(test_ph)

# ---- Baseline survival and hazard -------------------------------------------
SurvObject <- Surv(data$YearsAtCompany, data$Attrition)
fit <- survfit(SurvObject ~ 1, data = data)
plot(fit, xlab = "Time (years)", ylab = "Survival")

basehaz(cox.model, centered = TRUE)

# ---- Predicted survival probabilities ---------------------------------------
times <- data$YearsAtCompany[data$Attrition == 0 | data$Attrition == 1]
Pred_Prob <- predictSurvProb(cox.model, newdata = data[, c(-2, -32)], times = times)
View(Pred_Prob)
