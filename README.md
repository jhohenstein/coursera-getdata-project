= README for Getting and Cleaning Data - Course Project

The purpose of this project is to demonstrate the ability to manipulate real-world data sets using the R and the tools learned to date in the Coursera - Johns Hopkins Data Science Signature Track of courses.


== Usage

When "run_analysis.R" is sourced, it immediately runs to load the source data, compute and then output the tidy data set requested in the assignment.

== Version of software used

The analysis was written and performed under Ubuntu. The following is the output of "uname -a" :

		Linux Zazen 3.13.0-43-generic #72-Ubuntu SMP Mon Dec 8 19:35:06 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

Following is the output of "sessionInfo()" in R where the analysis was written and performed :

		R version 3.1.2 RC (2014-10-24 r66864)
		Platform: x86_64-pc-linux-gnu (64-bit)

		locale:
		 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
		 [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
		 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
		 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
		 [9] LC_ADDRESS=C               LC_TELEPHONE=C            
		[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       

		attached base packages:
		[1] stats     graphics  grDevices utils     datasets  methods   base     

It uses the "dplyr" package version "dplyr_0.3.0.2". 

== Files

		README.me

This file.

		Codebook.md

The codebook describing the variables contained in the resulting summary data set "tidy.txt".

		run_analysis.R

This file contains the program to load and manipulate the data to produce the tidy data set.

		tidy.txt

This file is the output of run_analysis.R


		getdata-projectfiles-UCI HAR Dataset.zip

The original zip file containing the data set.

		data/

A directory containing the extracted UCI HAR Dataset. The data set contains its own README and feature information.

== Summary of Manipulations

The following pseudocode follows loadAndTidyData() with the exception of writing the final tidy data file.

1. Load both the test and training accelerometer data sets from "./data/[test|train]/X_[test|train].txt" and append the training set to the test set. These files contain floating point numbers in a fixed width file format so they were loaded as numbers. The output of this manipulation is a working set with 10299 observations and 561 variables.
2. Load column labels for the accelerometer data sets from "./data/features.txt". These were filtered to look for labels that contained "mean" or "std" names but exclude angle columns. Angle columns were excluded because they computed the angle between the mean and some value and were not themselves a mean. The working set was filtered so that only the "mean" and "std" columns were retained.
3. Load activity labels from ./data/[test|train]/y_[test|train].txt" and prepend the column to the working set, naming the column "activityId".
4. Load the data set containing the map between activity Ids and activity names from "./data/activity_labels.txt".
5. Load the subject identifiers from "./data/[test|train]/[test|train]and prepend them to the working set, naming the column "subjectId".
6. Merge the data set containing the activityId <-> activityName map with the working set joining on the activityId column. The working set now contains both an activityId and activityName column.
7. Summarize the working set. The working set was first grouped on subjectId, activityId, and activityName. All other columns were averaged by the mean function. The summary data set thus contained 180 observations (30 subjects x 6 activities) and 82 variables (3 for subjectId,activityId,activityName and 79 for the mean/std variables).
8. The summary data set was written out to a file "tidy.txt" in the working directory using "write.table".
