setwd('~/datascience/coursera_getdata/project/UCI\ HAR\ Dataset/')

##   STEP 1 
### Merges the training and the test sets to create one data set. ###
# first: train set
setwd('./train')
df_X_train <- read.table('X_train.txt') 
df_y_train <- read.table('y_train.txt')
df_subject_train <- read.table('subject_train.txt')

# second: test set
setwd('../test')
df_X_test <- read.table('X_test.txt') 
df_y_test <- read.table('y_test.txt')
df_subject_test <- read.table('subject_test.txt')

#now join the test and training sets
df_X_joint <- rbind(df_X_train,df_X_test)
df_y_joint <- rbind(df_y_train,df_y_test)
df_subject_joint <- rbind(df_subject_train,df_subject_test)

#now make them dyplr objects so I can use dplyr, tydyr
library(dplyr)
library(tidyr) 
tbl_X <- tbl_df(df_X_joint)
tbl_y <- tbl_df(df_y_joint)
tbl_subject <- tbl_df(df_subject_joint)

### STEP 2:
### Extracts only the measurements on the mean
###  and standard deviation for each measurement ###
## i.e. only the ones with -mean()  and -std(), explained in 'features.txt'

#first, get names from file 
features_df <- read.table('../features.txt')
colnames_X_joint <- as.vector(features_df$V2)

# ..using grep
selected_mean <- grep('-mean\\(\\)',colnames_X_joint)
selected_std <- grep('-std',colnames_X_joint)
selected_cols <- c(selected_mean,selected_std)
selected_cols <- sort(selected_cols)
selected_X_colnames <- colnames_X_joint[selected_cols]

#now get the selected columns
tbl_X_selected <- select(tbl_X,selected_cols)

### STEP 3: 
### Uses descriptive activity names to name the activities in the data set
## i.e. transform numbers into strings
activity_label = c('WALKING','WALKING_UPSTAIRS','WALKING_DOWNSTAIRS','SITTING','STANDING','LAYING')
# 'translating' number into activity
tbl_y <- mutate(tbl_y,activity=activity_label[V1])
# selecting only the activity
tbl_y <- select(tbl_y,activity)

### STEP 4:
### Appropriately labels the data set with descriptive variable names. 
#for activity, it's done 
# for subject
# for the rest of the variables - first clean up
selected_X_colnames <- sub('\\(\\)','',selected_X_colnames)
selected_X_colnames <- sub('-mean-','_MEAN_',selected_X_colnames)
selected_X_colnames <- sub('-std-','_STD_',selected_X_colnames)
names(tbl_X_selected) <- selected_X_colnames

### STEP 5:
### From the data set in step 4, creates a second, independent tidy data set 
### with the average of each variable for each activity and each subject.

#first I will merge the tables to new tbl_big
tbl_big <- bind_cols(tbl_subject,tbl_y,tbl_X_selected)
#then group by subject, activity
tbl_big <- group_by(tbl_big,subject,activity)
#then get the mean of the other variables using summarise_each
tbl_avg <- summarise_each(tbl_big,funs(mean))

#write table in text file
write.table(tbl_avg,'../tidy_data_fmarin.txt',sep=' ',row.names=FALSE)

