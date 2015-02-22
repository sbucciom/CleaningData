


# File URL to download
fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

# Local data file
localFzip <- "./getdata-projectfiles-UCI HAR Dataset.zip"

# Download the dataset (. ZIP), which does not exist
if (file.exists(localFzip) == FALSE) {
        download.file(fileURL, destfile = localFzip)
}

# Uncompress data file
if (file.exists(localFzip) == FALSE) {
        unzip(localFzip)
}


## 1. Merges the training and the test sets to create one data set:
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)


# Combines data table (train vs test) by rows
x <- rbind(xTrain, xTest)
y <- rbind(yTrain, yTest)
subj <- rbind(subject_train, subject_test)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement:
# Read features labels
features <- read.table("./UCI HAR Dataset/features.txt")
# Friendly names to features column
names(features) <- c('f_id', 'f_name')
# Search for matches to argument mean or standard deviation (sd)  within each element of character vector
index_features <- grep("-mean\\(\\)|-std\\(\\)", features$f_name) 
x <- x[, index_features] 
# Replaces all matches of a string features 
names(x) <- gsub("\\(|\\)", "", (features[index_features, 2]))



## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names

# Read activity labels
activities_lab <- read.table("./UCI HAR Dataset/activity_labels.txt")
# Friendly names to activities column
names(activities_lab) <- c('act_id', 'act_name')
y[, 1] = activities_lab[y[, 1], 2]

names(y) <- "Activity"
names(subj) <- "Subject"

# Combines data table by columns
tidyDS <- cbind(subj, y, x)



# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
second <- tidyDS[, 3:dim(tidyDS)[2]] 
tidyDS_avg <- aggregate(second,list(tidyDS$Subject, tidyDS$Activity), mean)

# Activity and Subject name of columns 
names(tidyDS_avg)[1] <- "Subject"
names(tidyDS_avg)[2] <- "Activity"# Created csv (tidy data set) in diretory


# Created txt (tidy data set AVG) in diretory
write.table(tidyDS_avg, "./tidyDSavg.txt")

