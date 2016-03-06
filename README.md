# getting-and-cleaning-data
repo for submission of course project-Getting and Cleaning Data(Coursera-2016)

# Overview
In this project we determine the usefulness of collecting and cleaning of data for furture analysis.
Description of the data to be used in the project can be found here->  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones .

source of the data -> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# choosing and setting directory
once the data is downloaded and unzipped in a folder,change the working directory to that folder either by 
using misc option in R or using setwd() command in script.

# Summary
R script is written by the name of run_analysis.R and it helps us achieve the following requirements of the project :
1. Merges the training and the test sets to create one data set. 
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Additional Info
Information about the variables,data and transformational process can be found in Codebook.md file.
