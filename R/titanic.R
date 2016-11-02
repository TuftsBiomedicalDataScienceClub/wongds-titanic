# titanic.R
# Daniel Wong
# 1 Nov 2016
#
# R script for Kaggle Titanic Competition - Machine Learning

# Set the working directory
windows_wd <- 'C:/Users/Daniel Wong/Documents/Kaggle/Titanic'
setwd(windows_wd)

# Download and install libraries
r_repos <- 'https://cloud.r-project.org'
r_packages <- c('rpart','rattle', 'rpart.plot', 'RColorBrewer')
install.packages(r_packages, repos=r_repos)

library(rpart)
library(rpart.plot)
library(rattle)
library(RColorBrewer)

# Load data
train <- read.csv('train.csv')
test <- read.csv('test.csv')

# Create decision tree
my_tree_two <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = 'class')

# Plot decision tree
plot(my_tree_two)
text(my_tree_two)
fancyRpartPlot(my_tree_two)

# Prediction
my_prediction <- predict(my_tree_two, newdata = test, type='class')
my_solution <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)
nrow(my_solution)
write.csv(my_solution, file='my_solution.csv', row.names=FALSE)

# Alter the model to change the minimum number of obs in a leaf of tree
my_tree_three <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, 
                  data = train, method = "class", control = rpart.control(minsplit = 50, cp = 0))

# Visualize my_tree_three
fancyRpartPlot(my_tree_three)