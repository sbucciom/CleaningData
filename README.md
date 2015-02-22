# Human Activity Recognition Using Smartphones

This script "run_analysis.R" extract the measurements on the mean and standard deviation for each measurement presents in the data inside the following zip file https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

In details the steps performed by the script are:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The output of the script is the file named "tidyDSavg.txt" as a dump file of the tidy data set with the average of the variable as described in the last item of the list above
