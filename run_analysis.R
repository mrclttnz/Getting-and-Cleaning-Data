
setwd("C:/projects/Coursera/Getting and Cleaning Data/Assignment/work/Getting-and-Cleaning-Data")

library(plyr)


#### Step 0: read input files from indata folder
activity_labels = read.table(file="./indata/activity_labels.txt", sep="", header=F, col.names=c("activity.ID","activity.name"))

features = read.table(file="./indata/features.txt", sep="", header=F, col.names=c("feature.ID","feature.name"))


x_test = read.table(file="./indata/X_test.txt", sep="", header=F)
x_train = read.table(file="./indata/X_train.txt", sep="", header=F)

subject_test = read.table(file="./indata/subject_test.txt", sep="", header=F, col.names=c("subject.ID"))
subject_train = read.table(file="./indata/subject_train.txt", sep="", header=F, col.names=c("subject.ID"))

y_test = read.table(file="./indata/y_test.txt", sep="", header=F, col.names=c("activity.ID"))
y_train = read.table(file="./indata/y_train.txt", sep="", header=F, col.names=c("activity.ID"))



#### Step 1: Merges the training and the test sets to create one data set.

# combines training and test for X data
xData = rbind(x_train, x_test)
head(xData)

# combines training and test for subject IDs
subjectIDs = rbind(subject_train, subject_test)
head(subjectIDs)

# combines training and test for activity IDs
activityIDs = rbind(y_train, y_test)
head(activityIDs)

# create first data set with all information (relies on no one having changed order.... better explain!!!)
data = cbind(xData, subjectIDs, activityIDs)


#### Step2: Extracts only the measurements on the mean and standard deviation for each measurement

# select only the columns whose name contains "mean()" or "std()" in the feature description file (features.txt)
# also include the last two columns (562 and 563) that have been added to the dataset (subject.ID and activity.ID) 

selFeatureIdx = grep("(mean|std)[(][)]", features$feature.name, ignore.case=T)
selectedFeatures = features[selFeatureIdx,]
# selectedFeatures = features[c(1,2,4,5),]   ## use this only while testing the code to be able to manage the number of variables to print on screen
selectedFeatures

selectedColumns = data[, c(selectedFeatures$feature.ID,562,563)]
#selectedColumns[1:10,]



#### Step 3: Uses descriptive activity names to name the activities in the data set

## join "selectedColumns" and "activity_labels" by activity.ID to add activity.name 
allData = join(selectedColumns, activity_labels, by="activity.ID", match="first")
#allData[1:10,]


#### Step 4: Appropriately labels the data set with descriptive variable names

## apply to each mean() and std() feature the same names used in the original data set
## forces "subject.ID", "activity.ID" and "activity.name" for the three other variables
colnames(allData) = c("activity.ID", as.character(selectedFeatures$feature.name), "subject.ID", "activity.name")
#allData[1:10,]
allData = allData[,c(ncol(allData)-1, 1, ncol(allData),seq(2,ncol(allData)-2))]
#allData[1:10,]


#### Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject

averages = aggregate(. ~ activity.ID + activity.name  + subject.ID, allData, mean)
averages = arrange(averages, activity.ID, activity.name)
averages[1:10,]



write.table(allData, file="./outdata/allData.txt", sep="\t", row.names=F)
write.table(averages, file="./outdata/averages.txt", sep="\t", row.names=F)
