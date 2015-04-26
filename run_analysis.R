run_analysis <- function() {
  ## Data source: [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
  ##    Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
  ##    International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
  
  ## Using the UCI HAR Dataset, this script attempts to:
  ##
  ## 1. Merge the training and the test sets to create one data set.
  ## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  ## 3. Uses descriptive activity names to name the activities in the data set
  ## 4. Appropriately labels the data set with descriptive variable names. 
  ## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
  ##    variable for each activity and each subject.
  
  ## Setting the working directory for my PC.
  setwd("C:/Users/CarlosDaniel/SkyDrive/Documentos/Tec de Monterrey/zCoursera/3. Getting and Cleaning Data/W3/CP")
  
  ## Getting in all the data
  xtest <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
  xtrain <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
  features <- read.table(file = "UCI HAR Dataset/features.txt")
  ytrain <- read.table(file = "UCI HAR Dataset/train/Y_train.txt")
  ytest <- read.table(file = "UCI HAR Dataset/test/y_test.txt")
  activities <- read.table(file = "UCI HAR Dataset/activity_labels.txt")
  strain <- read.table(file = "UCI HAR Dataset/train/subject_train.txt")
  stest <- read.table(file = "UCI HAR Dataset/test/subject_test.txt")
  
  ## 1. Merge the training and the test sets to create one data set, through rbind()
  dataset <- rbind(xtrain, xtest)
  names(dataset) <- as.character(features[, 2])
  rm(xtest, xtrain, features)
  
  ## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  smallds <- dataset[, grep("mean[\\(\\)]|std()", names(dataset))]
  rm(dataset)
  
  ## 3. Uses descriptive activity names to name the activities in the data set
  ys <- rbind(ytrain, ytest)
  smallds <- cbind(smallds, ys)
  rm(ytrain, ytest)
  smallds <- merge(smallds, activities, by = "V1")
  
  ## 4. Appropriately labels the data set with descriptive variable names. 
  colnames(smallds)<- gsub("tBody","time body ",colnames(smallds))
  colnames(smallds)<- gsub("tGravity","time gravity ",colnames(smallds))
  colnames(smallds)<- gsub("fBody","frequency body ",colnames(smallds))
  colnames(smallds)<- gsub("fGravity","frequency gravity ",colnames(smallds))
  
  ## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
  ##    variable for each activity and each subject.
  subjects <- rbind(strain, stest)
  smallds <- cbind(smallds, subjects)
  colnames(smallds)[68] <- "activity"
  colnames(smallds)[69] <- "subject"
  tidy <- aggregate(smallds, list(smallds$subject, smallds$activity), FUN=mean, na.rm=TRUE)
  
  ## Preparing for upload
  write.table(tidy, file="tidy.txt", row.name=FALSE)
  
}