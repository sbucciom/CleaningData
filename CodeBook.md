# Code Book

This document describes the code inside run_analysis.R that extract the measurements on the mean and standard deviation for each measurement presents in the data inside the following zip file https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
The code is splitted (by comments) in some sections:

- 1 Merges the training and the test sets to create one data set.
- 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
- 3 Uses descriptive activity names to name the activities in the data set
- 4 Appropriately labels the data set with descriptive variable names. 
- 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### 1. Merges the training and the test sets to create one data set.
Read dataset files from UCI HAR to given name and prefix. Know names are "train" and "test". Known prefixes are "x", "y" and "subject".

Examples for train

- UCI HAR Dataset/train/X_train.txt
- UCI HAR Dataset/train/y_train.txt
- UCI HAR Dataset/train/subject_train.txt



### 2. Extracts only the measurements on the mean and standard deviation for each measurement:
first af all we read the features labels
> features <- read.table("./UCI HAR Dataset/features.txt")

and set a friendly names to features column
> names(features) <- c('f_id', 'f_name')

than filter for only mean and standard deviation (sd) to obtain a index_features to use for obtain the correct x subsetting

> x <- x[, index_features] 

and we could also replaces all matches of a string features with a pattern matching replacement
> names(x) <- gsub("\\(|\\)", "", (features[index_features, 2]))



### 3.4. Uses descriptive activity names to name the activities in the data set + Appropriately labels the data set with descriptive variable names

To obtain real tidy data we have to read activity labels
> activities_lab <- read.table("./UCI HAR Dataset/activity_labels.txt")

and  friendly names to activities column that came inside the zip file downloaded

> names(activities_lab) <- c('act_id', 'act_name')

At least we obtain a firendly data table using combines data table, cbind, for the subj, x, y each having 10299 num row.
> tidyDS <- cbind(subj, y, x)



### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
we could use the aggregate function for applying the mean function to each activity and subject
> tidyDS_avg <- aggregate(second,list(tidyDS$Subject, tidyDS$Activity), mean)

Than we have only to use friendly name for the column and store the data set tidyDS_avg to the output file 

> write.table(tidyDS_avg, "./tidyDSavg.txt")
