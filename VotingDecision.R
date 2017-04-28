# Clearing all the variables in the workspace
rm(list = ls(all = TRUE))

# Loading the file into R
gerber <- read.csv("gerber.csv")

# Exploring the structure of the dataframe
str(gerber)

# Exploring the summary statistics of the dataframe
summary(gerber)

# Proportion of the people who actually voted in the election
table(gerber$voting)
108696/(235388 + 108696)

# Which of the four "treatment groups" had the largest percentage of people who actually voted (voting = 1)?
tapply(gerber$voting, gerber$civicduty, mean)
tapply(gerber$voting, gerber$hawthorne, mean)
tapply(gerber$voting, gerber$self, mean)
tapply(gerber$voting, gerber$neighbors, mean)


# Logistic regression model for voting using the four treatment group variables
VotingModel1 <- glm(voting ~ civicduty + hawthorne + self + neighbors, data = gerber, family = "binomial")

# Summary of the model to check which of the independent variables are significant
summary(VotingModel1)

# Computing predictions for the data using VotingModel1
predictProb <- predict(VotingModel1, type = "response")

# Baseline accuracy - going with the most common outcome, which in our case is 0
table(gerber$voting)
accuracy <- 235388/(235388 + 108696)
accuracy

# Checking for the accuracy with a threshold of 0.3
table(gerber$voting, predictProb > 0.3)
accuracy <- (134513 + 51966)/(134513 + 100875 + 56730 + 51966)
accuracy

# Checking for the accuracy with a threshold of 0.5
table(gerber$voting, predictProb > 0.5)
accuracy <- (235388 + 0)/(235388 + 0 + 108696 + 0)
accuracy

# Computing AUC of the model
library(ROCR)
ROCRpred <- prediction(predictProb, gerber$voting)
auc <- as.numeric(performance(ROCRpred, "auc")@y.values)
auc

# Even though all the variables are significant, the logistic model does not significantly improve over the baseline model
# Exploring if the decision trees make for a better model

library(rpart)
library(rpart.plot)
CARTModel1 <- rpart(voting ~ civicduty + hawthorne + self + neighbors, data = gerber)

# Visualizing to see the decision tree
prp(CARTModel1)

# The decision tree indicates that none of the variables have a big enough impact to split
# Training a new decision tree with the complexity parameter set to 0.0
CARTModel2 <- rpart(voting ~ civicduty + hawthorne + self + neighbors, data = gerber, cp = 0.0)

# Visualizing to see the decision tree
prp(CARTModel2)

# This time the first split occured on neighbors variable followed by self variable
# This validates the trend observed above among highest voting percentage in different groups

# Training a new decision tree this time including the Sex variable
CARTModel3 <- rpart(voting ~ civicduty + hawthorne + self + neighbors + sex, data = gerber, cp = 0.0)

# Visualizing to see the decision tree
prp(CARTModel3)

# The tree indicates that males correspond to a higher voting percentage in all of the treatments groups

# To understand whether not being in the control group affects each gender differently
# Training a new decision tree this time only including the variables control and sex
CARTModel4 <- rpart(voting ~ control + sex, data = gerber, cp = 0.0)

# Visualizing to see the decision tree
prp(CARTModel4)
prp(CARTModel4, digits = 6)

# For both the genders, the probability of voting increases by approximately 0.043.
# This indicates that both the genders are equally affected by not being in a control group.