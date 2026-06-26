# Employee Attrition Prediction Using ML & Survival Analysis

Predicting employee turnover and modelling *when* employees are likely to leave,
using survival analysis and machine learning on the IBM HR Analytics Employee
Attrition & Performance dataset. The project identifies the key drivers of
attrition and translates them into practical retention strategies.

## Project Overview

Employee attrition is a costly challenge for organizations, causing operational
disruption and higher hiring and training expenses. This project combines four
complementary techniques:

- **Kaplan-Meier estimates** — describe the overall survival (retention) curve.
- **Cox Proportional Hazards model** — quantify how each covariate shifts the
  hazard of leaving.
- **Logistic regression** — classify whether an employee will leave, reaching
  **~87.2% accuracy** with a stepwise-selected model.
- **Random Survival Forest** — rank feature importance and predict survival
  probabilities for high-dimensional, interaction-rich data.

Together they answer both "*who* is likely to leave" and "*how long* employees
tend to stay."

## Dataset

The analysis uses the **IBM HR Analytics Employee Attrition & Performance**
dataset ([Kaggle source](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset)),
included here as [`Attrition_Data.csv`](Attrition_Data.csv).

- **1,470** employee records across **35** attributes.
- **Demographics** — Age, Gender, MaritalStatus, DistanceFromHome.
- **Job information** — Department, JobRole, JobLevel, MonthlyIncome, OverTime.
- **Work experience** — TotalWorkingYears, YearsAtCompany, YearsInCurrentRole,
  YearsWithCurrManager, NumCompaniesWorked.
- **Education & satisfaction** — Education, EducationField, JobSatisfaction,
  EnvironmentSatisfaction, WorkLifeBalance.

**Survival framing:** `YearsAtCompany` is the survival time and `Attrition`
(Yes/No → 1/0) is the event indicator, where employees who have not left are
treated as right-censored.

## Repository Structure

| File | Description |
|------|-------------|
| [`Attrition_Data.csv`](Attrition_Data.csv) | The IBM HR attrition dataset (1,470 × 35). |
| [`KM_Estimates.R`](KM_Estimates.R) | Kaplan-Meier survival estimates and survival curve. |
| [`CoxPH.R`](CoxPH.R) | Cox Proportional Hazards model, PH-assumption check, and predicted survival probabilities. |
| [`Logistic_regression.R`](Logistic_regression.R) | Stepwise logistic regression with ROC/AUC and confusion matrices. |
| [`Survival_Random_Forest.R`](Survival_Random_Forest.R) | Random Survival Forest for variable importance and survival prediction. |
| [`Report.docx`](Report.docx) | Full written report — methodology, results, and interpretation. |
| [`Presentation.pptx`](Presentation.pptx) | Summary slide deck of the project. |
| [`LICENSE`](LICENSE) | MIT License. |

## Prerequisites

- **R** ≥ 4.0 (and optionally [RStudio](https://posit.co/download/rstudio-desktop/)).
- The R packages used across the scripts. Install them once with:

```r
install.packages(c(
  "survival", "KMsurv", "survminer",   # Kaplan-Meier & Cox-PH
  "pec",                               # predicted survival probabilities
  "pROC", "performance",               # logistic regression evaluation
  "randomForestSRC"                    # Random Survival Forest
))
```

## How to Run

1. Clone the repository and open it as your R working directory:

   ```bash
   git clone https://github.com/VinayakMokashi/Attrition-ML-SurvivalAnalysis.git
   cd Attrition-ML-SurvivalAnalysis
   ```

   In R/RStudio, set the working directory to this folder so the scripts can
   find `Attrition_Data.csv`:

   ```r
   setwd("path/to/Attrition-ML-SurvivalAnalysis")
   ```

2. Run any script independently — each loads `Attrition_Data.csv` from the
   working directory and is self-contained. A suggested order:

   ```r
   source("KM_Estimates.R")            # 1. Overall survival curve
   source("CoxPH.R")                   # 2. Covariate effects on the hazard
   source("Logistic_regression.R")     # 3. Attrition classification
   source("Survival_Random_Forest.R")  # 4. Feature importance & prediction
   ```

   Or open a script in RStudio and run it line by line to inspect each model,
   plot, and summary interactively.

## Methodology

- **Kaplan-Meier estimates** — a non-parametric estimate of the probability that
  an employee remains beyond a given tenure, with a log-rank p-value.
- **Cox Proportional Hazards** — a semi-parametric model estimating the hazard
  ratio for each covariate; the proportional-hazards assumption is checked with
  `cox.zph` and Schoenfeld-residual plots.
- **Logistic regression** — a binary classifier with stepwise (both-direction)
  variable selection, evaluated via ROC/AUC, confusion matrices, and a
  Hosmer-Lemeshow goodness-of-fit test on a 70/30 train-test split.
- **Random Survival Forest** — an ensemble of survival trees for right-censored
  data; permutation VIMP and minimal-depth selection rank the most predictive
  features.

## Key Findings

- **Top drivers of attrition:** OverTime, JobSatisfaction, and
  YearsWithCurrManager are consistently among the strongest predictors.
- **Age effect:** attrition is highest in the **30–35** age group.
- **Model performance:** the logistic regression model achieves **~87.2%**
  classification accuracy.

## Recommendations

Focus retention efforts on **work-life balance** (managing overtime),
**competitive compensation**, and **supportive management** — the levers the
models flag as most influential on whether and when employees leave.

## Future Scope

Extend the modelling with additional ML techniques such as **SVM** and
**XGBoost** to improve predictive accuracy, and validate the approach on data
from other industries.

## License

Released under the [MIT License](LICENSE).
