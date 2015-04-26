# GCDCourseProject
The Course Project for Getting and Cleaning Data in Coursera.

Below I explain how does run_analysis.R script works:

First, it sets the working directory to a specific folder in my PC (I used that to test the script); "the code should have a file run_analysis.R in the main directory that can be run as long as the Samsung data is in your working directory", therefore this should be valid.

Next, it starts downloading all the needed files from the folders.

After it downloads all the files needed, it merges the training and the test sets to create one data set, through rbind(). It also assigns the names for the columns in the "dataset" data frame by the values in the "features" vector. After this, some original files are deleted to free memory space.

Next, a new data frame called "smallds" is made with the extraction of the measurements on the mean and standard deviation for each measurement. It uses the function grep to find all the columns that include either "mean" or "std" in their name. After this, the "dataset" data frame is deleted.

It then gets the activity names from the already downloaded files Y_train.txt and y_test.txt, in a merged object "ys" - which are actually just numbers - and then they get binded to "smallds". Then, to get the names, it uses the merge() function to join "smallds" and "activities" (object obtained from the original file activity_labels.txt) by number.

After that, it uses the gsub() function to rename some substrings of the column names in "smallds". It creates a vector called "subjects", which contains the merged info of the subjects for both the train and test files, and it gets binded to "smallds". The column names for both activities and subjects is properly named in the dataset, and finally it's all copied to a second independent tidy data set, called "tidy", with the average of each variable for each activity and each subject.

It also uses a write.table() function to export the "tidy" data frame to a .txt file, to upload to the Course Project submission page :)
