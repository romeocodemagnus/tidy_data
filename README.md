# Getting and Cleaning Data

## Course Project Instructions

You should create one R script called run_analysis.R that does the following.

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately label the data set with descriptive activity names.
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps:

1. Clone or download ```run_analysis.R``` into your current working directory. It is critical that you place the code in RStudio's current working directory. 
2. Run ```source("run_analysis.R")```. The code will download and install the necessary packages as well as download the data set. The final part is it will generate a new file ```tiny_data.txt``` in your working directory.

## Dependencies

1. ```run_analysis.R``` file will help you to install the dependencies automatically. It depends on ```reshape2``` and ```data.table```. 
2. The code was created and tested in OS X Yosemite using RStudio Version 0.98.1091 

