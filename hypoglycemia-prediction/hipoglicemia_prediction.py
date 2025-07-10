# Import libraries
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from sklearn.metrics import classification_report, confusion_matrix, accuracy_score
from sklearn.ensemble import AdaBoostClassifier, BaggingClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.tree import DecisionTreeClassifier

# -------------------------------
# Parameters per classifier/patient
# -------------------------------
params = {
    'P55': {
        'AdaBoost': {'n_estimators': 20},
        'BaggedTree': {'n_estimators': 90, 'seed': 8},
        'SubspaceKNN': {'max_features': 12, 'n_neighbors': 2}
    },
    'P56': {
        'AdaBoost': {'n_estimators': 630},
        'BaggedTree': {'n_estimators': 30, 'seed': 7},
        'SubspaceKNN': {'max_features': 5, 'n_neighbors': 2}
    },
    'P65': {
        'AdaBoost': {'n_estimators': 105},
        'BaggedTree': {'n_estimators': 20, 'seed': 7},
        'SubspaceKNN': {'max_features': 7, 'n_neighbors': 2}
    },
    'P67': {
        'AdaBoost': {'n_estimators': 1750},
        'BaggedTree': {'n_estimators': 100, 'seed': 7},
        'SubspaceKNN': {'max_features': 4, 'n_neighbors': 2}
    },
    'P68': {
        'AdaBoost': {'n_estimators': 80},
        'BaggedTree': {'n_estimators': 50, 'seed': 20},
        'SubspaceKNN': {'max_features': 3, 'n_neighbors': 2}
    }
}

# -------------------------------
# Classifier Functions
# -------------------------------
def run_adaboost(X_train, y_train, X_test, n_estimators):
    model = AdaBoostClassifier(n_estimators=n_estimators, learning_rate=1.0, algorithm='SAMME', random_state=42)
    model.fit(X_train, y_train)
    return model.predict(X_test)

def run_bagged_tree(X_train, y_train, X_test, n_estimators, seed):
    model = BaggingClassifier(
        base_estimator=DecisionTreeClassifier(),
        n_estimators=n_estimators,
        random_state=seed
    )
    model.fit(X_train, y_train)
    return model.predict(X_test)

def run_subspace_knn(X_train, y_train, X_test, max_features, n_neighbors):
    model = BaggingClassifier(
        base_estimator=KNeighborsClassifier(n_neighbors=n_neighbors),
        max_features=max_features,
        n_estimators=50,
        bootstrap=False,
        random_state=42
    )
    model.fit(X_train, y_train)
    return model.predict(X_test)

# -------------------------------
# Evaluation Function
# -------------------------------
def evaluate_model(y_true, y_pred, patient, clf_name):
    cm = confusion_matrix(y_true, y_pred)
    acc = accuracy_score(y_true, y_pred)

    print(f"\n--- {clf_name} - {patient} ---")
    print("Confusion Matrix:\n", cm)
    print(f"\nAccuracy: {acc:.2f}")
    print(classification_report(y_true, y_pred))

    # Plot
    plt.figure(figsize=(5, 4))
    sns.heatmap(cm, annot=True, fmt='d', cmap='Blues')
    plt.title(f'Confusion Matrix - {clf_name} ({patient})')
    plt.xlabel('Predicted')
    plt.ylabel('Actual')
    plt.tight_layout()
    plt.show()

# -------------------------------
# Load and run for a given patient
# -------------------------------
def run_model_for_patient(patient_id, classifier):
    # Load datasets
    train_file = f"paciente_{patient_id}_treino.csv"
    test_file = f"paciente_{patient_id}_teste.csv"

    df_train = pd.read_csv(train_file, sep=';')
    df_test = pd.read_csv(test_file, sep=';')

    X_train = df_train.iloc[:, :-1]
    y_train = df_train.iloc[:, -1]
    X_test = df_test.iloc[:, :-1]
    y_test = df_test.iloc[:, -1]

    p = params[patient_id][classifier]

    if classifier == 'AdaBoost':
        y_pred = run_adaboost(X_train, y_train, X_test, p['n_estimators'])
    elif classifier == 'BaggedTree':
        y_pred = run_bagged_tree(X_train, y_train, X_test, p['n_estimators'], p['seed'])
    elif classifier == 'SubspaceKNN':
        y_pred = run_subspace_knn(X_train, y_train, X_test, p['max_features'], p['n_neighbors'])
    else:
        raise ValueError("Unsupported classifier")

    evaluate_model(y_test, y_pred, patient_id, classifier)

# -------------------------------
# Run Example
# -------------------------------
if __name__ == "__main__":
    # Choose patient and classifier: "AdaBoost", "BaggedTree", "SubspaceKNN"
    run_model_for_patient('P55', 'AdaBoost')
