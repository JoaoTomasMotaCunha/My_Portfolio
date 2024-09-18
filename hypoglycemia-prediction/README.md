# Hypoglycemia Prediction

## Overview

This project aims to predict hypoglycemia (low blood sugar levels) using various machine learning techniques. The dataset includes patient data, and different classifiers are applied to predict the likelihood of hypoglycemia based on this information.

## Datasets

- **Training Data**: `paciente_treino.csv`
- **Test Data**: `paciente_teste.csv`

Both datasets are in CSV format, separated by semicolons (`;`). They contain several features and a target column indicating the presence or absence of hypoglycemia.

### Dataset Preprocessing

The datasets have already undergone extensive preprocessing, including:

- **Data Manipulation**: Adjustments to make the data suitable for machine learning.
- **Variable Extraction**: Identification and isolation of relevant features.
- **Blood Glucose Imputation**: Imputation of missing blood glucose values when absent data is detected.
- **Resampling**: Applied to create a balanced dataset, ensuring that hypoglycemia cases and non-hypoglycemia cases are represented equally.

The dataset can be accessed here:
- **UCI Machine Learning Repository**, “Diabetes Data Set.” Available online at: [UCI Repository Diabetes Dataset](https://archive.ics.uci.edu/ml/datasets/diabetes). Accessed: 20-Jul-2005.

### Additional Information

The diabetes patient records are sourced from two methods:

1. **Automatic Electronic Recording Device**: This device records events with accurate timestamps due to its internal clock.
2. **Paper Records**: Provides "logical time" slots (breakfast, lunch, dinner, bedtime) with fixed times assigned:
   - **Breakfast**: 08:00
   - **Lunch**: 12:00
   - **Dinner**: 18:00
   - **Bedtime**: 22:00
   Paper records have fictitious uniform recording times, whereas electronic records have more precise timestamps.

#### File Format and Structure

Each diabetes record consists of four fields, separated by tabs, with each record separated by a newline. The fields are:

1. **Date**: Format is MM-DD-YYYY.
2. **Time**: Format is XX:YY.
3. **Code**: Indicates the type of measurement or event.
4. **Value**: The recorded value associated with the code.

**Code Field Description**:

- **33**: Regular insulin dose
- **34**: NPH insulin dose
- **35**: UltraLente insulin dose
- **48**: Unspecified blood glucose measurement
- **57**: Unspecified blood glucose measurement
- **58**: Pre-breakfast blood glucose measurement
- **59**: Post-breakfast blood glucose measurement
- **60**: Pre-lunch blood glucose measurement
- **61**: Post-lunch blood glucose measurement
- **62**: Pre-supper blood glucose measurement
- **63**: Post-supper blood glucose measurement
- **64**: Pre-snack blood glucose measurement
- **65**: Hypoglycemic symptoms
- **66**: Typical meal ingestion
- **67**: More-than-usual meal ingestion
- **68**: Less-than-usual meal ingestion
- **69**: Typical exercise activity
- **70**: More-than-usual exercise activity
- **71**: Less-than-usual exercise activity
- **72**: Unspecified special event

**Missing Values**: No

## File Structure

- `hipoglicemia_prediction.py`: The main Python script for training and evaluating the models.
- `paciente_treino.csv`: Training dataset.
- `paciente_teste.csv`: Test dataset.

## Python Libraries

This project requires the following Python libraries:
- `pandas`: For data manipulation and analysis.
- `scikit-learn`: For machine learning algorithms and metrics.

## Code Explanation

1. **Import Libraries**: 
   - Import `pandas` for data handling.
   - Import machine learning models and metrics from `scikit-learn`.

2. **Read Datasets**:
   - Load the training and test datasets into DataFrames.

3. **Extract Inputs and Target**:
   - Separate features and target columns from the datasets.

4. **Build Model**:
   - **Subspace KNN**: Uses `KNeighborsClassifier`.
   - **Bagged Tree**: Uses `BaggingClassifier` with a `DecisionTreeClassifier` as the base estimator.
   - **Boosted Tree**: Uses `AdaBoostClassifier`.

5. **Evaluate Model**:
   - Assess model performance using confusion matrix, accuracy score, and classification report.

## Usage

1. **Install Required Libraries**:
   Make sure you have `pandas` and `scikit-learn` installed in your Python environment. You can install these libraries using pip:
   
   ```python
   pip install pandas scikit-learn
