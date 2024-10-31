# Employee Attrition Prediction Using ML & Survival Analysis

This project uses advanced statistical and machine learning techniques to predict employee turnover, along with Survival Analysis, focusing on attrition factors within an organization. Utilizing the IBM HR Analytics Employee Attrition & Performance dataset, the study offers insights into key reasons for attrition and recommends strategies for retention.

## Project Overview

Employee attrition can be a significant challenge for organizations, leading to operational disruption and increased costs. This project employs Kaplan-Meier Estimates, Cox Proportional Hazards (Cox-PH) model, and Logistic Regression, as well as Random Survival Forest for high-dimensional data analysis, achieving 87.2% predictive accuracy. It offers practical insights to reduce employee turnover by identifying and addressing core attrition factors.

## Data Description

The dataset includes 1,470 records across 35 attributes, covering:

__Demographics__: Age, gender, marital status, and more.

__Job Information__: Department, job role, monthly income, and overtime status.

__Work Experience__: Years at the company, years in the current role, and prior employment history.

__Educational Background__: Education level and field of study.

Data preprocessing steps involve feature selection, label encoding, and scaling for consistent analysis.

## Methodology:

__Kaplan-Meier Estimates__: This non-parametric method estimates survival probability over time, showing the fraction of employees expected to remain with the organization.

__Cox Proportional Hazards Model__: The Cox-PH model estimates the impact of various covariates on attrition, identifying factors like overtime and job involvement that influence turnover rates.

__Logistic Regression__: Logistic regression identifies key attrition predictors, achieving 87.2% accuracy by using significant variables, including job satisfaction and relationship with the manager.

__Random Survival Forest__: The Random Survival Forest method, specialized for right-censored data, identifies important features and predicts the survival probability, aiding in high-dimensional data analysis where interactions between variables are crucial.


## Key Findings:
__Significant Factors__: Key predictors include overtime, job satisfaction, and years with the current manager.

__Attrition by Age Group__: Highest attrition rates occur in the 30-35 age group.

__Retention Recommendations__: Emphasize work-life balance, competitive wages, and supportive management to improve employee retention.

## Usage:

Included in this repository:

__Data__: Attrition_Data.csv

__Scripts__:

CoxPH.R: Fits the Cox-PH model.

Logistic_regression.R: Implements logistic regression.

KM Estimates.R: Calculates Kaplan-Meier survival estimates.

Random_Survival_Forest.R: Implements Random Survival Forest for feature importance and survival probability prediction.

Run the scripts in sequence to reproduce results or adapt the analysis to new datasets.

## Conclusion and Recommendations:

This analysis helps organizations identify and manage attrition risks, recommending HR strategies that focus on improving work-life balance, fair compensation, and employee satisfaction.

## Future Scope:

Further analysis may include advanced ML techniques, such as support vector machines (SVM) and XGBoost, to enhance predictive accuracy and broaden industry applicability.

