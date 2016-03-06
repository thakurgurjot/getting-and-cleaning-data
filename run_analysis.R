library(dplyr)
library(data.table)
library(tidyr)

filePath <- "/Users/Thakur24/Desktop/R course gacd/UCI HAR Dataset" ##downloaded externally

dataSubTrain <- tbl_df(read.table(file.path(filePath, "train", "subject_train.txt")))
dataSubTest  <- tbl_df(read.table(file.path(filePath, "test" , "subject_test.txt" )))

dataActTrain <- tbl_df(read.table(file.path(filePath, "train", "Y_train.txt")))
dataActTest  <- tbl_df(read.table(file.path(filePath, "test" , "Y_test.txt" )))

dataTrain <- tbl_df(read.table(file.path(filePath, "train", "X_train.txt" )))
dataTest  <- tbl_df(read.table(file.path(filePath, "test" , "X_test.txt" )))

dataFeatures <- tbl_df(read.table(file.path(filePath, "features.txt")))
activityLabels<- tbl_df(read.table(file.path(filePath, "activity_labels.txt")))


## for both Activity and Sub files this will merge the training and the test sets by row binding 
## and rename variables "Sub" and "ActNum"
alldataSub <- rbind(dataSubTrain, dataSubTest)
setnames(alldataSub, "V1", "Sub")
alldataAct<- rbind(dataActTrain, dataActTest)
setnames(alldataAct, "V1", "ActNum")

##combine the DATA training and test files
dataTable <- rbind(dataTrain, dataTest)

## name variables according to feature e.g.(V1 = "tBodyAcc-mean()-X")

setnames(dataFeatures, names(dataFeatures), c("featureNum", "featureName"))
colnames(dataTable) <- dataFeatures$featureName

## column names for activity labels

setnames(activityLabels, names(activityLabels), c("ActNum","ActName"))

## Merge columns
alldataSubjAct<- cbind(alldataSub, alldataAct)
dataTable <- cbind(alldataSubjAct, dataTable)





## Reading "features.txt" and extracting only the mean and standard deviation
dataFeaturesMeanStd <- grep("mean\\(\\)|std\\(\\)",dataFeatures$featureName,value=TRUE)

## Taking only measurements for the mean and standard deviation and add "Sub,"ActNum"
dataFeaturesMeanStd <- union(c("Sub","ActNum"), dataFeaturesMeanStd)
dataTable<- subset(dataTable,select=dataFeaturesMeanStd)






##enter name of activity into dataTable
dataTable <- merge(activityLabels, dataTable , by="ActNum", all.x=TRUE)
dataTable$ActName <- as.character(dataTable$ActName)

## create dataTable with variable means sorted by subject and Activity

dataAggr<- aggregate(. ~ Sub - ActName, data = dataTable, mean) 
dataTable<- tbl_df(arrange(dataAggr,Sub,ActName))


## appropriate labelling
names(dataTable)<-gsub("std()", "SD", names(dataTable))
names(dataTable)<-gsub("mean()", "MEAN", names(dataTable))
names(dataTable)<-gsub("^t", "time", names(dataTable))
names(dataTable)<-gsub("^f", "frequency", names(dataTable))
names(dataTable)<-gsub("Acc", "Accelerometer", names(dataTable))
names(dataTable)<-gsub("Gyro", "Gyroscope", names(dataTable))
names(dataTable)<-gsub("Mag", "Magnitude", names(dataTable))
names(dataTable)<-gsub("BodyBody", "Body", names(dataTable))

write.table(dataTable, "Tidydata.txt", row.name=FALSE)

