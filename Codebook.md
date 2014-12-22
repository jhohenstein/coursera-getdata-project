# Codebook for Getting and Cleaning Data - Course Project

## Class variables

The following columns present the classes or groups for the summarized data present in "tidy.txt".

* activityId : the unique identifier for the activity the subject performed (e.g. WALKING, RUNNING, ...)
* activityName : the text name for the activity.
* subjectid : the unique identifier of the subject who performed the activity.

## Measurements

The original accelerometer data can be found in the "./data" directory. 

The meanings of the variables can be found in "./data/features_info.txt". As a brief summary, consider a column in the result set named :

mean('tBodyAcc-std()-Y')

* The enclosing mean('...') indicates it is the arithmetic mean of all values present.
* The "t" indicates it is a variable in the time domain versus the frequency domain.
* The "BodyAcc" indicates it represents the acceleration by the subject rather than by gravity.
* The "std()" indicates it is the standard deviation of the measurements of "tBodyAcc".
* the "-Y" indcates that the measurement was taken along the "Y" axis. 

The column labels in the resulting data file were preserved from the original data but surrounded by "mean('...')". For example, "tBodyAcc-mean()-X" in the original data set became "mean('tBodyAcc-mean()-X')" in the resulting data set. 

Only those columns containing the text "mean" and "std" were retained while excluding those that began with "angle(". The "angle(" measurements were excluded because these represent the angle between two measurements but the instructions for the assignment specified that only mean and standard deviation measurements should be retained.

For all measurements, a mean was computed for a single subject performing a single activity. Thus, there is exactly one row in summary data set for each unique combination of activityId and subjectId.
