################################################################################
#     CLEANING DATA - CLASS PROJECT
################################################################################
################################################################################

#download and unzipped data to working directory

library(data.table)
library(plyr)
library(dplyr)

#############################
# MERGE TRAINGING AND TEST SETS

# feature names
      feature.names <- read.table("./UCI HAR Dataset/features.txt")

# Test Data - Read and organize
      test.data <- read.table("./UCI HAR Dataset/test/X_test.txt")
      colnames(test.data) <-  t(feature.names[2])

      y.test <- read.table("./UCI HAR Dataset/test/y_test.txt")
      test.data$activity <- as.factor(y.test[,1])

      subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
      test.data$participants <- as.factor(subject.test[,1])

# Train Data - Read and organize
      train.data <- read.table("./UCI HAR Dataset/train/X_train.txt")
      colnames(train.data) <-  t(feature.names[2])

      y.train <- read.table("./UCI HAR Dataset/train/y_train.txt")
      train.data$activity <- as.factor(y.train[,1])

      subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
      train.data$participants <- as.factor(subject.train[,1])

# merge training and test data together & cleanup variables
samsung.data <- rbind(train.data, test.data)

# rm(y.test, subject.test, y.train, subject.train,
#    test.data, train.data, feature.names, wd)

###############################
# EXTRACT ONLY MEASUREMENTS ON THE MEAN AND STD DEV FOR EACH MEASUREMENT
mean.loc <- grep("mean()", colnames(samsung.data), value = FALSE, fixed = TRUE)
std.loc <- grep("std()", colnames(samsung.data), value = FALSE, fixed = TRUE)
locations <- c(mean.loc, std.loc)
my.data <- samsung.data[, locations]
my.data$participants <- samsung.data$participants
my.data$activity <- samsung.data$activity

#############################
# USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATASET
my.data$activity <- as.numeric(my.data$activity)
my.data$activity[my.data$activity == 1] <- "wallking"
my.data$activity[my.data$activity == 2] <- "walking_upstairs"
my.data$activity[my.data$activity == 3] <- "wallking_downstairs"
my.data$activity[my.data$activity == 4] <- "sitting"
my.data$activity[my.data$activity == 5] <- "standing"
my.data$activity[my.data$activity == 6] <- "laying"
my.data$activity <- as.factor(my.data$activity)

############################
# APPROPRIATELY LABEL THE DATASET WITH DESCRIPTIVE VARIABLE NAMES
colnames(my.data) <- tolower(colnames(my.data))
colnames(my.data) <- gsub("tbody", "time-body", colnames(my.data))
colnames(my.data) <- gsub("tgravity", "time-gravity", colnames(my.data))
colnames(my.data) <- gsub("fbody", "frequency-body", colnames(my.data))
colnames(my.data) <- gsub("fgravity", "frequency-gravity", colnames(my.data))
colnames(my.data) <- gsub("acc", "accelerometer", colnames(my.data))
colnames(my.data) <- gsub("gyro", "gyroscope", colnames(my.data))
colnames(my.data) <- gsub("mag", "magnitude", colnames(my.data))
colnames(my.data) <- gsub("bodybody", "body", colnames(my.data))

############################# 
# FROM DATA IN PRIOR STEP, CREATE SECOND TIDY
# DATASET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT

# add 'participant' to participants values and reclass as factor
my.data$participants <- as.numeric(my.data$participants)
my.data <- transform(my.data, participants = sprintf('participant %d', participants))
my.data$participants <- as.factor(my.data$participants)
my.data <- data.table(my.data)

tidy.my.data <- my.data[, lapply(.SD, mean), by = 'activity,participants']
write.table(tidy.my.data, file = "mytidydata.txt", row.name = FALSE)
