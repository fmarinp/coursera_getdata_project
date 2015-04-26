## Coursera: Getting and Cleaning Data ##
### Course Project, April 2015 ###
*Felipe Marin*

We received data collected from the accelerometers from the Samsung Galaxy S smartphone, available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
The goal is to prepare 'tidy data' that can be used for later analysis. There data come from experiments carried out on 30 individuals (identified by a number id) performing 
six 'ACTIVITIES'.  There are two sets of obervations, the 'training' set and the 'testing' set. 

the  R script in this repo - run_analysis.R - collects the raw data and produced a tidy data set, in the following way

1. Merges the training and the test sets to create one data set.
  - Using the command 'read.table', three data frames are created - one for the subjects, one for the activity, and one for the different measurements in a particular time (observation)
  - There are 10,299 observations in total (merging the training and testing sets)
  - Then I load the dplyr and tidyr packages and transform the data frames to the table format to use the packages' tools using the 'tbl_df' command

2. Extract only the measurements on the mean and standard deviation for each measurement
  - The variables measured are in the file 'features.txt' and I select the ones with mean- or std- (for standard dev) using grep to get the column number
  - then using the select() command I extract the columns I am interested in. 
  
3. Use descriptive activity names to name the activities in the data set
  - Since the activities in the file 'subject_test' are displayed only by a number, we use the command  mutate() to 'translate' a number to an activity
  
4. Appropriately I label the data set with descriptive variable names. 
  - Here I use the sub() command to substitute parethesis and hyphens to get readeable names - described below

5. From the data set in step 4, I create a second, independent tidy data set with the average of each variable for each activity and each subject.
  - Here I choose to present a 'wide' format where in each row information on the subject, activity and all measurements are in different columns. This will make in my opinion,
the analysis easier when relations between different variables are studied. 
  - Using the command bind_cols() I join the 3 tables 
  - then using the group_by command I order the table on subject and activity
  - Using, finally, the summarise_each() command I obtain the mean for measurements in each column
  - I obtain a new table (tidy_data_fmarin) with the average of the observations by subject & activity for each measurement, writen in a txt file. There are then 180 rows of 66 variables


### Codebook ### 
Columns:
  1. subject -- Identified by an integer 
  2. activity -- nature of activity recorded (description)

The rest: Means of the mean  (MEAN) and standard deviations (STD) of sensors for different signals. 
  3.	tBodyAcc_MEAN_X
  4.	tBodyAcc_MEAN_Y
  5.	tBodyAcc_MEAN_Z
  6.	tBodyAcc_STD_X
  7.	tBodyAcc_STD_Y
  8.	tBodyAcc_STD_Z
  9.	tGravityAcc_MEAN_X
  10.	tGravityAcc_MEAN_Y
  11.	tGravityAcc_MEAN_Z
  12.	tGravityAcc_STD_X
  13.	tGravityAcc_STD_Y
  14.	tGravityAcc_STD_Z
  15.	tBodyAccJerk_MEAN_X
  16.	tBodyAccJerk_MEAN_Y
  17.	tBodyAccJerk_MEAN_Z
  18.	tBodyAccJerk_STD_X
  19.	tBodyAccJerk_STD_Y
  20.	tBodyAccJerk_STD_Z
  21.	tBodyGyro_MEAN_X
  22.	tBodyGyro_MEAN_Y
  23.	tBodyGyro_MEAN_Z
  24.	tBodyGyro_STD_X
  25.	tBodyGyro_STD_Y
  26.	tBodyGyro_STD_Z
  27.	tBodyGyroJerk_MEAN_X
  28.	tBodyGyroJerk_MEAN_Y
  29.	tBodyGyroJerk_MEAN_Z
  30.	tBodyGyroJerk_STD_X
  31.	tBodyGyroJerk_STD_Y
  32.	tBodyGyroJerk_STD_Z
  33.	tBodyAccMag-mean
  34.	tBodyAccMag-std
  35.	tGravityAccMag-mean
  36.	tGravityAccMag-std
  37.	tBodyAccJerkMag-mean
  38.	tBodyAccJerkMag-std
  39.	tBodyGyroMag-mean
  40.	tBodyGyroMag-std
  41.	tBodyGyroJerkMag-mean
  42.	tBodyGyroJerkMag-std
  43.	fBodyAcc_MEAN_X
  44.	fBodyAcc_MEAN_Y
  45.	fBodyAcc_MEAN_Z
  46.	fBodyAcc_STD_X
  47.	fBodyAcc_STD_Y
  48.	fBodyAcc_STD_Z
  49.	fBodyAccJerk_MEAN_X
  50.	fBodyAccJerk_MEAN_Y
  51.	fBodyAccJerk_MEAN_Z
  52.	fBodyAccJerk_STD_X
  53.	fBodyAccJerk_STD_Y
  54.	fBodyAccJerk_STD_Z
  55.	fBodyGyro_MEAN_X
  56.	fBodyGyro_MEAN_Y
  57.	fBodyGyro_MEAN_Z
  58.	fBodyGyro_STD_X
  59.	fBodyGyro_STD_Y
  60.	fBodyGyro_STD_Z
  61.	fBodyAccMag-mean
  62.	fBodyAccMag-std
  63.	fBodyBodyAccJerkMag-mean
  64.	fBodyBodyAccJerkMag-std
  65.	fBodyBodyGyroMag-mean
  66.	fBodyBodyGyroMag-std
  67.	fBodyBodyGyroJerkMag-mean
  68. fBodyBodyGyroJerkMag-std

From the 'features.info' file in the raw data:
Feature Selection 
=================
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


