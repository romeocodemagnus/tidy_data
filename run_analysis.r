
#set the required libraries
if (!require("data.table")) {
        install.packages("data.table")
}

if (!require("reshape2")) {
        install.packages("reshape2")
}


require("data.table")
require("reshape2")

#URL of File to download
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Local destination file
zippedData <- "./getdata-projectfiles-UCI-HAR-Dataset.zip"

# Download the zipped data set, if file does not exist
if (!file.exists(zippedData)) {
        download.file(fileURL, destfile = zippedData, method="curl", mode="wb")
}

# Unzip the data set if not yet zipped; existence of directory means it has been zipped
unzippedDirectory <- "./UCI HAR Dataset"
if (file.exists(unzippedDirectory) == FALSE) {
        unzip(zippedData)
}

# Load activitylabels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt") [,2]

## A. Load Test Data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Load data column names from the features.txt
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

#add column names
names(X_test) = features

# Extract only the measurements on the mean and standard deviation for each measurement
filtered_features <- grepl("mean|std", features)
X_test = X_test[, filtered_features]

# Load activity Data
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "Subject"

# Bind the three data into one
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

## B. Load Train Data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#add column names
names(X_train) = features

# Extract only the measurements on the mean and standard deviation for each measurement
X_train = X_train[, filtered_features]

# Load activity Data
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "Subject"

# Bind the three data into one
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

# Merge test and train data
mergedData = rbind(test_data, train_data)

#get the columns in addition to Subject, Activity_ID, and Activity_Label
other_labels   = c("Subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), other_labels)

#convert data to long format
melt_data = melt(data, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset using dcast function and convert back to wide format
tidy_data = dcast(melt_data, Subject + Activity_Label ~ variable, mean)

# Created tidy data set in diretory
write.table(tidy_data, file = "./tidy_data.txt", row.name=FALSE)






