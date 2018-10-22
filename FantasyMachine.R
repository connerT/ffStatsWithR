# Set the working directory
setwd("C:/Data Science/FF_R")

# Load libraries needed
library('ggplot2') # visualization
library('ggthemes') # visualization
library('scales') # visualization
library('dplyr') # data manipulation
library('mice') # imputation
library('randomForest') # classification algorithm
library('rpart')
library(tidyr)

# Read the csv file
full2017 <- read.csv("Data_Files/fantData2017.csv", stringsAsFactors = F)
full2016 <- read.csv("Data_Files/fantData2016.csv", stringsAsFactors = F)
full2015 <- read.csv("Data_Files/fantData2015.csv", stringsAsFactors = F)
full2014 <- read.csv("Data_Files/fantData2014.csv", stringsAsFactors = F)
full2013 <- read.csv("Data_Files/fantData2013.csv", stringsAsFactors = F)

# Combine all the data frames into one data frame
full <- Reduce(rbind, list(full2014, full2015, full2016, full2017, full2013))

# Rename columns to more readable names
full <- rename(full, Name = X, Team = Tm, Position = FantPos, Num = Rk, Games_Played = G, Games_Started = GS, Completed_Passing = Cmp, Attempts_Passing = Att, Yards_Passing = Yds, TD_Passing = TD, Ints_Passing = Int, Attempts_Rushing = Att.1, Yards_Rushing = Yds.1, Yards_Attempt_Rushing = Y.A, TD_Rushing = TD.1, Tgt_Rec = Tgt, Receptions = Rec, Yards_Rec = Yds.2, Yards_Per_Rec = Y.R, TD_Rec = TD.2, X2P_Made = X2PM, X2P_Passes = X2PP, Draft_Kings = DKPt, Fan_Duel = FDPt)

# Take a look at the column names
names(full)

# Remove the nickname from the end of the Name column after the "\\"
full$Name <- gsub("\\\\.*", "", full$Name)
full$Name <- gsub("\\*.*", "", full$Name)

# Print a summary
str(full)

# Build a data frame with only the columns we need
full <- select(full, Name, TD_Rec, Tgt_Rec)

# Get rid of NA values
full <- na.omit(full)

model <- lm(TD_Rec ~ Tgt_Rec, data = full)

plot(TD_Rec ~ Tgt_Rec, data = full)
abline(model)

# fit <- rpart(TD_Rec ~ Tgt_Rec, data = full)
# plot(fit, uniform = TRUE)
# # Add text labels and make them 60% as big as they are by default
# text(fit, cex = .6)

# Train a decision tree based on our dataset
fit <- randomForest(TD_Rec ~ Tgt_Rec, data = full)

print("Making predictions for the following 5 players:")
print(head(full))

print("The predictions are")
print(predict(fit, head(full)))

print("Actual TD Receptions")
print(head(full$TD_Rec))

# Get the mean absolute error for our model
mae(model = fit, data = full)

# # Split our data so that 30% is in the text set and 70% is in the training set
# splitData <- resample_partition(full, c(test = 0.3, train = 0.7))

set.seed(42)

# Randomly sample 100 of 150 row indexes
indexes <- sample(1:nrow(full), size = 0.2*nrow(full))

# Inspect the random indexes
print(indexes)

# Create a training set from indexes
test <- full[indexes, ]
dim(train)

# Create a test set from remaining indexes
train <- full[-indexes, ]
dim(test)

# # How many cases are in the test and training set?
# lapply(splitData, dim)

# Fit a random forest model to our training set
fitRandomForest <- randomForest(TD_Rec ~ Tgt_Rec, data = train)

# Get the mae for our new model based on the training data
mae(model = fitRandomForest, data = train)

# Get the mae for our new model based on the test data
mae(model = fitRandomForest, data = test)

print("Making predictions for the following 5 players:")
tail(test)

print("The predictions are")
print(predict(fit, tail(test)))

print("Actual TD Receptions")
print(tail(test$TD_Rec))