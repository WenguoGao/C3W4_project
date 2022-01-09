The run_analysis.R script downloads data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, and then followed by the following steps to clean the data.

1. Download the dataset 
        - Download the data file from the link that is provided by the course project.
        - Unzip the file and extract the folder called "UCI HAR Dataset". 
        
2. Read dataset and assign each data to variables. 
        - variable "features" from "features.txt"
                - It has 2 columns: "n" and "features", and 561 rows. 
                - The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and                     tGyro-XYZ. 

        - variable "activity_labels" from "activity_labels.txt"
                - It has 6 rows and 2 columns.
                - Column names: "activity_code", "activity_name".
                - Links the class labels with their 6 activity names. 
       
        - variable "subject_train" from "subject_train.txt"
                - It has 7352 rows and 1 column. 
                - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

        - variable "train_data" from "X_train.txt"
                - It has 7352 rows and 561 columns. 
                - Training set.
                - Name the column name as "features$features".
        
        - variable "train_labels" from "y_train.txt"
                - It has 7352 rows and 1 column. 
                - Each row identifies the activity that performed for each window sample. Its range is from 1 to 6.
        
        - variable "subject_test" from "subject_test.txt"
                - It has 2947 rows and 1 column.
                - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
        
        - variable "test_data" from "X_test.txt"
                - It has 2947 rows and 561 columns. 
                - Test set.
                - Name the column name as "features$features".
        
        - variable "test_labels" from "y_test.txt"
                - It has 2947 rows and 1 column. 
                - Each row identifies the activity that performed for each window sample. Its range is from 1 to 6.
        
3. Merge the training and the test sets to create one data set. 
        - variable "whole_data" (10299 rows and 561 columns) is from merging "train_data" and "test_data" using rbind() function.
        - variable "whole_labels" (10299 rows and 1 column) is from merging "train_labels" and "test_labels" using rbind() function.
        - variable "whole_subject" (10299 rows and 1 column) is from merging "subject_train" and "subject_test" using rbind() function.
        - variable "merged_data" (10299 rows and 563 columns) is from merging "whole_subject", "whole_labels", "whole_data" using cbind()                  function. 

4. Extract only the measurements on the mean and standard deviation for each measurement. 
        - "mean_std_list" (81 int) is from extracting the column index that contains "subject", "activity_code", "mean", or "std"              using grep() function. 
        - variable "mean_std_data" (10299 rows, 82 columns) is from selecting the listed column ("mean_std_list") from "merged_data". 
        
5. Uses descriptive activity names to name the activities in the data set. 
        - Add one more column called "activity_name" to variable "mean_std_data" to interpret the "activity_code" to its descriptive names. 
        - Create a new column called "activity_code"
        - Using factor() function to give the according activity name to the activity code from variable "activity_labels". 
        - Move the column "activity_labels" to the front using relocate() function, and put it after the column "activity_code".
        

6. Appropriately labels the data set with descriptive variable names. 
        - Replace all the abbreviations that mentioned in the "README.txt" inside of the "UCI HAR Dataset" folder.
        - Using gsub() function to replace all the abbraviations. 
        - All the column names starting with "t" are replaced to "Time". 
        - All the column names contain "Acc" are replaced to "Acceleration".
        - All the column names contain "Mag" are replaced to "Magnitude".
        - All the column names starting with "f" are replaced to "Frequency".
        - All the column names contain "mad" are replaced to "MedianAbsoluteDeviation".
        - All the column names contain "sma" are replaced to "SignalMagnitudeArea".
        - All the column names contain "iqr" are replaced to "InterquartileRange".
        - All the column names contain "arCoeff" are replaced to "AutoRegressionCoefficients".
        - All the column names contain "maxInds" are replaced to "LargestMagnitudeFrequencyIndex".
        - All the column names contain "meanFreq" are replaced to "MeanFrequencyWeightedAverage".
        
        
7. From the data set in step 4, creates a second, independent tide data set with the average of each variable for each activity and each subject. 
        - Create a new data set called "tide_data", using "group_by" function to group the data set "mean_std_data" by column "subject" and then "activity", and then using "summarise_all" function to apply the "mean" function to every column in the data set. 
        - "tidy_data" has 180 rows and 82 columns. 
        - Export the data set into a txt file "tidy_data.txt". 
        
        
        
        
        
        
        
        
        
        