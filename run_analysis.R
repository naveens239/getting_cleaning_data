library(plyr)

## read the train data
subject_train <- read.table("train/subject_train.txt")
x_train <- read.table("train/x_train.txt")
y_train <- read.table("train/y_train.txt")
## read the test data
subject_test <- read.table("test/subject_test.txt")
x_test <- read.table("test/x_test.txt")
y_test <- read.table("test/y_test.txt")
## merge the train and test data
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)
## read the features
features <- read.table("features.txt")
## filter req features mean and std from all features(here 2nd column has the feature names)
req_features <- grep("-(mean|std)\\(\\)",features[, 2])
## select those required features alone from x_data
x_data <- x_data[, req_features]
names(x_data) <- features[req_features, 2]

## read activity labels
activities <- read.table("activity_labels.txt")
## give the activity labels for y_data
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "activity"
## rename the subject data as well
names(subject_data) <- "subject"

## do column bind and merge the x_data, y_data and the subject_data
complete_data <- cbind(x_data, y_data, subject_data)

## rename all the data with appropriate names
names(complete_data) <- gsub("^t", "time", names(complete_data))
names(complete_data) <- gsub("Acc", "Accelerometer", names(complete_data))
names(complete_data) <- gsub("^f", "frequency", names(complete_data))
names(complete_data) <- gsub("Gyro", "Gyroscope", names(complete_data))
names(complete_data) <- gsub("BodyBody", "Body", names(complete_data))
names(complete_data) <- gsub("Mag", "Magnitude", names(complete_data))

## form the second group of data with mean of activity for every subject
tidy_data <- aggregate(. ~subject+activity, complete_data, mean)
tidy_data <- tidy_data[order(tidy_data$subject, tidy_data$activity),]
## write the data to a file
write.table(tidy_data, file = "tidy_data.txt", row.name = FALSE)


