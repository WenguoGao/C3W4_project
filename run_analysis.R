## download the data file
if(!file.exists("./data")) {dir.create("./data")}
Url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Url, destfile = "./data/data.zip", method = "curl")
unzip("./data/data.zip")

test_data = read.table("./UCI HAR Dataset/test/X_test.txt")
