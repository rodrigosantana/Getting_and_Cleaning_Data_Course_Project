########################################################################
## Description: Getting and Cleaning Data Course Project
## 
## Maintainer: Johns Hopkins University/Coursera
## Author: Rodrigo Sant'Ana
## Created: Dom Mai 24 12:41:19 2015 (-0300)
## Version: 0.0.1
## Last-Updated: Dom Mai 24 17:03:03 2015 (-0300)
##           By: Rodrigo Sant'Ana
## 
## URL: github.com/rodrigosantana
## Doc URL: github.com/rodrigosantana
## 
## Database info:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
## 
### Commentary: This code is part of Course Project in Getting and
### Cleaning Data - Johns Hopkins University/Coursera
## 
### Code:
########################################################################

########################################################################
### Downloading data...

## creating a folder to storage the data files...
if(file.exists("data")) {
  print("Folder called data already exist")
} else {
  dir.create("data")
}

## downloading the data file in data folder...
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "data/Dataset.zip", method = "curl")

## unzip the data file inside the data folder...
unzip("data/Dataset.zip", exdir = "data")

## list the files unziped...
files <- list.files("data/UCI HAR Dataset")

########################################################################
### Loading files...

## Loading activity files...
act <- read.table("data/UCI HAR Dataset/activity_labels.txt",
                  col.names = c("ActivityId", "Activity"))
act.train <- read.table("data/UCI HAR Dataset/train/y_train.txt",
                        header = FALSE)
act.test <- read.table("data/UCI HAR Dataset/test/y_test.txt",
                       header = FALSE)

## Loading subject files..
subj.train <- read.table("data/UCI HAR Dataset/train/subject_train.txt",
                         header = FALSE)
subj.test <- read.table("data/UCI HAR Dataset/test/subject_test.txt",
                        header = FALSE)

## Loading features files...
feat.train <- read.table("data/UCI HAR Dataset/train/X_train.txt",
                         header = FALSE)
feat.test <- read.table("data/UCI HAR Dataset/test/X_test.txt",
                        header = FALSE)
features <- read.table("data/UCI HAR Dataset/features.txt",
                       header = FALSE)
features[,2] <- as.character(features[,2])

########################################################################
### Concatenating data files...

## data ...
train <- cbind(cbind(feat.train, subj.train), act.train)
test <- cbind(cbind(feat.test, subj.test), act.test)
data <- rbind(train, test)

## labels ...
labs <- rbind(rbind(features, c(562, "Subject")),
              c(563, "ActivityId"))[,2]
names(data) <- labs

########################################################################
### Extract mean and standard deviation of each measurement in data...
mean.std <- data[,grepl("mean|std|Subject|ActivityId", names(data))]
out <- merge(mean.std, act, by = "ActivityId")

########################################################################
### Standardizing variables names in data object...
for(i in 1:length(out)) {
  names(out)[i] <- gsub("\\()", "", names(out)[i])
  names(out)[i] <- gsub("-std", "Std.Dev.", names(out)[i])
  names(out)[i] <- gsub("-mean", "Mean.", names(out)[i])
  names(out)[i] <- gsub("Body|BodyBody", "Body", names(out)[i])
  names(out)[i] <- gsub("Acc", "Acceleration.", names(out)[i])
  names(out)[i] <- gsub("GyroJerk", "Angular.Acceleration.",
                        names(out)[i])
  names(out)[i] <- gsub("Gyro", "Angular.Speed.", names(out)[i])
  names(out)[i] <- gsub("Mag", "Magnitude.", names(out)[i])
  names(out)[i] <- gsub("^t", "Time.Domain.", names(out)[i])
  names(out)[i] <- gsub("^f", "Frequency.Domain.", names(out)[i])
}

########################################################################
### Creating a new object with the average for each activity and each
### subject...
out.avg <- ddply(out, c("Subject", "Activity"), numcolwise(mean))

########################################################################
### Exporting the average object...
write.table(out.avg, file = "activity_subject_avg.txt",
            row.names = FALSE)

########################################################################
## 
## The MIT License (MIT)
## 
## Copyright (c) 2014 Rodrigo Sant'Ana
## 
## Permission is hereby granted, free of charge, to any person obtaining a
## copy of this software and associated documentation files (the
## 'Software'), to deal in the Software without restriction, including
## without limitation the rights to use, copy, modify, merge, publish,
## distribute, sublicense, and/or sell copies of the Software, and to
## permit persons to whom the Software is furnished to do so, subject to
## the following conditions:
## 
## The above copyright notice and this permission notice shall be
## included in all copies or substantial portions of the Software.
## 
## THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
## EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
## OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
## NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
## BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
## ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
## CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
## SOFTWARE.
## 
########################################################################
