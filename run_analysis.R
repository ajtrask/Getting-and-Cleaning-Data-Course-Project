run_analysis <- function() {
  ## This function reads in the UCI HAR Dataset from the current directory
  ## Processes it into a tidy data set
  ## And writes it to a file
  
  ## This function requires the dplyr package
  library(dplyr)
  
  ## Read the activity labels from activity_labels.txt
  activity_labels<-read.table("activity_labels.txt",sep="",header = FALSE)
  
  ## Read the feature labels from features.txt
  feature_labels<-read.table("features.txt",sep="",header=FALSE)
  
  ## Read training data from train subfolder
  subject_train<-read.table("train/subject_train.txt",sep="",header=FALSE)
  x_train<-read.table("train/X_train.txt",sep="",header=FALSE)
  y_train<-read.table("train/y_train.txt",sep="",header=FALSE)
  
  ## Rename column names in x_train (Task 4. Appropriately
  ## labels the data set with descriptive variable names)
  colnames(x_train)<-as.character(feature_labels$V2)
  
  ## Rename column name in subject_train
  colnames(subject_train)<-"subject_id"
  
  ## Rename column name in y_train
  colnames(y_train)<-"activity"
  
  ## Convert column activity in y_train to factor
  ## using activity_labels (Task 3. Uses descriptive 
  ## activity names to name the activities in the data set)
  y_train$activity<-factor(y_train$activity,
                           levels = activity_labels$V1,
                           labels = activity_labels$V2)
  
  ## merge data frames into one training set
  train_data<-cbind(subject_train,y_train,x_train)
  
  ## Read test data from test subfolder
  subject_test<-read.table("test/subject_test.txt",sep="",header=FALSE)
  x_test<-read.table("test/X_test.txt",sep="",header=FALSE)
  y_test<-read.table("test/y_test.txt",sep="",header=FALSE)
  
  ## Rename column names in x_test (Task 4. Appropriately
  ## labels the data set with descriptive variable names)
  colnames(x_test)<-as.character(feature_labels$V2)
  
  ## Rename column name in subject_test
  colnames(subject_test)<-"subject_id"
  
  ## Rename column name in y_test
  colnames(y_test)<-"activity"

  ## Convert column activity in y_test to factor
  ## using activity_labels (Task 3. Uses descriptive 
  ## activity names to name the activities in the data set)
  y_test$activity<-factor(y_test$activity,
                           levels = activity_labels$V1,
                           labels = activity_labels$V2)
  
  ## merge data frames into one test set
  test_data<-cbind(subject_test,y_test,x_test)
  
  ## merge test data and training data into one set (Task 1.
  ## Merges the training and the test sets to create one
  ## data set)
  human_activity<-rbind(test_data,train_data)
  
  ## Task 2. Extracts only the measurements on the mean and standard deviation for each measurement
  ## remove measurements except for mean and standard deviation
  
  human_activity<-human_activity[,-grep("max()",colnames(human_activity))] ##remove max
  human_activity<-human_activity[,-grep("min()",colnames(human_activity))] ##remove min
  human_activity<-human_activity[,-grep("mad()",colnames(human_activity))] ##remove mad
  human_activity<-human_activity[,-grep("arCoeff()",colnames(human_activity))] ##remove arCoeff
  human_activity<-human_activity[,-grep("energy()",colnames(human_activity))] ##remove energy
  human_activity<-human_activity[,-grep("entropy()",colnames(human_activity))] ##remove entropy
  human_activity<-human_activity[,-grep("iqr()",colnames(human_activity))] ##remove iqr
  human_activity<-human_activity[,-grep("meanFreq()",colnames(human_activity))] ##remove meanFreq
  human_activity<-human_activity[,-grep("bandsEnergy()",colnames(human_activity))] ##remove bandsEnergy
  human_activity<-human_activity[,-grep("sma()",colnames(human_activity))] ##remove sma
  human_activity<-human_activity[,-grep("skewness()",colnames(human_activity))] ##remove skewness
  human_activity<-human_activity[,-grep("kurtosis()",colnames(human_activity))] ##remove kurtosis
  human_activity<-human_activity[,-grep("correlation()",colnames(human_activity))] ##remove correlation
  human_activity<-human_activity[,-grep("angle(*)",colnames(human_activity))] ##remove angles
  
  ## Replace dashes with underscores and remove parenthesis
  colnames(human_activity)<-gsub("-","_",colnames(human_activity))  ## replace - with _
  colnames(human_activity)<-gsub("\\()","",colnames(human_activity)) ## remove ()
  
  ## Replace the first lower case t with TimeDomain
  colnames(human_activity)<-gsub("^t","TimeDomain",colnames(human_activity))
  
  ## Replace the first lower case f with FreqDomain
  colnames(human_activity)<-gsub("^f","FreqDomain",colnames(human_activity))
  
  ## convert data to data frame
  human_activity<-tbl_df(human_activity)
  
  ## Task 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

  tidy_summary<-aggregate(x = human_activity[,c(-1,-2)],by = list(Activity = human_activity$activity, Subject = human_activity$subject_id), FUN="mean")
  colnames(tidy_summary)[c(-1,-2)]<-paste("AverageOf", colnames(tidy_summary)[c(-1,-2)], sep = "")
  write.table(tidy_summary,row.names = FALSE,file = "tidy_summary.txt")
  
  
  
  
  
}