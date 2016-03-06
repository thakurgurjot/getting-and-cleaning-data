# getting and cleaning data-Codebook
Info about variables,data and transformtional processes used in this project.

# Dataset Information
The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed 
six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S). Using its embedded accelerometer
and gyroscope,3-axial linear acceleration and 3-axial angular velocity at a 
constant rate of 50Hz were captured.The experiments have been video-recorded to label the data manually. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers 
were selected for generating the training data and 30% the test data.

# Attribute Information:
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

  Description of abbreviations of measurements:
- leading t or f is based on time or frequency measurements.
- Body = related to body movement.
- Gravity = acceleration of gravity
- Acc = accelerometer measurement
- Gyro = gyroscopic measurements
- Jerk = sudden movement acceleration
- Mag = magnitude of movement


# Download the data 
 download the data directly from the given link and then unzip it or
 using download.file() in R and the unzipping it with unzip().
 Load the required packages:
- library(dplyr)
- library(data.table)
- library(tidyr)

 Read the data in the following files into tables:
 
 Subject files
 1. train/subject_train.txt
 2. test/subject_test.txt
 
 Activity files
 1. train/Y_train.txt
 2. test/Y_test.txt
 
 Data files
 1. train/X_train.txt
 2. test/X_test.txt
 
 - features.txt - names of column variables in dataTable
 - activity_labels.txt -linking the class labels with their activity names
 
 # section 1- Merging the Train and Test data set to form a single dataset
 rbind the subject files,activity files and data files separately.
 
 assign name variable according to features reading the "features.txt"-dataFeatures

 assign column names for activity labels using "activity_labels.txt" - activityLabels
 
 now merge columns of alldataSub and alldatAct forming a new table alldataSubACt using cbind()
 then cbind() the newly formed table with dataTable.
 
 
 # section 2 - extract only the measurements on the mean and standard 
   deviation for each measurement.
 -read dataFeatures and extract mean and std using grep function 
 -take measurements for mean and std and adding "Sub" and "ActNum" using union function - dataFeaturesMeanStd
 -form a new dataTable taking a subset of the previous dataTable selecting dataFeaturesMeanStd
 
 
 # section 3 - Use descriptive activity names to name the activity in the dataset
 
 merge activityLabesl and the most recent dataTable formed by the "ActNum"
 
 # section 4 - Appropriately label the dataset with descriptive variable names
 
 using the gsub function labels are renamed descritively. for eg.
 names(dataTable)<-gsub("std()", "SD", names(dataTable))
 names(dataTable)<-gsub("Acc", "Accelerometer", names(dataTable))
 
 #section 5 - create an independent tidy dataset with the average of each variable for each activity and each subject.
 
 using the aggregate function passing Fun as "mean" form a variable dataAggr.
 Arrange the created "dataAggr" with "Sub" and "ActNum" in the dataTable using tbl_df function.
 
 Write this dataTable in text using write.table.
 
 
