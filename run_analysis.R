 library(plyr)

# Step 1
# Merge the training and test sets to create one data set
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
# Step 2
#Extracts only the measurements on the mean and standard deviation for each measurement. 
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test<- read.table("UCI HAR Dataset/test/subject_test.txt")

# Step 3
#Uses descriptive activity names to name the activities in the data set

features<-read.table("UCI HAR Dataset/features.txt")
mean_and_std_features <-grep("-(mean|std)\\(\\)",features[, 2])
x_data<- x_data[,mean_and_std_features]
names(x_data)<-features[mean_and_std_features, 2]

# Step 4
#Appropriately labels the data set with descriptive variable names. 

activities<-read.table("UCI HAR Dataset/activity_labels.txt")
y_data[,1]<-activities[y_data[, 1], 2]

# correct column name
names(y_data)<-"activity"
names(subject_data)<-"subject"
# bind all the data in a single data set
all_data <- cbind(x_data, y_data, subject_data)
#Step 5
#creates a second, independent tidy data set with the average of each variable for each activity and each subject.
averages_data<-ddply(all_data,.(subject, activity),function(x)colMeans(x[,1:66]))
write.table(averages_data,"averages_data.txt",row.name=FALSE)