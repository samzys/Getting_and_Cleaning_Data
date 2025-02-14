Course Project of Getting and Cleaning Data
---------------------------
>The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to
>prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no
>questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to
>a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the
>data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also
>include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are
>connected.  
>
>
>One of the most exciting areas in all of data science right now is wearable computing - see for example this article.
>Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.
>The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S
>smartphone. A full description is available at the site where the data was obtained: 
>
>
>http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
>
>
>Here are the data for the project: 
>
>https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

What does the script do
---------------------------
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


How does the script work
---------------------------
1. Download and Unzip the Samsung data into the working directory (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Download and Put run_analysis.r into the same working directory as in step 1
3. Run the script using RStudio which will produce a tidy data set for further analysis
4. The tidy dataset fullfills the following criterias: each variable forms a column, each observation forms a row, each table/file stores data about one kinds of obervation
5. In oder to fullfill the tidy dataset requirement, there is a additional step to split variables names for original variable names. for example, it splits 1 variable with value(tBodyAcc-mean()-X) into 7 variables( "domain", "device", "acceleration", "mathMethod", "jerk","magnitude", "axis"). more details please refer to CodeBook.md
6. load the tidydata into R using this 
```r
df<-read.table("tidy_dataset.txt",header = T)
```

Total number of observations
--------------------------------
*There are total 30 subjects are participated in this study. 
*There are 6 activities("laying","sitting","standing","walking","walkingdownstairs","walkingupstairs")
*There are 66 desired features(e.g., fBodyAcc-mean()-X)
*Hence the total oberseration in the tidy dataset is 30 x 6 x 66 = 11880
*Refer to the CodeBook.md for a detailed explaination of this tidy dataset
