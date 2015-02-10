# run_analysis.R
# Author : Jeff Hohenstein
#
# Purpose :
#   "Getting and Cleaning Data" getdata-016 course project
#   This script is the "master" script that runs the analysis
#   This script assumes it is being run in the directory where it is found.

# Imports
library(dplyr)


# Load the two data sets (test and train) and concatenate them
#
# @return concatenated data set
loadData <- function() {
  
  files <- c(
    "./data/test/X_test.txt",
    "./data/train/X_train.txt"
  )
  
  # Check that the files exist
  for(f in files){
    if(!file.exists(f))
      error(paste("Data set was not found where expected (",f,")."))
  }

  data <- matrix(,nrow=0,ncol=561)
  for(f in files){
    message(paste("Loading file (",f,")",sep=""))
    data <- rbind(data,read.fwf(f,rep(16,561),header = FALSE))
    message("Subject data set structure after loading:")
    message(str(data))
  }
  
  data
}

# Load the subject data to match the test/train measurement data
#
# @return subjects
loadSubjects <- function(){  
  files <- c(
    "./data/test/subject_test.txt",
    "./data/train/subject_train.txt"
  )
  
  # Check that the files exist
  for(f in files){
    if(!file.exists(f))
      error(paste("Data set was not found where expected (",f,")."))
  }
  
  data <- matrix(,nrow=0,ncol=1)
  for(f in files){
    message(paste("Loading file (",f,")",sep=""))
    data <- rbind(data,read.csv(f,header = FALSE))
    message("Subject data set structure after loading:")
    message(str(data))
  }
  
  colnames(data) <- c("subjectId")
  
  data
  
}

# Loads labels (column names) from a file.
#
# @return array of labels in the correct order
loadLabels <- function() {
  fileName <- "./data/features.txt"
  
  if(!file.exists(fileName))
    error(paste("Labels file (",fileName,") was not found where expected.",sep=FALSE))
  
  message(paste("Loading file (",fileName,")",sep=""))
  features <- read.csv(fileName,sep=" ",header=FALSE,stringsAsFactors=FALSE)
  message("Label data set structure after loading:")
  message(str(features))
  
  features[,2]
}

# Load activities
#
# @return activities, a data frame with 2 columns, the first the PK, the second the label
loadActivities <- function() {
  activities <- read.csv("data/activity_labels.txt",sep=" ",header=FALSE,stringsAsFactors=FALSE)
  message("Activity data set structure after loading:")
  message(str(activities))
  colnames(activities) <- c("activityId","activityName")
  activities
}

# Load data activity keys
#
# Same as loadData(), load the activity keys that correspond to the numeric data
#
# @return activity keys in the same order as loadData()
loadDataActivities <- function() {
  files <- c(
    "./data/test/y_test.txt",
    "./data/train/y_train.txt"
  )
  
  # Check that the files exist
  for(f in files){
    if(!file.exists(f))
      error(paste("Data set was not found where expected (",f,")."))
  }
  
  activities <- data.frame(activityId = c())
  for(f in files){
    message(paste("Loading file (",f,")",sep=""))
    activities <- rbind(activities,read.csv(f,header = FALSE))
    message("Activity data set structure after loading:")
    message(str(activities))
  }
  
  colnames(activities) <- c("activityId")
  activities
  
}

# Summarize the data set grouping by Activity and Subject into a single 
# "tidy" data set.
#
# @param data The data set to summarize
# @return summarized data set grouped by Activity and Subject and with
#         labels replaced to account for summarization
createSummaryByActivityAndSubject <- function(data) {
  table <- tbl_df(data)

  # Group and summarize the data
  summaryData <- table %>% group_by(activityId,activityName,subjectId) %>% summarise_each(funs(mean))
  
  # Relabel the summary data to enclose variable names in "mean"
  metricColumns <- ! colnames(summaryData) %in% c("activityId","subjectId","activityName")
  colnames(summaryData)[metricColumns] <- paste("mean('",colnames(summaryData)[metricColumns],"')",sep="")
  
  message("Summary data set dimensions:")
  message(str(summaryData))
  
  summaryData
}

# Load the data, apply labels, and reduce the columns
#
# @return tidy data set
loadAndTidyData <- function(){
  # Load data
  message("Loading data")
  data <- loadData()
  
  # Load and apply labels
  message("Loading labels")
  labels <- loadLabels()
  colnames(data) <- labels
  
  # Filter columns to only mean and standard deviation, do not include angle() measures
  filteredLabels <- labels[intersect(grep("^angle",labels,invert=TRUE), grep("[mM]ean|[sS]td",labels))]
  data <- data[,filteredLabels]
  
  # Load activityIds for the data and append
  message("Loading activities")
  data <- cbind(data,loadDataActivities())
  
  # Load a table with activity names
  activities <- loadActivities()
  
  # Load subjectIds for the data and append
  message("Loading subjects")
  data <- cbind(data,loadSubjects())
  
  # Join the activity names to the data by Id
  data <- merge(data,activities,by="activityId")
  
  # Generate the tidy summary data set
  createSummaryByActivityAndSubject(data)
}

# Main
#
# Do the tidying and generate the data set
main <- function() {
  if(!file.exists("data/"))
    error("It appears you are in the wrong directory.")

  tidy <- loadAndTidyData()
  
  message("Writing file with tidy data.")
  write.table(file="tidy.txt",tidy,row.names=FALSE)
  
}

# Upon sourcing this file, run it
main()
