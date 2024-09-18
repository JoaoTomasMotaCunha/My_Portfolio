## Import required libraries
library(ggplot2)       # For plotting graphs
library(kernlab)       # Kernel-based machine learning algorithms
library(arules)        # Association rule learning
library(InformationValue) # Calculate Information Value for feature selection
library(readxl)        # Read Excel files
library(readr)         # Read and write CSV files

# Additional libraries for data manipulation and visualization
library(tidyverse)     
library(ggcorrplot)    # Plot correlation matrix
library(corrplot)      # Another package to visualize correlation
library(dplyr)         # Data manipulation

# Load dataset
data <- read.csv("StudentsPerformance.csv", header = TRUE, sep = ",")

# Display the shape of the dataset (1000 rows, 8 columns)
cat('dataset shape:', dim(data)) 

# Display column names
colnames(data)

# Summary of the data (numerical summary statistics)
summary(data) 

# Check for missing values (none found)
table(is.na(data))

## Rename columns for better readability
namesOfColumns <- c("Gender","Race","Parent_Education","Lunch","Test_Prep","Math_Score","Reading_Score","Writing_Score")
colnames(data) <- namesOfColumns

# Attach the data for easy access to variables
attach(data)

# ---------------------------------------------------------
# Descriptive analysis of categorical variables

# Gender: Count and proportions, followed by a bar plot
table(Gender)
prop.table(table(Gender))
barplot(table(Gender), main = "Barplot: Gender")

# Race: Count, proportions, and bar plot
table(Race)
prop.table(table(Race))
barplot(table(Race), main = "Barplot: Race")

# Parent Education: Count, proportions, and bar plot (text size adjusted)
table(Parent_Education)
prop.table(table(Parent_Education))
barplot(table(Parent_Education), main = "Barplot: Parental Education", cex.names = 0.5)

# Lunch: Count, proportions, and bar plot
table(Lunch)
prop.table(table(Lunch))
barplot(table(Lunch), main = "Barplot: Lunch")

# Test Preparation: Count, proportions, and bar plot
table(Test_Prep)
prop.table(table(Test_Prep))
barplot(table(Test_Prep), main = "Barplot: Test Preparation")

# ---------------------------------------------------------
# Descriptive analysis of numerical variables

# Math Score: Histogram, boxplot, mean, and standard deviation
hist(Math_Score, main ="Histogram: Math Scores", xlab = "Scores")
boxplot(Math_Score, main ="Boxplot: Math Scores", ylab="Scores")
mean(Math_Score)  # Calculate mean
sd(Math_Score)    # Calculate standard deviation

# Similar analysis for Reading and Writing Scores
hist(Reading_Score, main ="Histogram: Reading Scores", xlab = "Scores")
boxplot(Reading_Score, main ="Boxplot: Reading Scores", ylab="Scores")
mean(Reading_Score)
sd(Reading_Score)

hist(Writing_Score, main ="Histogram: Writing Scores", xlab = "Scores")
boxplot(Writing_Score, main ="Boxplot: Writing Scores", ylab="Scores")
mean(Writing_Score)
sd(Writing_Score)

# Observation: There are some outliers, but they are not extreme, just lower scores than usual.

# ---------------------------------------------------------
# Convert categorical variables to numerical format for analysis
data$gender1 <- as.numeric(factor(data$Gender))  # 1: Female, 2: Male
data$Race1 <- as.numeric(factor(data$Race))      # Convert Race groups to numerical values
data$Parent_Education1 <- as.numeric(factor(data$Parent_Education, levels = c('some high school','high school',"associate's degree",'some college',"bachelor's degree", "master's degree")))
data$Lunch1 <- as.numeric(factor(data$Lunch, levels = c("standard",'free/reduced')))
data$Test_Prep1 <- as.numeric(factor(data$Test_Prep, levels = c('none','completed')))

# Subset the data for correlation analysis
data1 <- data[,6:13]

# Plot correlation matrix with color gradient
cor(data1)
corrplot(cor(data1), method = "color", addCoef.col = "grey", type = "upper", diag = FALSE, tl.col = "black")

# Correlation matrix for only the numerical variables (scores)
data2 <- data[,6:8]
cor(data2)
corrplot(cor(data2), method = "color", addCoef.col = "white", type = "upper", diag = FALSE, tl.col = "black")

# Reset to original dataset
data0 <- data 
data <- data0[,0:8]

# ---------------------------------------------------------
# Scatter plots to visualize relationships between Math and other scores
scatter.smooth(x = data$Math_Score, y = data$Reading_Score, main = "Math vs Reading")
scatter.smooth(x = data$Math_Score, y = data$Writing_Score, main = "Math vs Writing")

# Density plots for scores
par(mfrow = c(1, 3))  # Multiple plots in a single window
dens <- density(data$Math_Score)
plot(dens, xlab = "Math Scores", main = "")
dens <- density(data$Reading_Score)
plot(dens, xlab = "Reading Scores", main = "")
dens <- density(data$Writing_Score)
plot(dens, xlab = "Writing Scores", main = "")

# ---------------------------------------------------------
# Linear Regression Analysis

# Full model: Math_Score predicted by multiple variables
model_a <- lm(Math_Score ~ Reading_Score + Writing_Score + as.factor(Gender) + as.factor(Race) + as.factor(Lunch) + as.factor(Test_Prep) + as.factor(Parent_Education), data = data)
summary(model_a)

# Since Parent Education is not significant (p-value > 0.05), create a new model without it
model_b <- lm(Math_Score ~ Writing_Score + Reading_Score + as.factor(Gender) + as.factor(Race) + as.factor(Lunch) + as.factor(Test_Prep), data = data)
summary(model_b)

# ANOVA and diagnostic plots for model_b
anova(model_b)
plot(model_b)

# ---------------------------------------------------------
# Evaluate different models

# Model 1: Predict Math Score using Writing Score only
model1 <- lm(Math_Score ~ Writing_Score, data = data)
summary(model1)

# Model 2: Predict Math Score using Race
model2 <- lm(Math_Score ~ as.factor(Race), data = data)
summary(model2)

# ---------------------------------------------------------
# Make predictions using model_b

# Create new dataset for prediction
data3 <- data.frame(Writing_Score = c(69), Reading_Score = c(70), Gender = c('female'), Race = c('group C'), Lunch = c('standard'), Test_Prep = c('none'))

# Predict Math Score with confidence and prediction intervals
predict(model_b2, data3, interval = 'prediction', level = 0.95)
predict(model_b2, data3, interval = 'confidence', level = 0.95)

# Visualize predictions
pred <- predict(model_b2, data = data3, interval = 'prediction', level = 0.95)
data4 <- cbind(data3, pred)
ggplot(data4, aes(Writing_Score, Math_Score)) + geom_point() + stat_smooth(method = lm) + 
  geom_line(aes(y = lwr), color = "red", linetype = "dashed") + 
  geom_line(aes(y = upr), color = "red", linetype = "dashed")

# ---------------------------------------------------------
# t-test to compare Math Scores between different Race groups
t.test(Math_Score[Race == 'group B'], Math_Score[Race == 'group C'], mu = 0, conf.level = 0.95)

# ---------------------------------------------------------
# Linear regression with interaction term for Race and Writing Score
model3 <- lm(Math_Score ~ Writing_Score + Reading_Score + as.factor(Gender) + as.factor(Race) + as.factor(Lunch) + as.factor(Test_Prep) + Writing_Score:as.factor(Race), data = data)
summary(model3)

# Plot Writing Score vs Math Score by Race group
plot(Writing_Score[Race == 'group A'], Math_Score[Race == 'group A'], col = 'red', xlab = 'Writing Score', ylab = 'Math Score')
points(Writing_Score[Race == 'group B'], Math_Score[Race == 'group B'], col = 'black')
points(Writing_Score[Race == 'group C'], Math_Score[Race == 'group C'], col = 'blue')
points(Writing_Score[Race == 'group D'], Math_Score[Race == 'group D'], col = 'green')
points(Writing_Score[Race == 'group E'], Math_Score[Race == 'group E'], col = 'orange')

# Fit linear models for each Race group
lm(Math_Score[Race == 'group A'] ~ Writing_Score[Race == 'group A'])
lm(Math_Score[Race == 'group B'] ~ Writing_Score[Race == 'group B'])
lm(Math_Score[Race == 'group C'] ~ Writing_Score[Race == 'group C'])
lm(Math_Score[Race == 'group D'] ~ Writing_Score[Race == 'group D'])
lm(Math_Score[Race == 'group E'] ~ Writing_Score
