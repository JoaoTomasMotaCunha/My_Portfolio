# Student Performance Analysis

This project analyzes a dataset of student performance in various subjects (Math, Reading, and Writing). The goal is to explore the relationships between students' scores and various demographic factors such as gender, race, parental education level, lunch type, and test preparation. The analysis includes descriptive statistics, visualizations, and multiple linear regression models to predict Math scores based on other variables.


## Dataset

The dataset used in this project is `StudentsPerformance.csv`, which contains 1000 rows and 8 columns. The columns represent:

- `Gender`: The gender of the student.
- `Race`: The student's race/ethnicity group.
- `Parent_Education`: The level of education of the student's parents.
- `Lunch`: Type of lunch received by the student (standard or free/reduced).
- `Test_Prep`: Whether the student completed a test preparation course.
- `Math_Score`: The student's math score.
- `Reading_Score`: The student's reading score.
- `Writing_Score`: The student's writing score.

## Requirements

To run this project, the following R libraries are required:

- `ggplot2`: For plotting graphs.
- `kernlab`: For kernel-based machine learning algorithms.
- `arules`: For association rule mining.
- `InformationValue`: For calculating the Information Value of variables.
- `readxl` and `readr`: For reading CSV and Excel files.
- `tidyverse`: A collection of R packages for data manipulation.
- `ggcorrplot`, `corrplot`: For correlation matrix plotting.
- `dplyr`: For data manipulation and cleaning.
