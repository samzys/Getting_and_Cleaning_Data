setwd("C:\\Users\\Sam\\SkyDrive\\Documents\\Coursera\\3. Getting and Cleaning Data\\project")
##
#list.files("./UCI HAR Dataset",recursive = T)
library(reshape2)
library(data.table)

###
#1. Merges the training and the test sets to create one data set.
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
x_train_test<-rbind(x_train, x_test)

y_train<-read.table("./UCI HAR Dataset/train/Y_train.txt")
y_test<-read.table("./UCI HAR Dataset/test/Y_test.txt")
y_train_test<-rbind(y_train, y_test)

subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
s_train_test<-rbind(subject_train, subject_test)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
features<-read.table("./UCI HAR Dataset/features.txt")
indices_of_good_features <- grep("mean\\(\\)|std\\(\\)", features[,2])
x_train_test <- x_train_test[,indices_of_good_features]

#3. Uses descriptive activity names to name the activities in the data set
activities<-read.table("./UCI HAR Dataset/activity_labels.txt")
activities[,2] <- gsub("_", "", tolower(as.character(activities[,2])))
y_train_test[,1]<-activities[y_train_test[,1],2] #auto expand feature of R

#4. Appropriately labels the data set with descriptive variable names. 
names(x_train_test) <- tolower(gsub("\\(|\\)", "", features[indices_of_good_features, 2]))
names(x_train_test) <- gsub("bodybody","body",names(x_train_test))
names(x_train_test) <- gsub("-","",names(x_train_test))
names(x_train_test) <- gsub("^t","time",names(x_train_test))
names(x_train_test) <- gsub("^f","freq",names(x_train_test))

#create camelCase variable name
tempName<-names(x_train_test)

tempName<- gsub("acc","Acc",tempName)
tempName<- gsub("gyro","Gyro",tempName)

tempName<- gsub("mean","Mean",tempName)
tempName<- gsub("std","Std",tempName)

tempName<- gsub("body","Body",tempName)
tempName<- gsub("gravity","Gravity",tempName)

tempName<- gsub("jerk","Jerk",tempName)

tempName<- gsub("mag","Mag",tempName)
names(x_train_test)<-tempName

names(y_train_test) <- c("activities")
names(s_train_test) <- c("subject")

#5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.
mergedData<- cbind(x_train_test,y_train_test,s_train_test)
meltedData <- melt(mergedData, id=c("subject","activities"),measure.vars = names(mergedData)[1:66])

#also can use a combination of group_by and summarise to achieve it
tidyData<-dcast(meltedData, subject + activities ~ variable, mean)

#write to a txt file
write.table(tidyData, file="tidy_dataset.txt",row.names = FALSE)