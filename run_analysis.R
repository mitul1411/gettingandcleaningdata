# Merge the training and the test data set.
trainDir <- "./data/train"
testDir <- "./data/test"
join_data <- rbind(read.table(paste(trainDir,"X_train.txt",sep="/")), read.table(paste(testDir,"X_test.txt",sep="/")))
join_label <- rbind(read.table(paste(trainDir,"y_train.txt",sep="/")), read.table(paste(testDir,"y_test.txt",sep="/")))
join_subject <- rbind(read.table(paste(trainDir,"subject_train.txt",sep="/")), read.table(paste(testDir,"subject_test.txt",sep="/")))

# Extract mean and standard deviation for each measurement.
features <- read.table("./data/features.txt")
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
join_data <- join_data[, meanStdIndices]
names(join_data) <- gsub("-", "", gsub("std", "Std", gsub("mean", "Mean", gsub("\\(\\)", "", features[meanStdIndices, 2]))))

# Use descriptive activity names to name the activities in the data set
activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[join_label[, 1], 2]
join_label[, 1] <- activityLabel
names(join_label) <- "activity"

# Label the data set with descriptive activity names. 
names(join_subject) <- "subject"
clean_data <- cbind(join_subject, join_label, join_data)

# Create another tidy data set with average of each variable for each activity and each subject. 
subjectLen <- length(table(join_subject))
activityLen <- dim(activity)[1]
columnLen <- dim(clean_data)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(clean_data)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(join_subject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    subjectBool <- i == cleanedData$subject
    activityBool <- activity[j, 2] == cleanedData$activity
    result[row, 3:columnLen] <- colMeans(clean_data[subjectBool&activityBool, 3:columnLen])
    row <- row + 1
  }
}
write.table(result, "means.txt")