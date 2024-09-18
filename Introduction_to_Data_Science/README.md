# Customer Behavior Prediction

## Overview

This project focuses on predicting customer behavior on a company's website using various machine learning models. The goal is to identify patterns in customer interactions that can help predict whether a user will make a purchase.

## Data

The dataset used for this analysis includes user sessions with various features. Three main versions of the dataset were used:

1. **Balanced Dataset**: Includes balanced classes to address class imbalance issues.
2. **Full Dataset**: Includes all records, including those with zero session duration.
3. **Full Dataset Without Duration Zeros**: Includes the full dataset but excludes sessions with zero duration.

## Models

The following models were evaluated:

1. **Support Vector Machines (SVC)**
2. **Neural Network Classifier (MLP)**
3. **Tree Ensembles**
4. **Nearest Neighbor**
5. **Decision Tree**
6. **Bayesian Classifier**

### Model Parameters and Training

- **Support Vector Machines (SVC)**:
  - Parameters: `C=10`, `gamma="auto"`, `kernel="rbf"`
  - `Random State: 42`
  - Train Accuracy: 94.97%
  - Test Accuracy: 92.02%

- **Neural Network Classifier (MLP)**:
  - Parameters: `activation="tanh"`, `alpha=0.0001`, `learning_rate="constant"`, `solver="adam"`, `hidden_layer_sizes=(100,50,30)`
  - `Random State: 42`
  - Train Accuracy: 95.75%
  - Test Accuracy: 92.88%

- **Tree Ensembles**: Various configurations tested.

### Evaluation Metrics

Models were evaluated using the following metrics:

- **Accuracy**
- **Precision**
- **Recall**
- **F1-Score**

### Results

#### Accuracy

| DataSet                    | Nearest Neighbor | Decision Tree | Bayesian Classifier | Support Vector Machines | Neural Network Classifier | Tree Ensembles |
|----------------------------|------------------|---------------|----------------------|--------------------------|---------------------------|----------------|
| Balanced                   | 90.08%           | 91.01%        | 83.17%               | 92.02%                   | 92.88%                    | 93.04%         |
| Full                       | 95.16%           | 95.15%        | 89.94%               | 95.59%                   | 95.71%                    | 95.81%         |
| Full Without Duration Zeros| 91.02%           | 91.72%        | 85.68%               | 92.39%                   | 92.82%                    | 92.35%         |

#### Precision

| DataSet                    | Nearest Neighbor | Decision Tree | Bayesian Classifier | Support Vector Machines | Neural Network Classifier | Tree Ensembles |
|----------------------------|------------------|---------------|----------------------|--------------------------|---------------------------|----------------|
| Balanced                   | 88.74%           | 89.64%        | 88.20%               | 90.76%                   | 91.46%                    | 91.18%         |
| Full                       | 73.10%           | 71.56%        | 43.66%               | 77.95%                   | 77.14%                    | 77.34%         |
| Full Without Duration Zeros| 71.75%           | 72.71%        | 52.11%               | 78.12%                   | 74.94%                    | 75.10%         |

#### Recall

| DataSet                    | Nearest Neighbor | Decision Tree | Bayesian Classifier | Support Vector Machines | Neural Network Classifier | Tree Ensembles |
|----------------------------|------------------|---------------|----------------------|--------------------------|---------------------------|----------------|
| Balanced                   | 91.84%           | 92.76%        | 76.65%               | 93.60%                   | 94.62%                    | 95.32%         |
| Full                       | 67.04%           | 70.09%        | 68.23%               | 66.25%                   | 69.55%                    | 70.83%         |
| Full Without Duration Zeros| 65.84%           | 71.46%        | 51.84%               | 68.20%                   | 78.09%                    | 73.08%         |

#### F1-Score

| DataSet                    | Nearest Neighbor | Decision Tree | Bayesian Classifier | Support Vector Machines | Neural Network Classifier | Tree Ensembles |
|----------------------------|------------------|---------------|----------------------|--------------------------|---------------------------|----------------|
| Balanced                   | 90.26%           | 91.18%        | 82.02%               | 92.16%                   | 93.01%                    | 93.20%         |
| Full                       | 69.94%           | 70.82%        | 53.24%               | 71.63%                   | 73.15%                    | 73.94%         |
| Full Without Duration Zeros| 68.67%           | 72.08%        | 51.98%               | 72.82%                   | 76.48%                    | 74.07%         |

### Graphical Visualization

The following plots were generated for model evaluation:
- **ROC Curves**
- **Precision-Recall Curves**
- **DET Curves**

### Conclusions

- **Best Dataset**: Balanced Dataset
- **Best Model**: Neural Network Classifier

The Neural Network Classifier provided the best overall performance in terms of accuracy, precision, recall, and F1-score. It is recommended for predicting customer behavior, as it effectively handles complex relationships in the data.

### Business Impact

By utilizing the Neural Network Classifier on the balanced dataset, the company can gain valuable insights into customer behavior, allowing for better-targeted marketing strategies and improved sales performance. Understanding customer behavior more deeply will help in designing strategies to increase conversion rates and optimize user engagement.

### Bonus

AdaBoost was tested but did not improve the results compared to other models.

