library(dplyr)

## download the data file
if(!file.exists("./data")) {dir.create("./data")}
Url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Url, destfile = "./data/data.zip", method = "curl")
unzip("./data/data.zip")

# Read all data sets
features = read.table("./UCI HAR Dataset/features.txt", col.names = c("n","features"))
activity_labels = read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activity_code", "activity_name"))

        ## training data sets
subject_train = read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
train_data = read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$features)
train_labels = read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activity_code")

        ## testing data sets
subject_test = read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test_data = read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$features)
test_labels = read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activity_code")


# 1. Merges the training and the test sets to create one data set.
whole_data = rbind(train_data, test_data)
whole_labels = rbind(train_labels, test_labels)
whole_subject = rbind(subject_train, subject_test)
merged_data = cbind(whole_subject, whole_labels, whole_data)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
        ## find column number for mean and std including "subject" and "activity_code" columns
mean_std_list = grep("subject|activity_code|mean|std", names(merged_data))
        
        ## extract the data sets through column numbers
mean_std_data = merged_data[, mean_std_list]


# 3. Uses descriptive activity names to name the activities in the data set
        ## Assign strings value to numeric number and create a new column call activity_name in mean_std_data
mean_std_data$activity_name = factor(mean_std_data$activity_code, activity_labels$activity_code, activity_labels$activity_name)

        ## move the activity_name column to the front
mean_std_data = mean_std_data %>% relocate(activity_name, .after = activity_code)


# 4. Appropriately labels the data set with descriptive variable names. 
names(mean_std_data) = gsub("Acc", "Accelerometer", names(mean_std_data))
names(mean_std_data) = gsub("Gyro", "Gyroscope", names(mean_std_data))
names(mean_std_data) = gsub("^t", "Time", names(mean_std_data))
names(mean_std_data) = gsub("Mag", "Magnitude", names(mean_std_data))
names(mean_std_data) = gsub("^f", "Frequency", names(mean_std_data))
names(mean_std_data) = gsub("mad", "MedianAbsoluteDeviation", names(mean_std_data))
names(mean_std_data) = gsub("sma", "SignalMagnitudeArea", names(mean_std_data))
names(mean_std_data) = gsub("iqr", "InterquartileRange", names(mean_std_data))
names(mean_std_data) = gsub("arCoeff", "AutoRegressionCoefficients", names(mean_std_data))
names(mean_std_data) = gsub("maxInds", "LargestMagnitudeFrequencyIndex", names(mean_std_data))
names(mean_std_data) = gsub("meanFreq", "MeanFrequencyWeightedAverage", names(mean_std_data))



# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
        ## group the data by subjects first then activity_name
        ## summarize all the rest variable and apply mean() function to them
tidy_data = mean_std_data %>% group_by(subject, activity_name) %>% summarise_all(mean)
write.table(tidy_data, "tidy_data.txt", row.names = F)



