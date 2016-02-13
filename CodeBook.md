## CodeBook for Creating a Tidy Dataset from the Human Activity Recognition Using Smartphones Data Set

### Data Source
The Human Activity Recognition Using Smartphones Data Set is avaiable here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Detailed information on the observations and how they are collected and computed can be found at that location.

### Data Importing 

The data spans multiple space delimited files and the labels are stored seperately in other files.

The activity labels are read in as a table from activity_labels.txt.  This file consists of two columns, one with an integer ID and one with a string label.  This is used later to turn the activity ID column from the y_train.txt and y_test.txt files into a factor with the labels.

The feature labels are read in as a table from features.txt.  This file lists the features in the data set in the order they were written to the X_train.txt and X_test.txt files.

The feature vectors are stored in multiple files and in two data sets. The train and test subfolders contain subject_train.txt and subject_test.txt which provides the subject ID for each observation (row) in the files.  The X_train.txt and X_test.txt files contain the smartphone motion data in the time domain and frequency domain recorded and computed for each subject while they performed specified activities.  The labels for these observations were read in from the features.txt and the column names were renamed to these.  The activity ID is read in from y_train.txt and y_test.txt.  These are turned into a factor with the index and labels provided in the activity_labels.txt file.  The columns from these three files in test and in train subfolders are combined into tables and then the test and train tables are appended so the resulting table contains all the test and train data as one set.  This results in a table with subject_id, activity, and all the measurements as columns which is called human_activity in the script.

## Down Select Features

Per the directions for the course project, the feature set is reduced to only the mean and standard deviations variables.  The following measurement types are removed:

* max
* min
* mad
* arCoeff
* energy
* entropy
* iqr
* meanFreq
* bandsEnergy
* sma
* skewness
* kurtosis
* correlation
* angles
  
## Improve Label Readability

To improve the readability of the labels and their reference in any future code, the dashes are replaced with underscores and the parenthesis are removed.  The lower case t abreviation in the variable names refers to the time domain, so the t's are replaced with "TimeDomain".  The same occurs for the f's which refer to the frequency domain.  Those are replaced with "FreqDomain".  This results in a table with slightly more readable column names.
  
## Aggregate and Output

The last step from the course project directions is to output a tidy data set with the average of each variable for each activity and each subject.  The aggregation occurs by activity and then by subject using the "mean" function.  The resulting table has column names with "AverageOf" prepended to each variable or feature and values that are the average of each feature grouped by activity and subject.  This is written to tidy_summary.txt using the "write.table" function without row names.
