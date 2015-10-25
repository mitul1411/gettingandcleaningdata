Getting and Cleaning Data Course Project CodeBook
=================================================
This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.  

The data for the project:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  


Study Design
------------
From the "data" directory, read X_train.txt, y_train.txt, subject_train.txt, X_test.txt, y_test.txt and subject_test.txt.

Read the features.txt file from the store in *features* variable. We only extract the measurements on the mean and standard deviation.

Now, we clean the column names of the subset. 

Then, we read the activity_labels.txt file and store in *activity* variable.

After that, we clean the activity names in the second column of *activity*.

Now, we transform the values of *join_label* according to the *activity* data frame.  
 
Combine the *join_subject*, *join_label* and *join_data* by column to get data frame named *cleanedData*.

Write the *result* variable to means.txt file in current working directory. 