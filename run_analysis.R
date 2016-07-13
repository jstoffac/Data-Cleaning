library(downloader)
library(plyr)

#Download zipped data folder and unzip if they do not already exist.
if(!file.exists("Dataset.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "Dataset.zip")
}

if(!file.exists("UCI HAR Dataset")) {
  unzip("Dataset.zip", list = FALSE)
}

filedir <- "UCI HAR Dataset"

#read in features.txt, which lists the column names for X_train.txt and X_test.text
features <- read.table(paste(filedir, "features.txt", sep = "/"), stringsAsFactors = FALSE, sep = "")

#read in X_train.txt, y_train.txt, and subject_train.txt with appropriate column names
x_train <- read.table(paste(filedir, "train", "X_train.txt", sep = "/"), sep = "", col.names = features$V2)
y_train <- read.table(paste(filedir, "train", "y_train.txt", sep = "/"), sep = "", col.names = "Activity")
subject_train <- read.table(paste(filedir, "train", "subject_train.txt", sep = "/"), sep = "", col.names = "Subject")
train <- cbind(subject_train, y_train, x_train)

#read in X_test.txt, y_test.txt, and subject_test.txt with appropriate column names
x_test <- read.table(paste(filedir, "test", "X_test.txt", sep = "/"), sep = "", col.names = features$V2)
y_test <- read.table(paste(filedir, "test", "y_test.txt", sep = "/"), sep = "", col.names = "Activity")
subject_test <- read.table(paste(filedir, "test", "subject_test.txt", sep = "/"), sep = "", col.names = "Subject")
test <- cbind(subject_test, y_test, x_test)

#1.  Merges the training and the test sets to create one data set.
data <- rbind(train, test)
data <- arrange(data, Subject) #reorder dataframe in descending order by Subject

#2.  Extracts only the measurements on the mean and standard deviation for each measurement.
data_mean_std <- data[,grep(".mean|std.",names(data))]

#3. Use descritptive names to name the activities in the dataset
activity_labels <- read.table(paste(filedir, "activity_labels.txt", sep = "/"), sep = "")
data$'Activity Name'<- factor(data$Activity, levels = activity_labels$V1, labels = activity_labels$V2) 

#4. Appropriately labels the data set with descriptive variable names
##replace "t" with "Time, "f" with "Frequency" more explicit names
##     ref: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
names(data_mean_std) <- gsub("^t", "Time", names(data_mean_std))
names(data_mean_std) <- gsub("^f", "Frequency", names(data_mean_std))

##Capitalize "m" in "mean" and "s" in "Std"
names(data_mean_std) <- gsub("mean", "Mean", names(data_mean_std))
names(data_mean_std) <- gsub("std", "Std", names(data_mean_std))

##Finally, remove "." and replace with "" to leave proper camel-case variable names
names(data_mean_std) <- gsub(".", "", names(data_mean_std), fixed = TRUE)

#5. From the data set in step 4, creates a second, independent tidy data set with the average of
#each variable for each activity and each subject.
data_mean_std_avgs <- colMeans(data_mean_std)

#store tidy data set and analysis as csv files
if(!file.exists("tidy_data.csv")) {
  write.csv(data_mean_std, "tidy_data.csv")
}

if(!file.exists("mean_data.csv")) {
  write.csv(data_mean_std_avgs, "mean_data.csv")
}

