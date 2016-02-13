# Getting-and-Cleaning-Data-Course-Project
Coursera Getting and Cleaning Data Course Project

# run_analysis()
This function reads in the UCI HAR Dataset from a subfolder with the same name in the current directory.  The dplyr package is required to execute this function.  The following files are read in from the UCI HAR Dataset subfolder:

* features.txt for the feature labels
* activity_labels.txt for the activity labels

The the train and test data are read from their respective subfolders in the UCI HAR Dataset subfolder:

train:
* X_train.txt which are the training set feature vectors
* y_train.txt which are the training set activity IDs
* subject_train.txt which are the training set subject IDs

test:
* X_test.txt which are the test set feature vectors
* y_test.txt which are the test set activity IDs
* subject_test.txt which are the test set subject IDs

The test and train data are combined into one data frame, the feature columns are named using the feature labels, and the activity data is converted into a factor using the activity labels.  Then the feature column names are modified slightly for better readability by removing parenthesis, replacing dashes with underscores, and expanding the "t" and "f" abreviations to "TimeDomain" and "FreqDomain".

All features are removed except for the mean and standard deviation as the directions for this project specified.  Then the data is aggregated by activity and subject ID using averages.  "AverageOf" is prepended to the column names of the resulting data frame and then it is written to tidy_summary.txt without rownames as the directions for this project specified.
