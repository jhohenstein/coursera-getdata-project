# Codebook for Getting and Cleaning Data - Course Project

The following document represents a modified version of the "feature_info.txt" document that is included with the UCI HAR data set found here :

<code>https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip</code>

## Features 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag


## Tidy data set

This section describes the modifications made to the original data set to produce the tidy data set.

## Class Variables

The following columns present the classes or groups for the summarized data present in "tidy.txt".

* activityId : the unique identifier for the activity the subject performed (e.g. WALKING, RUNNING, ...)
* activityName : the text name for the activity.
* subjectid : the unique identifier of the subject who performed the activity.

## Numeric Variables

The original accelerometer data can be found in the "./data" directory. 

The meanings of the variables can be found in "./data/features_info.txt". As a brief summary, consider a column in the result set named :

mean('tBodyAcc-std()-Y')

* The enclosing mean('...') indicates it is the arithmetic mean of all values present.
* The "t" indicates it is a variable in the time domain versus the frequency domain. If an "f" is present it indicates that the value is in the frequency domain.
* The "BodyAcc" indicates it represents the acceleration by the subject rather than by gravity. 
* The "std()" indicates it is the standard deviation of the measurements of "tBodyAcc".
* the "-Y" indcates that the measurement was taken along the "Y" axis. 

The column labels in the resulting data file were preserved from the original data but surrounded by "mean('...')". For example, "tBodyAcc-mean()-X" in the original data set became "mean('tBodyAcc-mean()-X')" in the resulting data set. 

Only those columns containing the text "mean" and "std" were retained while excluding those that began with "angle(". The "angle(" measurements were excluded because these represent the angle between two measurements but the instructions for the assignment specified that only mean and standard deviation measurements should be retained.

For all measurements, a mean was computed for a single subject performing a single activity. Thus, there is exactly one row in summary data set for each unique combination of activityId and subjectId.
