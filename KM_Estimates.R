# =============================================================================
# Kaplan-Meier Survival Estimates
# -----------------------------------------------------------------------------
# Estimates the non-parametric survival probability of employees over tenure
# (YearsAtCompany), treating Attrition == "Yes" as the event of interest.
#
# Input : Attrition_Data.csv (must be in the working directory)
# Output: Kaplan-Meier survival curve with 95% CI and log-rank p-value
#
# Required packages: survival, KMsurv, survminer
# =============================================================================

library(survival)
library(KMsurv)
library(survminer)

# ---- Load and prepare data --------------------------------------------------
data <- read.csv("Attrition_Data.csv", header = TRUE)

table(data$Attrition)

# Encode the event indicator: Yes -> 1 (event), No -> 0 (censored)
time <- data$YearsAtCompany
data$Attrition[data$Attrition == "Yes"] <- 1
data$Attrition[data$Attrition == "No"]  <- 0
data$Attrition <- as.numeric(data$Attrition)
delta <- data$Attrition

surv_data <- data.frame(time, delta)

# ---- Kaplan-Meier estimator -------------------------------------------------
survobj <- Surv(surv_data$time, surv_data$delta)
fit <- survfit(survobj ~ 1, data = surv_data)

summary(fit)
sum(fit$n.event)   # total number of attrition events

# ---- Plots ------------------------------------------------------------------
# Base R survival curve
plot(fit$time, fit$surv, xlab = "Time (years)", ylab = "Survival", type = "l")

# Publication-quality survival curve with confidence band and log-rank p-value
ggsurvplot(fit, data = surv_data, pval = TRUE)
