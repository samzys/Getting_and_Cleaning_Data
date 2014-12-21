CodeBook
========================

Variable list and descriptions
-----------------------------------

Variable name    | Description
-----------------|------------
subject          | ID of the subject who performed the activity(e.g., 1.2,...30)
activity         | Activity name(e.g.,sitting, laying, walking and etc)
domain           | the data is generated from time domain or frequency domain
device           | whether the data is collected from the accelerometer or gyroscope
acceleration     | whether it is a body acceleration signals or gravity acceleration signal)
mathMethod       | the mathmatic method used for the raw data (e.g, Mean or SD)
Jerk             | Jerk signal(derived from the body linear acceleration and angular velocity)
Magnitude        | Magnitude of the signals calculated using the Euclidean norm
axis             | 3-axis signals in the X, Y and Z directions
meanValue        | Average of each variable for each activity and each subject


tidyData Summary
---------------------------------
'data.frame':  11880 obs. of  10 variables:
 $ subject:     
 *int  1 2 3 4 5 6 7 8 9 10 ...30
 
 
 $ activities:  
 *Factor w/ 6 levels "laying","sitting","standing","walking","walkingdownstairs","walkingupstairs"
 
 $ domain:      
 -Factor w/ 2 levels "Time","Freq"
 
 $ device: 
 -Factor w/ 2 levels "Accelerometer","Gyroscope"
 
 $ acceleration: 
 -Factor w/ 3 levels NA,"Body","Gravity"
 
 
 $ mathMethod: 
 -Factor w/ 2 levels "Mean","Sd"
 
 
 $ jerk:
 -Factor w/ 2 levels NA,"Jerk"
 
 
 $ magnitude: 
 -Factor w/ 2 levels NA,"Mag"
 
 
 $ axis: 
 -Factor w/ 4 levels NA,"X","Y","Z"
 
 
 $ meanValue: 
 -num  0.222 0.281 0.276 0.264 0.278 ...
 - Min.   :-0.99767  
 -1st Qu.:-0.96205  
 -Median :-0.46989  
 -Mean   :-0.48436  
 -3rd Qu.:-0.07836  
 -Max.   : 0.97451 
