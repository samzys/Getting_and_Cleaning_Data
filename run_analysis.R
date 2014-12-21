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

#4. Appropriately labels the data set with descriptive variable name
names(x_train_test)<-features[indices_of_good_features,2]
names(x_train_test) <- gsub("bodybody","body",names(x_train_test))
names(y_train_test) <- c("activities")
names(s_train_test) <- c("subject")
mergedData<- cbind(x_train_test,y_train_test,s_train_test)

#5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.
meltedData <- melt(mergedData, id=c("subject","activities"), measure.vars = names(mergedData)[1:66])
#get the mean value 
df<-aggregate(value ~ subject+activities+variable, data=meltedData, mean)

#split col variable to make a clean data set
head(df$variable)
#The desired features are 66 (e.g., fBodyAcc-mean()-X)

length(unique(df$variable))

x<-c(1,2)
y<-cbind(grepl("^t", df$variable), grepl("^f", df$variable))
df$domain <- factor(y%*%x, labels=c("Time", "Freq"))

y<-cbind(grepl("Acc", df$variable), grepl("Gyro", df$variable))
df$device <-factor(y%*%x, labels = c("Accelerometer", "Gyroscope"))

y<-cbind(grepl("BodyAcc", df$variable), grepl("GravityAcc", df$variable))
df$acceleration <-factor(y%*%x, labels = c(NA, "Body", "Gravity"))

y<-cbind(grepl("mean", df$variable), grepl("std", df$variable))
df$mathMethod<-factor(y%*%x, labels = c("Mean", "Sd"))

#features with 1 category
df$jerk <-factor(grepl("Jerk", df$variable), labels = c(NA, "Jerk"))
df$magnitude <-factor(grepl("Mag", df$variable), labels = c(NA, "Mag"))

#deal with axes xyz
x<-c(1,2,3)
y<-cbind(grepl("-X", df$variable),grepl("-Y", df$variable), grepl("-Z", df$variable))
df$axis<-factor(y %*% x, labels=c(NA, "X", "Y", "Z"))

tidyData<-subset(df, select=c(1,2,4:11))
names(tidyData)<-gsub("value", "meanValue", names(tidyData))
tidyData<-tidyData[,c(1:2,4:10,3)]
#write to a txt file
write.table(tidyData, file="tidy_dataset.txt",row.names = FALSE)

