The script run_analysis.R performs the analysis on the project's data sets. The following is an explanation of what the script does:

1. Read the Training subjects, x data set, and y data set into temporary data frames. Then combine them by columns. The subject and activity columns are labled correctly.

2. Read the Test subjects, x data set, and y data set into temporary data frames. Then combine them by columns. The subject and activity columns are labled correctly.

3. Combine above temporary data frames to create one data set.

4. Extract only the measurements on the mean and standard deviation for each measurement.

5. Convert the activity variable into a factor and change its levels with descriptive names.

6. Label the data set variables properly.

7. To create the tidy data set, I used the 'melt' function in the 'reshape2' package. The one data set is melted with the variables 'subject' and 'activity' as 'id.vars' and the remaining variables as 'measure.vars'. Then I used the 'dcast' function to calcualte the averages of each variable for each activity and each subject.
