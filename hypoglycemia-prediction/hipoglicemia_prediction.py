# Importing libraries
import pandas as pd
from sklearn.metrics import classification_report, confusion_matrix, accuracy_score
from sklearn.neighbors import KNeighborsClassifier
from sklearn.ensemble import BaggingClassifier, AdaBoostClassifier
from sklearn.tree import DecisionTreeClassifier

# Read datasets
data = pd.read_csv("paciente_treino.csv", sep=';')
new = pd.read_csv("paciente_teste.csv", sep=';')

# Extract inputs and target
X = data.iloc[:, 0:12]  # Independent columns
y = data.iloc[:, -1]    # Target column
Xnew_p = new.iloc[:, 0:12]
ynew_p = new.iloc[:, -1]

# Choose and build the model according to the desired technique

# For Subspace KNN
def subspace_knn(X, y, Xnew_p, ynew_p, max_features):
    model = KNeighborsClassifier(n_neighbors=max_features)
    model = model.fit(X, y)
    prediction = model.predict(Xnew_p)
    return prediction

# For Bagged Tree
def bagged_tree(X, y, Xnew_p, ynew_p, n_trees, seed):
    model = BaggingClassifier(base_estimator=DecisionTreeClassifier(), n_estimators=n_trees, random_state=seed)
    model = model.fit(X, y)
    prediction = model.predict(Xnew_p)
    return prediction

# For Boosted Tree
def boosted_tree(X, y, Xnew_p, ynew_p, n_estimators, learning_rate):
    model = AdaBoostClassifier(n_estimators=n_estimators, learning_rate=learning_rate)
    model = model.fit(X, y)
    prediction = model.predict(Xnew_p)
    return prediction

# Define parameters for each classifier
# Example parameters for a specific model
max_features = 5
n_trees = 30
seed = 7
n_estimators = 100
learning_rate = 1.0

# Choose which classifier to use and calculate predictions
# Example use for Bagged Tree
prediction = bagged_tree(X, y, Xnew_p, ynew_p, n_trees, seed)

# Model evaluation
confusion = confusion_matrix(ynew_p, prediction)
print('Confusion Matrix\n')
print(confusion)
print('\nAccuracy: {:.2f}\n'.format(accuracy_score(ynew_p, prediction)))
print(classification_report(ynew_p, prediction))