# Set the working directory to the project directory and clear the global
# environment
setwd("~/Projects/Coursera Data Science/getdata-006/project")
rm(list=ls())

# The following steps are to create the data frame trainData 
# for the Training set.
# Read the subject set into a temporary data frame.
subjectsData <- read.table("data/train/subject_train.txt", header = F)
names(subjectsData) <- "subject"
# Read the X set into a temporary data frame.
xData <- read.table("data/train/X_train.txt", header = F)
# Read the Y set into a temporary data frame.
yData <- read.table("data/train/y_train.txt", header = F)
names(yData) <- "activity"
# Create trainData by combining by columns the above data frames.
trainData <- cbind(subjectsData, xData, yData)
# Removing temporary data frames.
rm(subjectsData, xData, yData)

# The following steps are to create the data frame testData
# for the Test set.
# Read the subject set into a temporary data frame.
subjectsData <- read.table("data/test/subject_test.txt", header = F)
names(subjectsData) <- "subject"
# Read the X set into a temporary data frame.
xData <- read.table("data/test/X_test.txt", header = F)
# Read the Y set into a temporary data frame.
yData <- read.table("data/test/y_test.txt", header = F)
names(yData) <- "activity"
# Create trainData by combining by columns the above data frames.
testData <- cbind(subjectsData, xData, yData)
# Removing temporary data frames.
rm(subjectsData, xData, yData)

# 1. Merges the Training and the Test data frames to create one data set.
#    Since the subjects performing the Training are not the ones performing
#    the Test; i.e. intersect(testData$subject, trainData$subject) result in 0.
#    So, I am going to merge both data sets by combining them by rows.
allData <- rbind(trainData, testData)
# Removing temporary data frames.
rm(trainData, testData)

# 2. Extracts only the measurements on the mean and standard deviation for 
#    each measurement.
means <- c("V1", "V2", "V3", "V41", "V42", "V43", "V81", "V82", "V83", "V121", 
           "V122", "V123", "V161", "V162", "V163", "V201", "V214", "V227", 
           "V240", "V253", "V266", "V267", "V268", "V345", "V346", "V347", 
           "V424", "V425", "V426", "V503", "V516", "V529", "V542")
stdevs <- c("V4", "V5", "V6", "V44", "V45", "V46", "V84", "V85", "V86", "V124", 
            "V125", "V126", "V164", "V165", "V166", "V202", "V215", "V228", 
            "V241", "V254", "V269", "V270", "V271", "V348", "V349", "V350", 
            "V427", "V428", "V429", "V504", "V517", "V530", "V543")
allData[, c(means, stdevs)]

# 3. Uses descriptive activity names to name the activities in the data set.
# Encode the variable "activity" as a factor.
allData$activity <- factor(allData$activity)
# Rename all levels of the Y set.
levels(allData$activity) <- c("WALKING", "WALKING_UPSTAIRS", 
                              "WALKING_DOWNSTAIRS", "SITTING", "STANDING", 
                              "LAYING")

# 4. Appropriately labels the data set with descriptive variable names.
# Using the features set as column labels.
colLabels <- read.table("data/features.txt", header = F, stringsAsFactors = F)
names(allData)[2:562] <- colLabels$V2

# 5. Creates a second, independent tidy data set with the average of each 
#    variable for each activity and each subject. 
#    Change subject variable into class factor.
allData$subject <- factor(allData$subject)
meltData <- melt(allData, id.vars = c("subject", "activity"))
averagesData <- dcast(meltData, subject + activity ~ ..., mean)
# Checking ...
averagesData[averagesData$subject == 1, c("subject", "activity", 
                                          "tBodyAcc-mean()-X", 
                                          "tBodyAcc-mean()-Y", 
                                          "tBodyAcc-mean()-Z")]

# Create a txt file from the tidy data set.
write.table(averagesData, file = "data/tiday.txt", row.names = F)
